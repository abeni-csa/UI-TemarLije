// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'students.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KGStudents _$KGStudentsFromJson(Map<String, dynamic> json) => KGStudents(
  id: const UuidJsonConverter().fromJson(json['id'] as String),
  firstName: json['first_name'] as String,
  middleName: json['middle_name'] as String,
  lastName: json['last_name'] as String,
  dateOfBirth: DateTime.parse(json['date_of_birth'] as String),
  kgStudentId: json['kg_student_id'] as String,
  phoneNumber: json['phone_number'] as String,
  gender: json['gender'] as String,
  nationalId: json['national_id'] as String?,
  addressInfo: AddressInfo.fromJson(
    json['address_info'] as Map<String, dynamic>,
  ),
  birthCertificate: BirthCertificate.fromJson(
    json['birth_certificate'] as Map<String, dynamic>,
  ),
  schoolId: const UuidJsonConverter().fromJson(json['school_id'] as String),
  academicYearId: const UuidJsonConverter().fromJson(
    json['academic_year_id'] as String,
  ),
  recordedBy: const UuidJsonConverter().fromJson(json['recorded_by'] as String),
  guardianId: const UuidJsonConverter().fromJson(json['guardian_id'] as String),
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$KGStudentsToJson(
  KGStudents instance,
) => <String, dynamic>{
  'id': const UuidJsonConverter().toJson(instance.id),
  'first_name': instance.firstName,
  'middle_name': instance.middleName,
  'last_name': instance.lastName,
  'date_of_birth': instance.dateOfBirth.toIso8601String(),
  'kg_student_id': instance.kgStudentId,
  'phone_number': instance.phoneNumber,
  'gender': instance.gender,
  'national_id': instance.nationalId,
  'address_info': instance.addressInfo,
  'birth_certificate': instance.birthCertificate,
  'school_id': const UuidJsonConverter().toJson(instance.schoolId),
  'academic_year_id': const UuidJsonConverter().toJson(instance.academicYearId),
  'recorded_by': const UuidJsonConverter().toJson(instance.recordedBy),
  'guardian_id': const UuidJsonConverter().toJson(instance.guardianId),
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
};

BirthCertificate _$BirthCertificateFromJson(Map<String, dynamic> json) =>
    BirthCertificate(
      certificateNumber: json['certificate_number'] as String,
      issuingAuthority: $enumDecode(
        _$IssuingAuthorityEnumMap,
        json['issuing_authority'],
      ),
      originalCopy: json['original_copy'] as bool,
      photocopyProvided: json['photocopy_provided'] as bool,
      issueDate: json['issue_date'] as String,
    );

Map<String, dynamic> _$BirthCertificateToJson(
  BirthCertificate instance,
) => <String, dynamic>{
  'certificate_number': instance.certificateNumber,
  'issuing_authority': _$IssuingAuthorityEnumMap[instance.issuingAuthority]!,
  'original_copy': instance.originalCopy,
  'photocopy_provided': instance.photocopyProvided,
  'issue_date': instance.issueDate,
};

const _$IssuingAuthorityEnumMap = {
  IssuingAuthority.CityAdministration: 'CityAdministration',
  IssuingAuthority.Woreda: 'Woreda',
  IssuingAuthority.Kebele: 'Kebele',
  IssuingAuthority.Other: 'Other',
};

Students _$StudentsFromJson(Map<String, dynamic> json) => Students(
  id: const UuidJsonConverter().fromJson(json['id'] as String),
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
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$StudentsToJson(Students instance) => <String, dynamic>{
  'id': const UuidJsonConverter().toJson(instance.id),
  'auth_user_id': const UuidJsonConverter().toJson(instance.authUserId),
  'first_name': instance.firstName,
  'middle_name': instance.middleName,
  'last_name': instance.lastName,
  'date_of_birth': instance.dateOfBirth.toIso8601String(),
  'phone_number': instance.phoneNumber,
  'gender': instance.gender,
  'address_info': instance.addressInfo,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
};
