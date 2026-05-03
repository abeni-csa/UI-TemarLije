import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:ui_temarlije/model/student.dart';
import 'package:ui_temarlije/model/column_config.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  static Database? _database;

  DatabaseService._internal();

  factory DatabaseService() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'gradebook.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    // Create metadata table to store app configuration
    await db.execute('''
      CREATE TABLE app_metadata (
        key TEXT PRIMARY KEY,
        value TEXT,
        updated_at INTEGER
      )
    ''');

    // Create table for student data
    await db.execute('''
      CREATE TABLE student_marks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        student_id TEXT NOT NULL,
        student_name TEXT NOT NULL,
        column_name TEXT NOT NULL,
        mark_value TEXT,
        updated_at INTEGER,
        UNIQUE(student_id, column_name)
      )
    ''');

    // Initialize A Section students
    await _initializeStudents(db);
  }

  Future<void> _initializeStudents(Database db) async {
    // Get existing students
    final existing = await db.query(
      'student_marks',
      distinct: true,
      columns: ['student_id', 'student_name'],
    );
    if (existing.isNotEmpty) return;

    final students = [
      Student(id: 'S001', name: 'Ayush Sharma'),
      Student(id: 'S002', name: 'Vikram Singh'),
      Student(id: 'S003', name: 'Neha Verma'),
      Student(id: 'S004', name: 'Rohan Mehta'),
      Student(id: 'S005', name: 'Priya Kapoor'),
      Student(id: 'S006', name: 'Arjun Nair'),
      Student(id: 'S007', name: 'Divya Reddy'),
      Student(id: 'S008', name: 'Kunal Joshi'),
      Student(id: 'S009', name: 'Ananya Desai'),
      Student(id: 'S010', name: 'Rahul Khanna'),
    ];

    // For each student, create baseline records so they appear in all columns
    for (var student in students) {
      await db.insert('student_marks', {
        'student_id': student.id,
        'student_name': student.name,
        'column_name': '_student_info', // special column for student data
        'mark_value': student.name,
        'updated_at': DateTime.now().millisecondsSinceEpoch,
      });
    }
  }

  // Get all columns from metadata
  Future<List<ColumnConfig>> getColumns() async {
    final db = await database;
    final result = await db.query(
      'app_metadata',
      where: 'key = ?',
      whereArgs: ['columns'],
    );

    if (result.isEmpty) {
      // Return default grade columns
      return [
        ColumnConfig(id: 'col1', name: 'Assignment 1', type: 'mark'),
        ColumnConfig(id: 'col2', name: 'Assignment 2', type: 'mark'),
        ColumnConfig(id: 'col3', name: 'Midterm', type: 'mark'),
      ];
    }

    final columnsJson = result.first['value'] as String;
    final List<dynamic> decoded = jsonDecode(columnsJson);
    return decoded.map((j) => ColumnConfig.fromJson(j)).toList();
  }

  // Save columns configuration
  Future<void> saveColumns(List<ColumnConfig> columns) async {
    final db = await database;
    final columnsJson = jsonEncode(columns.map((c) => c.toJson()).toList());
    await db.insert('app_metadata', {
      'key': 'columns',
      'value': columnsJson,
      'updated_at': DateTime.now().millisecondsSinceEpoch,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Get all students with their marks for all columns
  Future<List<StudentWithMarks>> getAllStudentsWithMarks() async {
    final db = await database;
    final columns = await getColumns();
    final result = await db.query('student_marks');

    // Group marks by student
    final Map<String, StudentWithMarks> studentsMap = {};

    for (var row in result) {
      final studentId = row['student_id'] as String;
      final studentName = row['student_name'] as String;
      final columnName = row['column_name'] as String;
      final markValue = row['mark_value'] as String? ?? '';

      if (!studentsMap.containsKey(studentId)) {
        // Initialize student with default empty marks
        final marks = <String, String>{};
        // Pre-initialize all columns to empty string for this student
        for (var column in columns) {
          marks[column.name] = '';
        }
        studentsMap[studentId] = StudentWithMarks(
          id: studentId,
          name: studentName,
          marks: marks,
        );
      }

      // Update mark if this is a grade column (not the special student_info)
      if (columnName != '_student_info') {
        studentsMap[studentId]!.marks[columnName] = markValue;
      }
    }

    return studentsMap.values.toList();
  }

  // Update a mark for a specific student and column
  Future<void> updateMark(
    String studentId,
    String columnName,
    String value,
  ) async {
    final db = await database;
    await db.insert('student_marks', {
      'student_id': studentId,
      'column_name': columnName,
      'mark_value': value,
      'updated_at': DateTime.now().millisecondsSinceEpoch,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Add a new column
  Future<void> addColumn(ColumnConfig newColumn) async {
    final columns = await getColumns();
    columns.add(newColumn);

    // Save updated columns config
    await saveColumns(columns);

    // Get all students
    final db = await database;
    final students = await db.query(
      'student_marks',
      distinct: true,
      columns: ['student_id', 'student_name'],
    );

    // For each student, create an empty mark record for this new column
    for (var student in students) {
      await db.insert('student_marks', {
        'student_id': student['student_id'],
        'student_name': student['student_name'],
        'column_name': newColumn.name,
        'mark_value': '',
        'updated_at': DateTime.now().millisecondsSinceEpoch,
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  // Remove a column
  Future<void> removeColumn(String columnName) async {
    final columns = await getColumns();
    columns.removeWhere((col) => col.name == columnName);
    await saveColumns(columns);

    // Delete all mark records for this column
    final db = await database;
    await db.delete(
      'student_marks',
      where: 'column_name = ?',
      whereArgs: [columnName],
    );
  }

  /// Bulk update marks for a single column across all students
  Future<void> bulkUpdateColumn(
    String columnName,
    Map<String, String> studentMarks,
  ) async {
    final db = await database;
    try {
      await db.transaction((txn) async {
        for (final entry in studentMarks.entries) {
          final studentId = entry.key;
          final markValue = entry.value;
          await txn.insert('student_marks', {
            'student_id': studentId,
            'column_name': columnName,
            'mark_value': markValue,
            'updated_at': DateTime.now().millisecondsSinceEpoch,
          }, conflictAlgorithm: ConflictAlgorithm.replace);
        }
      });
    } catch (e) {
      throw Exception('Bulk update failed: $e');
    }
  }

  /// Bulk update all marks for a single student
  Future<void> bulkUpdateStudent(
    String studentId,
    Map<String, String> columnMarks,
  ) async {
    final db = await database;
    try {
      await db.transaction((txn) async {
        for (final entry in columnMarks.entries) {
          final columnName = entry.key;
          final markValue = entry.value;
          await txn.insert('student_marks', {
            'student_id': studentId,
            'column_name': columnName,
            'mark_value': markValue,
            'updated_at': DateTime.now().millisecondsSinceEpoch,
          }, conflictAlgorithm: ConflictAlgorithm.replace);
        }
      });
    } catch (e) {
      throw Exception('Bulk update failed for student $studentId: $e');
    }
  }
}
