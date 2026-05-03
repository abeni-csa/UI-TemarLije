import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui_temarlije/service/database_service.dart';
import 'package:ui_temarlije/model/student.dart';
import 'package:ui_temarlije/model/column_config.dart';
import 'dart:developer' as developer;

class TableState {
  final List<StudentWithMarks> students;
  final List<ColumnConfig> columns;
  final bool isLoading;
  final String? errorMessage;

  TableState({
    required this.students,
    required this.columns,
    this.isLoading = false,
    this.errorMessage,
  });

  TableState copyWith({
    List<StudentWithMarks>? students,
    List<ColumnConfig>? columns,
    bool? isLoading,
    String? errorMessage,
  }) {
    return TableState(
      students: students ?? this.students,
      columns: columns ?? this.columns,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class TableNotifier extends AsyncNotifier<TableState> {
  @override
  Future<TableState> build() async => _loadInitialData();

  Future<TableState> _loadInitialData() async {
    try {
      final db = DatabaseService();
      final columns = await db.getColumns();
      final students = await db.getAllStudentsWithMarks();
      return TableState(students: students, columns: columns);
    } catch (e) {
      return TableState(students: [], columns: [], errorMessage: e.toString());
    }
  }

  Future<void> refresh() async {
    state = await AsyncValue.guard(() => _loadInitialData());
  }

  Future<void> updateMark(
    String studentId,
    String columnName,
    String value,
  ) async {
    if (!state.hasValue) return; // No data to update
    final currentState = state.requireValue;

    // Optimistic update
    final updatedStudents = currentState.students.map((student) {
      if (student.id == studentId) {
        final updatedMarks = Map<String, String>.from(student.marks);
        updatedMarks[columnName] = value;
        return StudentWithMarks(
          id: student.id,
          name: student.name,
          marks: updatedMarks,
        );
      }
      return student;
    }).toList();

    state = AsyncValue.data(currentState.copyWith(students: updatedStudents));

    // Persist to DB (fire-and-forget, but you could handle errors)
    try {
      final db = DatabaseService();
      await db.updateMark(studentId, columnName, value);
      developer.log('Mark updated: $studentId, $columnName = $value');
    } catch (e) {
      developer.log('Failed to persist mark: $e');
      // Revert optimistic update by reloading
      await refresh();
    }
  }

  Future<void> addColumn(String columnName) async {
    if (columnName.trim().isEmpty) return;
    try {
      final db = DatabaseService();
      await db.addColumn(
        ColumnConfig(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          name: columnName.trim(),
          type: 'mark',
        ),
      );
      await refresh();
      developer.log('Column added: $columnName');
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> removeColumn(String columnName) async {
    try {
      final db = DatabaseService();
      await db.removeColumn(columnName);
      await refresh();
      developer.log('Column removed: $columnName');
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> bulkUpdateColumn(
    String columnName,
    Map<String, String> studentMarks,
  ) async {
    if (!state.hasValue) return;
    final currentState = state.requireValue;

    // Optimistic UI update
    final updatedStudents = currentState.students.map((student) {
      final newMark = studentMarks[student.id];
      if (newMark != null) {
        final updatedMarks = Map<String, String>.from(student.marks);
        updatedMarks[columnName] = newMark;
        return StudentWithMarks(
          id: student.id,
          name: student.name,
          marks: updatedMarks,
        );
      }
      return student;
    }).toList();

    state = AsyncValue.data(currentState.copyWith(students: updatedStudents));

    // Persist to DB
    try {
      final db = DatabaseService();
      await db.bulkUpdateColumn(columnName, studentMarks);
      developer.log('Bulk updated column: $columnName');
    } catch (e) {
      developer.log('Bulk update failed, reloading data: $e');
      await refresh(); // revert to DB state
    }
  }

  Future<void> bulkUpdateStudent(
    String studentId,
    Map<String, String> columnMarks,
  ) async {
    if (!state.hasValue) return;
    final currentState = state.requireValue;

    // Optimistic UI update
    final updatedStudents = currentState.students.map((student) {
      if (student.id == studentId) {
        final updatedMarks = Map<String, String>.from(student.marks);
        updatedMarks.addAll(columnMarks);
        return StudentWithMarks(
          id: student.id,
          name: student.name,
          marks: updatedMarks,
        );
      }
      return student;
    }).toList();

    state = AsyncValue.data(currentState.copyWith(students: updatedStudents));

    try {
      final db = DatabaseService();
      await db.bulkUpdateStudent(studentId, columnMarks);
      developer.log('Bulk updated student: $studentId');
    } catch (e) {
      developer.log('Bulk update failed, reloading data: $e');
      await refresh();
    }
  }
}

final tableProvider = AsyncNotifierProvider<TableNotifier, TableState>(
  TableNotifier.new,
);
