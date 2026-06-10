// lib/data/models/principal/principal_model.dart
import 'package:json_annotation/json_annotation.dart';
import 'package:ui_temarlije/data/models/fileds.dart';
import 'package:ui_temarlije/features/administrator/school_org/model/school.dart';
import 'package:ui_temarlije/utils/helpers/uuid_json_converter.dart';
import 'package:uuid/uuid.dart';

part 'school_organzation.g.dart';

// ignore: constant_identifier_names
enum SchoolType { Public, Private, International, GovernmentAllied }

@JsonSerializable(fieldRename: FieldRename.snake)
class SchoolOrganzationModel {
  @UuidJsonConverter()
  final UuidValue id;
  final String tenantCode;

  final String name;
  final AddressInfo address;
  final Location location;

  final Contact contact;
  final int establishedYear;
  final SchoolType schoolType;

  @UuidJsonConverter()
  final UuidValue createdBy;

  final DateTime createdAt;
  final DateTime updatedAt;

  SchoolOrganzationModel({
    required this.id,
    required this.tenantCode,
    required this.name,
    required this.schoolType,
    required this.establishedYear,
    required this.address,
    required this.location,
    required this.contact,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SchoolOrganzationModel.fromJson(Map<String, dynamic> json) =>
      _$SchoolOrganzationModelFromJson(json);

  Map<String, dynamic> toJson() => _$SchoolOrganzationModelToJson(this);
}

// Request/Response DTOs
@JsonSerializable(fieldRename: FieldRename.snake)
class CreateSchoolOrganzationRequest {
  final String schoolName;
  final Location location;
  final AddressInfo address;
  final Contact contact;
  final int establishedYear;
  final String schoolType;

  CreateSchoolOrganzationRequest({
    required this.schoolName,
    required this.location,
    required this.address,
    required this.contact,
    required this.establishedYear,
    required this.schoolType,
  });
  factory CreateSchoolOrganzationRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateSchoolOrganzationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateSchoolOrganzationRequestToJson(this);
}

/// Request DTO for updating school organization
@JsonSerializable(fieldRename: FieldRename.snake)
class UpdateSchoolOrganzationRequest {
  final String? schoolName;
  final Location? location;
  final AddressInfo? address;
  final Contact? contact;
  final int? establishedYear;
  final String? schoolType;

  UpdateSchoolOrganzationRequest({
    this.schoolName,
    this.location,
    this.address,
    this.contact,
    this.establishedYear,
    this.schoolType,
  });
  Map<String, dynamic> toJson() => _$UpdateSchoolOrganzationRequestToJson(this);

  factory UpdateSchoolOrganzationRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateSchoolOrganzationRequestFromJson(json);
}
