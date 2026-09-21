// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Teacher _$TeacherFromJson(Map<String, dynamic> json) => Teacher(
  id: const UuidJsonConverter().fromJson(json['id'] as String),
  baseUserId: const UuidJsonConverter().fromJson(
    json['base_user_id'] as String,
  ),
  firstName: json['first_name'] as String,
  middleName: json['middle_name'] as String,
  lastName: json['last_name'] as String,
  dateOfBirth: DateTime.parse(json['date_of_birth'] as String),
  teacherId: json['teacher_id'] as String,
  qualification: json['qualification'] as String,
  specialization: (json['specialization'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  yearsOfExperience: (json['years_of_experience'] as num).toInt(),
  hireDate: json['hire_date'] == null
      ? null
      : DateTime.parse(json['hire_date'] as String),
  employmentType: $enumDecode(_$EmploymentTypeEnumMap, json['employment_type']),
  isHomeroomTeacher: json['is_homeroom_teacher'] as bool,
  phoneNumber: json['phone_number'] as String,
  gender: json['gender'] as String,
  createdAt: json['created_at'] as String,
  updatedAt: json['updated_at'] as String,
);

Map<String, dynamic> _$TeacherToJson(Teacher instance) => <String, dynamic>{
  'id': const UuidJsonConverter().toJson(instance.id),
  'base_user_id': const UuidJsonConverter().toJson(instance.baseUserId),
  'first_name': instance.firstName,
  'middle_name': instance.middleName,
  'last_name': instance.lastName,
  'date_of_birth': instance.dateOfBirth.toIso8601String(),
  'teacher_id': instance.teacherId,
  'qualification': instance.qualification,
  'specialization': instance.specialization,
  'years_of_experience': instance.yearsOfExperience,
  'hire_date': instance.hireDate?.toIso8601String(),
  'employment_type': _$EmploymentTypeEnumMap[instance.employmentType]!,
  'is_homeroom_teacher': instance.isHomeroomTeacher,
  'phone_number': instance.phoneNumber,
  'gender': instance.gender,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
};

const _$EmploymentTypeEnumMap = {
  EmploymentType.PartTime: 'PartTime',
  EmploymentType.Permanent: 'Permanent',
  EmploymentType.Contract: 'Contract',
  EmploymentType.Internship: 'Internship',
};

TeacherWithMembership _$TeacherWithMembershipFromJson(
  Map<String, dynamic> json,
) => TeacherWithMembership(
  id: const UuidJsonConverter().fromJson(json['id'] as String),
  baseUserId: const UuidJsonConverter().fromJson(
    json['base_user_id'] as String,
  ),
  firstName: json['first_name'] as String,
  middleName: json['middle_name'] as String?,
  lastName: json['last_name'] as String,
  dateOfBirth: DateTime.parse(json['date_of_birth'] as String),
  teacherId: json['teacher_id'] as String,
  qualification: json['qualification'] as String,
  specialization: (json['specialization'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  yearsOfExperience: (json['years_of_experience'] as num).toInt(),
  hireDate: json['hire_date'] == null
      ? null
      : DateTime.parse(json['hire_date'] as String),
  employmentType: $enumDecode(_$EmploymentTypeEnumMap, json['employment_type']),
  isHomeroomTeacher: json['is_homeroom_teacher'] as bool,
  phoneNumber: json['phone_number'] as String,
  gender: json['gender'] as String,
  addressInfo: AddressInfo.fromJson(
    json['address_info'] as Map<String, dynamic>,
  ),
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
  membershipId: const UuidJsonConverter().fromJson(
    json['membership_id'] as String,
  ),
  membershipStatus: $enumDecode(
    _$MembershipStatusEnumMap,
    json['membership_status'],
  ),
  joinedAcadmicYearId: _$JsonConverterFromJson<String, UuidValue>(
    json['joined_acadmic_year_id'],
    const UuidJsonConverter().fromJson,
  ),
  membershipType: $enumDecode(_$UserTypeEnumMap, json['membership_type']),
);

Map<String, dynamic> _$TeacherWithMembershipToJson(
  TeacherWithMembership instance,
) => <String, dynamic>{
  'id': const UuidJsonConverter().toJson(instance.id),
  'base_user_id': const UuidJsonConverter().toJson(instance.baseUserId),
  'first_name': instance.firstName,
  'middle_name': instance.middleName,
  'last_name': instance.lastName,
  'date_of_birth': instance.dateOfBirth.toIso8601String(),
  'teacher_id': instance.teacherId,
  'qualification': instance.qualification,
  'specialization': instance.specialization,
  'years_of_experience': instance.yearsOfExperience,
  'hire_date': instance.hireDate?.toIso8601String(),
  'employment_type': _$EmploymentTypeEnumMap[instance.employmentType]!,
  'is_homeroom_teacher': instance.isHomeroomTeacher,
  'phone_number': instance.phoneNumber,
  'gender': instance.gender,
  'address_info': instance.addressInfo,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
  'membership_id': const UuidJsonConverter().toJson(instance.membershipId),
  'membership_status': _$MembershipStatusEnumMap[instance.membershipStatus]!,
  'joined_acadmic_year_id': _$JsonConverterToJson<String, UuidValue>(
    instance.joinedAcadmicYearId,
    const UuidJsonConverter().toJson,
  ),
  'membership_type': _$UserTypeEnumMap[instance.membershipType]!,
};

const _$MembershipStatusEnumMap = {
  MembershipStatus.Active: 'Active',
  MembershipStatus.Rejected: 'Rejected',
  MembershipStatus.Pending: 'Pending',
  MembershipStatus.Archived: 'Archived',
  MembershipStatus.TransferdToOther: 'TransferdToOther',
  MembershipStatus.Promoted: 'Promoted',
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

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
