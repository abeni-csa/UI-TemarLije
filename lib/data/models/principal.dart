// lib/data/models/principal/principal_model.dart
import 'package:json_annotation/json_annotation.dart';
import 'package:ui_temarlije/data/models/fileds.dart';
import 'package:ui_temarlije/utils/helpers/uuid_json_converter.dart';
import 'package:uuid/uuid.dart';

part 'principal.g.dart';

// ignore: constant_identifier_names
enum StaffType { Teacher, Accountant, Librarian, SchoolAdmin }

@JsonSerializable(fieldRename: FieldRename.snake)
class PrincipalModel {
  @UuidJsonConverter()
  final UuidValue id;

  @UuidJsonConverter()
  final UuidValue authUserId;

  final String firstName;
  final String middleName;
  final String lastName;
  final String dateOfBirth;
  final String staffId;
  final String department;
  final String position;
  final StaffType staffType;
  final AddressInfo addressInfo;
  final String employmentType;
  final String hireDate;
  final bool canManageUsers;
  final bool canManageFinances;
  final bool canManageAcademics;
  final DateTime createdAt;
  final DateTime updatedAt;

  PrincipalModel({
    required this.id,
    required this.authUserId,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.dateOfBirth,
    required this.staffId,
    required this.department,
    required this.position,
    required this.staffType,
    required this.addressInfo,
    required this.employmentType,
    required this.hireDate,
    required this.canManageUsers,
    required this.canManageFinances,
    required this.canManageAcademics,
    required this.createdAt,
    required this.updatedAt,
  });

  String get fullName =>
      '$firstName ${middleName.isNotEmpty ? '$middleName ' : ''}';
  String get shortName => '$firstName $lastName';

  factory PrincipalModel.fromJson(Map<String, dynamic> json) =>
      _$PrincipalModelFromJson(json);

  Map<String, dynamic> toJson() => _$PrincipalModelToJson(this);

  PrincipalModel copyWith({
    UuidValue? id,
    UuidValue? authUserId,
    String? firstName,
    String? middleName,
    String? lastName,
    String? dateOfBirth,
    String? staffId,
    String? department,
    String? position,
    StaffType? staffType,
    AddressInfo? addressInfo,
    String? employmentType,
    String? hireDate,
    bool? canManageUsers,
    bool? canManageFinances,
    bool? canManageAcademics,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PrincipalModel(
      id: id ?? this.id,
      authUserId: authUserId ?? this.authUserId,
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      staffId: staffId ?? this.staffId,
      department: department ?? this.department,
      position: position ?? this.position,
      staffType: staffType ?? this.staffType,
      addressInfo: addressInfo ?? this.addressInfo,
      employmentType: employmentType ?? this.employmentType,
      hireDate: hireDate ?? this.hireDate,
      canManageUsers: canManageUsers ?? this.canManageUsers,
      canManageFinances: canManageFinances ?? this.canManageFinances,
      canManageAcademics: canManageAcademics ?? this.canManageAcademics,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class UpdatePrincipalRequest {
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? dateOfBirth;
  final String? department;
  final String? position;
  final AddressInfo? addressInfo;
  final String? employmentType;
  final String? hireDate;
  final bool? canManageUsers;
  final bool? canManageFinances;
  final bool? canManageAcademics;

  UpdatePrincipalRequest({
    this.firstName,
    this.middleName,
    this.lastName,
    this.dateOfBirth,
    this.department,
    this.position,
    this.addressInfo,
    this.employmentType,
    this.hireDate,
    this.canManageUsers,
    this.canManageFinances,
    this.canManageAcademics,
  });

  Map<String, dynamic> toJson() => _$UpdatePrincipalRequestToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class PrincipalRegistrationRequest {
  final String firstName;
  final String middleName;
  final String lastName;
  final String dateOfBirth;
  final AddressInfo addressInfo;

  PrincipalRegistrationRequest({
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.dateOfBirth,
    required this.addressInfo,
  });

  Map<String, dynamic> toJson() => _$PrincipalRegistrationRequestToJson(this);
}

// Request/Response DTOs
@JsonSerializable(fieldRename: FieldRename.snake)
class CreatePrincipalRequest {
  final String firstName;
  final String middleName;
  final String lastName;
  final DateTime dateOfBirth;
  final AddressInfo addressInfo;

  CreatePrincipalRequest({
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.dateOfBirth,
    required this.addressInfo,
  });

  Map<String, dynamic> toJson() => _$CreatePrincipalRequestToJson(this);
}
