// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'membeship.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnenrolledStudentWithDetails _$UnenrolledStudentWithDetailsFromJson(
  Map<String, dynamic> json,
) => UnenrolledStudentWithDetails(
  studentId: const UuidJsonConverter().fromJson(json['student_id'] as String),
  authUserId: const UuidJsonConverter().fromJson(
    json['auth_user_id'] as String,
  ),
  firstName: json['first_name'] as String,
  middleName: json['middle_name'] as String,
  lastName: json['last_name'] as String,
  dateOfBirth: DateTime.parse(json['date_of_birth'] as String),
  phoneNumber: json['phone_number'] as String,
  gender: json['gender'] as String,
  addressInfo: AddressInfo.fromJson(
    json['address_info'] as Map<String, dynamic>,
  ),
  email: json['email'] as String,
  userCreatedAt: DateTime.parse(json['user_created_at'] as String),
  membershipId: const UuidJsonConverter().fromJson(
    json['membership_id'] as String,
  ),
  schoolId: _$JsonConverterFromJson<String, UuidValue>(
    json['school_id'],
    const UuidJsonConverter().fromJson,
  ),
  membershipType: $enumDecode(_$UserTypeEnumMap, json['membership_type']),
  membershipStatus: $enumDecode(
    _$MembershipStatusEnumMap,
    json['membership_status'],
  ),
  joinedAcademicYearId: _$JsonConverterFromJson<String, UuidValue>(
    json['joined_academic_year_id'],
    const UuidJsonConverter().fromJson,
  ),
  membershipCreatedAt: json['membership_created_at'] == null
      ? null
      : DateTime.parse(json['membership_created_at'] as String),
  enrollmentId: json['enrollment_id'],
  academicYearId: json['academic_year_id'],
  hasActiveEnrollment: json['has_active_enrollment'] as bool?,
  enrollmentStatus: $enumDecodeNullable(
    _$EnrollmentStatusEnumMap,
    json['enrollment_status'],
  ),
  enrollmentDate: json['enrollment_date'] as String?,
  enrollmentHistory: (json['enrollment_history'] as List<dynamic>?)
      ?.map((e) => EnrollmentHistoryEntry.fromJson(e as Map<String, dynamic>))
      .toList(),
  sectionId: json['section_id'],
  enrollmentIntent: json['enrollment_intent'] == null
      ? null
      : EnrollmentIntent.fromJson(
          json['enrollment_intent'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$UnenrolledStudentWithDetailsToJson(
  UnenrolledStudentWithDetails instance,
) => <String, dynamic>{
  'student_id': const UuidJsonConverter().toJson(instance.studentId),
  'auth_user_id': const UuidJsonConverter().toJson(instance.authUserId),
  'first_name': instance.firstName,
  'middle_name': instance.middleName,
  'last_name': instance.lastName,
  'date_of_birth': instance.dateOfBirth.toIso8601String(),
  'phone_number': instance.phoneNumber,
  'gender': instance.gender,
  'address_info': instance.addressInfo,
  'email': instance.email,
  'user_created_at': instance.userCreatedAt.toIso8601String(),
  'membership_id': const UuidJsonConverter().toJson(instance.membershipId),
  'school_id': _$JsonConverterToJson<String, UuidValue>(
    instance.schoolId,
    const UuidJsonConverter().toJson,
  ),
  'membership_type': _$UserTypeEnumMap[instance.membershipType]!,
  'membership_status': _$MembershipStatusEnumMap[instance.membershipStatus]!,
  'joined_academic_year_id': _$JsonConverterToJson<String, UuidValue>(
    instance.joinedAcademicYearId,
    const UuidJsonConverter().toJson,
  ),
  'membership_created_at': instance.membershipCreatedAt?.toIso8601String(),
  'enrollment_id': instance.enrollmentId,
  'section_id': instance.sectionId,
  'academic_year_id': instance.academicYearId,
  'enrollment_status': _$EnrollmentStatusEnumMap[instance.enrollmentStatus],
  'enrollment_date': instance.enrollmentDate,
  'has_active_enrollment': instance.hasActiveEnrollment,
  'enrollment_history': instance.enrollmentHistory,
  'enrollment_intent': instance.enrollmentIntent,
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

const _$UserTypeEnumMap = {
  UserType.Student: 'Student',
  UserType.PlaceHolder: 'PlaceHolder',
  UserType.Parent: 'Parent',
  UserType.Teacher: 'Teacher',
  UserType.FinanceAccountant: 'FinanceAccountant',
  UserType.Librarian: 'Librarian',
  UserType.SchoolAdmin: 'SchoolAdmin',
  UserType.Root: 'Root',
};

const _$MembershipStatusEnumMap = {
  MembershipStatus.Active: 'Active',
  MembershipStatus.Rejected: 'Rejected',
  MembershipStatus.Pending: 'Pending',
  MembershipStatus.Archived: 'Archived',
  MembershipStatus.TransferdToOther: 'TransferdToOther',
  MembershipStatus.Promoted: 'Promoted',
};

const _$EnrollmentStatusEnumMap = {
  EnrollmentStatus.Active: 'Active',
  EnrollmentStatus.Transferred: 'Transferred',
  EnrollmentStatus.Withdrawn: 'Withdrawn',
  EnrollmentStatus.Graduated: 'Graduated',
  EnrollmentStatus.Suspended: 'Suspended',
};

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);

EnrollmentHistoryEntry _$EnrollmentHistoryEntryFromJson(
  Map<String, dynamic> json,
) => EnrollmentHistoryEntry(
  enrollmentId: json['enrollment_id'] as String,
  academicYearId: json['academic_year_id'] as String,
  sectionId: json['section_id'] as String?,
  gradeLevel: json['grade_level'] as String,
  gradeNumber: (json['grade_number'] as num?)?.toInt(),
  status: $enumDecode(_$EnrollmentStatusEnumMap, json['status']),
  enrolledAt: json['enrolled_at'] as String,
  leftAt: json['left_at'] as String?,
);

Map<String, dynamic> _$EnrollmentHistoryEntryToJson(
  EnrollmentHistoryEntry instance,
) => <String, dynamic>{
  'enrollment_id': instance.enrollmentId,
  'academic_year_id': instance.academicYearId,
  'section_id': instance.sectionId,
  'grade_level': instance.gradeLevel,
  'grade_number': instance.gradeNumber,
  'status': _$EnrollmentStatusEnumMap[instance.status]!,
  'enrolled_at': instance.enrolledAt,
  'left_at': instance.leftAt,
};

EnrollmentIntent _$EnrollmentIntentFromJson(Map<String, dynamic> json) =>
    EnrollmentIntent(
      id: json['id'] as String,
      requestedGradeLevel: json['requested_grade_level'] as String?,
      requestedGradeNumber: (json['requested_grade_number'] as num?)?.toInt(),
      requestedKgClassType: json['requested_kg_class_type'] as String?,
      previousSchool: json['previous_school'] as String?,
      previousGradeLevel: json['previous_grade_level'] as String?,
      previousGrade: (json['previous_grade'] as num?)?.toInt(),
      status: $enumDecode(_$MembershipStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$EnrollmentIntentToJson(EnrollmentIntent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'requested_grade_level': instance.requestedGradeLevel,
      'requested_grade_number': instance.requestedGradeNumber,
      'requested_kg_class_type': instance.requestedKgClassType,
      'previous_school': instance.previousSchool,
      'previous_grade_level': instance.previousGradeLevel,
      'previous_grade': instance.previousGrade,
      'status': _$MembershipStatusEnumMap[instance.status]!,
    };

Membership _$MembershipFromJson(Map<String, dynamic> json) => Membership(
  id: json['id'] as String,
  schoolId: json['school_id'] as String,
  userId: json['user_id'] as String,
  joinedAcademicYearId: json['joined_academic_year_id'] as String?,
  membershipType: $enumDecode(_$UserTypeEnumMap, json['membership_type']),
  status: $enumDecode(_$MembershipStatusEnumMap, json['status']),
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$MembershipToJson(Membership instance) =>
    <String, dynamic>{
      'id': instance.id,
      'school_id': instance.schoolId,
      'user_id': instance.userId,
      'joined_academic_year_id': instance.joinedAcademicYearId,
      'membership_type': _$UserTypeEnumMap[instance.membershipType]!,
      'status': _$MembershipStatusEnumMap[instance.status]!,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
