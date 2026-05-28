import 'package:json_annotation/json_annotation.dart';

// Student model
class Student {
  final String id;
  final String name;
  final String grade;
  final String section;
  bool isPresent;

  Student({
    required this.id,
    required this.name,
    required this.grade,
    required this.section,
    this.isPresent = true,
  });
}

class AttendanceRecord {
  final String id;
  final String studentId;
  final String studentName;
  final DateTime date;
  final AttendanceStatus status;
  bool isPresent;
  final String className;
  final String? remarks;
  final DateTime createdAt;
  final DateTime updatedAt;

  AttendanceRecord({
    required this.id,
    required this.studentId,
    required this.studentName,
    required this.date,
    required this.status,
    required this.className,
    this.remarks,
    this.isPresent = true,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'student_id': studentId,
    'student_name': studentName,
    'date': date.toIso8601String(),
    'status': status.toString().split('.').last,
    'class_name': className,
    'remarks': remarks,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };

  factory AttendanceRecord.fromJson(Map<String, dynamic> json) =>
      AttendanceRecord(
        id: json['id'],
        studentId: json['student_id'],
        studentName: json['student_name'],
        date: DateTime.parse(json['date']),
        status: AttendanceStatus.values.firstWhere(
          (e) => e.toString() == 'AttendanceStatus.${json['status']}',
        ),
        className: json['class_name'],
        remarks: json['remarks'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
      );
}

enum AttendanceStatus { present, absent, late, excused }
