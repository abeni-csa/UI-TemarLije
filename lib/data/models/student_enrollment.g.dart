// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_enrollment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentEnrollment _$StudentEnrollmentFromJson(Map<String, dynamic> json) =>
    StudentEnrollment(
      id: json['id'] as String?,
      studentId: json['student_id'] as String,
      sectionId: json['section_id'] as String,
      academicYearId: json['academic_year_id'] as String,
      enrollmentDate: DateTime.parse(json['enrollment_date'] as String),
      enrollmentStatus: $enumDecode(
        _$EnrollmentStatusEnumMap,
        json['enrollment_status'],
      ),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$StudentEnrollmentToJson(
  StudentEnrollment instance,
) => <String, dynamic>{
  'id': instance.id,
  'student_id': instance.studentId,
  'section_id': instance.sectionId,
  'academic_year_id': instance.academicYearId,
  'enrollment_date': instance.enrollmentDate.toIso8601String(),
  'enrollment_status': _$EnrollmentStatusEnumMap[instance.enrollmentStatus]!,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
};

const _$EnrollmentStatusEnumMap = {
  EnrollmentStatus.Active: 'Active',
  EnrollmentStatus.Transferred: 'Transferred',
  EnrollmentStatus.Withdrawn: 'Withdrawn',
  EnrollmentStatus.Graduated: 'Graduated',
  EnrollmentStatus.Suspended: 'Suspended',
};

StudentEnrollmentWithDetails _$StudentEnrollmentWithDetailsFromJson(
  Map<String, dynamic> json,
) => StudentEnrollmentWithDetails(
  id: const UuidJsonConverter().fromJson(json['id'] as String),
  studentId: const UuidJsonConverter().fromJson(json['student_id'] as String),
  studentName: json['student_name'] as String,
  studentFirstName: json['student_first_name'] as String,
  studentLastName: json['student_last_name'] as String,
  studentMiddleName: json['student_middle_name'] as String,
  studentPhone: json['student_phone'] as String,
  studentGender: json['student_gender'] as String,
  sectionId: const UuidJsonConverter().fromJson(json['section_id'] as String),
  sectionName: json['section_name'] as String,
  sectionCode: json['section_code'] as String,
  classroomName: json['classroom_name'] as String,
  gradeLevel: $enumDecode(_$GradeLevelEnumMap, json['grade_level']),
  academicYearId: const UuidJsonConverter().fromJson(
    json['academic_year_id'] as String,
  ),
  yearRange: json['year_range'] as String,
  enrollmentDate: DateTime.parse(json['enrollment_date'] as String),
  enrollmentStatus: $enumDecode(
    _$EnrollmentStatusEnumMap,
    json['enrollment_status'],
  ),
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$StudentEnrollmentWithDetailsToJson(
  StudentEnrollmentWithDetails instance,
) => <String, dynamic>{
  'id': const UuidJsonConverter().toJson(instance.id),
  'student_id': const UuidJsonConverter().toJson(instance.studentId),
  'student_name': instance.studentName,
  'student_first_name': instance.studentFirstName,
  'student_last_name': instance.studentLastName,
  'student_middle_name': instance.studentMiddleName,
  'student_phone': instance.studentPhone,
  'student_gender': instance.studentGender,
  'section_id': const UuidJsonConverter().toJson(instance.sectionId),
  'section_name': instance.sectionName,
  'section_code': instance.sectionCode,
  'classroom_name': instance.classroomName,
  'grade_level': _$GradeLevelEnumMap[instance.gradeLevel]!,
  'academic_year_id': const UuidJsonConverter().toJson(instance.academicYearId),
  'year_range': instance.yearRange,
  'enrollment_date': instance.enrollmentDate.toIso8601String(),
  'enrollment_status': _$EnrollmentStatusEnumMap[instance.enrollmentStatus]!,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
};

const _$GradeLevelEnumMap = {
  GradeLevel.kindergarten: 'Kindergarten',
  GradeLevel.primary: 'Primary',
  GradeLevel.secondary: 'Secondary',
  GradeLevel.highSchool: 'HighSchool',
  GradeLevel.preparatory: 'Preparatory',
};

EnrollmentSummary _$EnrollmentSummaryFromJson(Map<String, dynamic> json) =>
    EnrollmentSummary(
      totalEnrollments: (json['total_enrollments'] as num).toInt(),
      activeEnrollments: (json['active_enrollments'] as num).toInt(),
      byStatus: (json['by_status'] as List<dynamic>)
          .map((e) => EnrollmentStatusCount.fromJson(e as Map<String, dynamic>))
          .toList(),
      byGrade: (json['by_grade'] as List<dynamic>)
          .map((e) => GradeEnrollmentCount.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EnrollmentSummaryToJson(EnrollmentSummary instance) =>
    <String, dynamic>{
      'total_enrollments': instance.totalEnrollments,
      'active_enrollments': instance.activeEnrollments,
      'by_status': instance.byStatus,
      'by_grade': instance.byGrade,
    };

EnrollmentStatusCount _$EnrollmentStatusCountFromJson(
  Map<String, dynamic> json,
) => EnrollmentStatusCount(
  status: $enumDecode(_$EnrollmentStatusEnumMap, json['status']),
  count: (json['count'] as num).toInt(),
);

Map<String, dynamic> _$EnrollmentStatusCountToJson(
  EnrollmentStatusCount instance,
) => <String, dynamic>{
  'status': _$EnrollmentStatusEnumMap[instance.status]!,
  'count': instance.count,
};

GradeEnrollmentCount _$GradeEnrollmentCountFromJson(
  Map<String, dynamic> json,
) => GradeEnrollmentCount(
  gradeLevel: json['grade_level'] as String,
  count: (json['count'] as num).toInt(),
);

Map<String, dynamic> _$GradeEnrollmentCountToJson(
  GradeEnrollmentCount instance,
) => <String, dynamic>{
  'grade_level': instance.gradeLevel,
  'count': instance.count,
};
