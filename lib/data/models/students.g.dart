// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'students.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
