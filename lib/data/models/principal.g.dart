// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'principal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrincipalModel _$PrincipalModelFromJson(Map<String, dynamic> json) =>
    PrincipalModel(
      id: const UuidJsonConverter().fromJson(json['id'] as String),
      authUserId: const UuidJsonConverter().fromJson(
        json['auth_user_id'] as String,
      ),
      firstName: json['first_name'] as String,
      middleName: json['middle_name'] as String,
      lastName: json['last_name'] as String,
      dateOfBirth: json['date_of_birth'] as String,
      staffId: json['staff_id'] as String,
      department: json['department'] as String,
      position: json['position'] as String,
      staffType: $enumDecode(_$StaffTypeEnumMap, json['staff_type']),
      addressInfo: AddressInfo.fromJson(
        json['address_info'] as Map<String, dynamic>,
      ),
      employmentType: json['employment_type'] as String,
      hireDate: json['hire_date'] as String,
      canManageUsers: json['can_manage_users'] as bool,
      canManageFinances: json['can_manage_finances'] as bool,
      canManageAcademics: json['can_manage_academics'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$PrincipalModelToJson(PrincipalModel instance) =>
    <String, dynamic>{
      'id': const UuidJsonConverter().toJson(instance.id),
      'auth_user_id': const UuidJsonConverter().toJson(instance.authUserId),
      'first_name': instance.firstName,
      'middle_name': instance.middleName,
      'last_name': instance.lastName,
      'date_of_birth': instance.dateOfBirth,
      'staff_id': instance.staffId,
      'department': instance.department,
      'position': instance.position,
      'staff_type': _$StaffTypeEnumMap[instance.staffType]!,
      'address_info': instance.addressInfo,
      'employment_type': instance.employmentType,
      'hire_date': instance.hireDate,
      'can_manage_users': instance.canManageUsers,
      'can_manage_finances': instance.canManageFinances,
      'can_manage_academics': instance.canManageAcademics,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

const _$StaffTypeEnumMap = {
  StaffType.Teacher: 'Teacher',
  StaffType.Accountant: 'Accountant',
  StaffType.Librarian: 'Librarian',
  StaffType.SchoolAdmin: 'SchoolAdmin',
};

UpdatePrincipalRequest _$UpdatePrincipalRequestFromJson(
  Map<String, dynamic> json,
) => UpdatePrincipalRequest(
  firstName: json['first_name'] as String?,
  middleName: json['middle_name'] as String?,
  lastName: json['last_name'] as String?,
  dateOfBirth: json['date_of_birth'] as String?,
  department: json['department'] as String?,
  position: json['position'] as String?,
  addressInfo: json['address_info'] == null
      ? null
      : AddressInfo.fromJson(json['address_info'] as Map<String, dynamic>),
  employmentType: json['employment_type'] as String?,
  hireDate: json['hire_date'] as String?,
  canManageUsers: json['can_manage_users'] as bool?,
  canManageFinances: json['can_manage_finances'] as bool?,
  canManageAcademics: json['can_manage_academics'] as bool?,
);

Map<String, dynamic> _$UpdatePrincipalRequestToJson(
  UpdatePrincipalRequest instance,
) => <String, dynamic>{
  'first_name': instance.firstName,
  'middle_name': instance.middleName,
  'last_name': instance.lastName,
  'date_of_birth': instance.dateOfBirth,
  'department': instance.department,
  'position': instance.position,
  'address_info': instance.addressInfo,
  'employment_type': instance.employmentType,
  'hire_date': instance.hireDate,
  'can_manage_users': instance.canManageUsers,
  'can_manage_finances': instance.canManageFinances,
  'can_manage_academics': instance.canManageAcademics,
};

PrincipalRegistrationRequest _$PrincipalRegistrationRequestFromJson(
  Map<String, dynamic> json,
) => PrincipalRegistrationRequest(
  firstName: json['first_name'] as String,
  middleName: json['middle_name'] as String,
  lastName: json['last_name'] as String,
  dateOfBirth: json['date_of_birth'] as String,
  addressInfo: AddressInfo.fromJson(
    json['address_info'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$PrincipalRegistrationRequestToJson(
  PrincipalRegistrationRequest instance,
) => <String, dynamic>{
  'first_name': instance.firstName,
  'middle_name': instance.middleName,
  'last_name': instance.lastName,
  'date_of_birth': instance.dateOfBirth,
  'address_info': instance.addressInfo,
};

CreatePrincipalRequest _$CreatePrincipalRequestFromJson(
  Map<String, dynamic> json,
) => CreatePrincipalRequest(
  firstName: json['first_name'] as String,
  middleName: json['middle_name'] as String,
  lastName: json['last_name'] as String,
  dateOfBirth: DateTime.parse(json['date_of_birth'] as String),
  addressInfo: AddressInfo.fromJson(
    json['address_info'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$CreatePrincipalRequestToJson(
  CreatePrincipalRequest instance,
) => <String, dynamic>{
  'first_name': instance.firstName,
  'middle_name': instance.middleName,
  'last_name': instance.lastName,
  'date_of_birth': instance.dateOfBirth.toIso8601String(),
  'address_info': instance.addressInfo,
};
