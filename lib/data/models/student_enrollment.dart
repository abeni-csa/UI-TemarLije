import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ui_temarlije/utils/helpers/uuid_json_converter.dart';
import 'package:uuid/uuid.dart';

part 'student_enrollment.g.dart';

enum EnrollmentStatus {
  @JsonValue('Active')
  // ignore: constant_identifier_names
  Active,
  @JsonValue('Transferred')
  // ignore: constant_identifier_names
  Transferred,
  @JsonValue('Withdrawn')
  // ignore: constant_identifier_names
  Withdrawn,
  @JsonValue('Graduated')
  // ignore: constant_identifier_names
  Graduated,
  @JsonValue('Suspended')
  // ignore: constant_identifier_names
  Suspended,
}

extension EnrollmentStatusExtension on EnrollmentStatus {
  String get displayName {
    switch (this) {
      case EnrollmentStatus.Active:
        return 'Active';
      case EnrollmentStatus.Transferred:
        return 'Transferred';
      case EnrollmentStatus.Withdrawn:
        return 'Withdrawn';
      case EnrollmentStatus.Graduated:
        return 'Graduated';
      case EnrollmentStatus.Suspended:
        return 'Suspended';
    }
  }

  Color get color {
    switch (this) {
      case EnrollmentStatus.Active:
        return Colors.green;
      case EnrollmentStatus.Transferred:
        return Colors.orange;
      case EnrollmentStatus.Withdrawn:
        return Colors.red;
      case EnrollmentStatus.Graduated:
        return Colors.blue;
      case EnrollmentStatus.Suspended:
        return Colors.purple;
    }
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class StudentEnrollment {
  final String id;
  final String studentId;
  final String sectionId;
  final String academicYearId;
  final DateTime enrollmentDate;
  final EnrollmentStatus enrollmentStatus;
  final DateTime createdAt;
  final DateTime updatedAt;

  StudentEnrollment({
    String? id,
    required this.studentId,
    required this.sectionId,
    required this.academicYearId,
    required this.enrollmentDate,
    required this.enrollmentStatus,
    required this.createdAt,
    required this.updatedAt,
  }) : id = id ?? const Uuid().v4();

  factory StudentEnrollment.fromJson(Map<String, dynamic> json) =>
      _$StudentEnrollmentFromJson(json);

  Map<String, dynamic> toJson() => _$StudentEnrollmentToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class StudentEnrollmentWithDetails {
  @UuidJsonConverter()
  final UuidValue id;
  @UuidJsonConverter()
  final UuidValue studentId;
  final String studentName;
  final String studentFirstName;
  final String studentLastName;
  final String studentMiddleName;
  final String studentPhone;
  final String studentGender;
  @UuidJsonConverter()
  final UuidValue sectionId;
  final String sectionName;
  final String sectionCode;
  final String classroomName;
  final String gradeLevel;
  @UuidJsonConverter()
  final UuidValue academicYearId;
  final String yearRange;
  final DateTime enrollmentDate;
  final EnrollmentStatus enrollmentStatus;
  final DateTime createdAt;
  final DateTime updatedAt;

  StudentEnrollmentWithDetails({
    required this.id,
    required this.studentId,
    required this.studentName,
    required this.studentFirstName,
    required this.studentLastName,
    required this.studentMiddleName,
    required this.studentPhone,
    required this.studentGender,
    required this.sectionId,
    required this.sectionName,
    required this.sectionCode,
    required this.classroomName,
    required this.gradeLevel,
    required this.academicYearId,
    required this.yearRange,
    required this.enrollmentDate,
    required this.enrollmentStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StudentEnrollmentWithDetails.fromJson(Map<String, dynamic> json) =>
      _$StudentEnrollmentWithDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$StudentEnrollmentWithDetailsToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class EnrollmentSummary {
  final int totalEnrollments;
  final int activeEnrollments;
  final List<EnrollmentStatusCount> byStatus;
  final List<GradeEnrollmentCount> byGrade;

  EnrollmentSummary({
    required this.totalEnrollments,
    required this.activeEnrollments,
    required this.byStatus,
    required this.byGrade,
  });

  factory EnrollmentSummary.fromJson(Map<String, dynamic> json) =>
      _$EnrollmentSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$EnrollmentSummaryToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class EnrollmentStatusCount {
  final EnrollmentStatus status;
  final int count;

  EnrollmentStatusCount({required this.status, required this.count});

  factory EnrollmentStatusCount.fromJson(Map<String, dynamic> json) =>
      _$EnrollmentStatusCountFromJson(json);

  Map<String, dynamic> toJson() => _$EnrollmentStatusCountToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class GradeEnrollmentCount {
  final String gradeLevel;
  final int count;

  GradeEnrollmentCount({required this.gradeLevel, required this.count});

  factory GradeEnrollmentCount.fromJson(Map<String, dynamic> json) =>
      _$GradeEnrollmentCountFromJson(json);

  Map<String, dynamic> toJson() => _$GradeEnrollmentCountToJson(this);
}
