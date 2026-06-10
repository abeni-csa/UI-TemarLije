// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'school_organzation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SchoolOrganzationModel _$SchoolOrganzationModelFromJson(
  Map<String, dynamic> json,
) => SchoolOrganzationModel(
  id: const UuidJsonConverter().fromJson(json['id'] as String),
  tenantCode: json['tenant_code'] as String,
  name: json['name'] as String,
  schoolType: $enumDecode(_$SchoolTypeEnumMap, json['school_type']),
  establishedYear: (json['established_year'] as num).toInt(),
  address: AddressInfo.fromJson(json['address'] as Map<String, dynamic>),
  location: Location.fromJson(json['location'] as Map<String, dynamic>),
  contact: Contact.fromJson(json['contact'] as Map<String, dynamic>),
  createdBy: const UuidJsonConverter().fromJson(json['created_by'] as String),
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$SchoolOrganzationModelToJson(
  SchoolOrganzationModel instance,
) => <String, dynamic>{
  'id': const UuidJsonConverter().toJson(instance.id),
  'tenant_code': instance.tenantCode,
  'name': instance.name,
  'address': instance.address,
  'location': instance.location,
  'contact': instance.contact,
  'established_year': instance.establishedYear,
  'school_type': _$SchoolTypeEnumMap[instance.schoolType]!,
  'created_by': const UuidJsonConverter().toJson(instance.createdBy),
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
};

const _$SchoolTypeEnumMap = {
  SchoolType.Public: 'Public',
  SchoolType.Private: 'Private',
  SchoolType.International: 'International',
  SchoolType.GovernmentAllied: 'GovernmentAllied',
};

CreateSchoolOrganzationRequest _$CreateSchoolOrganzationRequestFromJson(
  Map<String, dynamic> json,
) => CreateSchoolOrganzationRequest(
  schoolName: json['school_name'] as String,
  location: Location.fromJson(json['location'] as Map<String, dynamic>),
  address: AddressInfo.fromJson(json['address'] as Map<String, dynamic>),
  contact: Contact.fromJson(json['contact'] as Map<String, dynamic>),
  establishedYear: (json['established_year'] as num).toInt(),
  schoolType: json['school_type'] as String,
);

Map<String, dynamic> _$CreateSchoolOrganzationRequestToJson(
  CreateSchoolOrganzationRequest instance,
) => <String, dynamic>{
  'school_name': instance.schoolName,
  'location': instance.location,
  'address': instance.address,
  'contact': instance.contact,
  'established_year': instance.establishedYear,
  'school_type': instance.schoolType,
};

UpdateSchoolOrganzationRequest _$UpdateSchoolOrganzationRequestFromJson(
  Map<String, dynamic> json,
) => UpdateSchoolOrganzationRequest(
  schoolName: json['school_name'] as String?,
  location: json['location'] == null
      ? null
      : Location.fromJson(json['location'] as Map<String, dynamic>),
  address: json['address'] == null
      ? null
      : AddressInfo.fromJson(json['address'] as Map<String, dynamic>),
  contact: json['contact'] == null
      ? null
      : Contact.fromJson(json['contact'] as Map<String, dynamic>),
  establishedYear: (json['established_year'] as num?)?.toInt(),
  schoolType: json['school_type'] as String?,
);

Map<String, dynamic> _$UpdateSchoolOrganzationRequestToJson(
  UpdateSchoolOrganzationRequest instance,
) => <String, dynamic>{
  'school_name': instance.schoolName,
  'location': instance.location,
  'address': instance.address,
  'contact': instance.contact,
  'established_year': instance.establishedYear,
  'school_type': instance.schoolType,
};
