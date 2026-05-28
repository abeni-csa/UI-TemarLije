import 'package:sqflite/sqflite.dart';
import 'package:ui_temarlije/data/models/attendance_record.dart' hide Student;
import 'package:ui_temarlije/model/student.dart';
import 'package:ui_temarlije/service/database_service.dart';

class AttendanceRepository {
  final LocalDatabaseService _db = LocalDatabaseService();

  Future<List<AttendanceRecord>> getAttendanceByDate(DateTime date) async {
    final database = await _db.database;
    final dateStr = date.toIso8601String().split('T')[0];

    final result = await database.query(
      'attendance_records',
      where: 'date LIKE ?',
      whereArgs: ['$dateStr%'],
    );

    return result
        .map((row) => AttendanceRecord.fromJson(_convertRow(row)))
        .toList();
  }

  Future<void> saveAttendance(AttendanceRecord record) async {
    final database = await _db.database;
    await database.insert(
      'attendance_records',
      record.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Student>> getStudentsByClass(String className) async {
    final database = await _db.database;
    final result = await database.query(
      'student_marks',
      distinct: true,
      columns: ['student_id', 'student_name'],
      where: 'student_id IS NOT NULL',
    );

    return result
        .map(
          (row) => Student(
            id: row['student_id'] as String,
            name: row['student_name'] as String,
          ),
        )
        .toList();
  }

  Map<String, dynamic> _convertRow(Map<String, dynamic> row) {
    final map = Map<String, dynamic>.from(row);
    // Convert SQLite types to expected types
    if (map['is_read'] is int) map['is_read'] = map['is_read'] == 1;
    return map;
  }
}
