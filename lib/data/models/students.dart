import 'package:ui_temarlije/data/models/fileds.dart';
import 'package:ui_temarlije/utils/helpers/uuid_json_converter.dart';
import 'package:uuid/uuid.dart';
import 'package:json_annotation/json_annotation.dart';
part 'students.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createFactory: true)
class KGStudents {
  @UuidJsonConverter()
  final UuidValue id;

  final String firstName;

  final String middleName;

  final String lastName;

  final DateTime dateOfBirth; // Using String for NaiveDate (YYYY-MM-DD)

  final String kgStudentId;

  final String phoneNumber;

  final String gender;

  final String? nationalId;

  final AddressInfo addressInfo;

  final BirthCertificate birthCertificate;

  @UuidJsonConverter()
  final UuidValue schoolId;
  @UuidJsonConverter()
  final UuidValue academicYearId;
  @UuidJsonConverter()
  final UuidValue recordedBy;
  @UuidJsonConverter()
  final UuidValue guardianId;

  final DateTime createdAt; // Using String for DateTime (ISO format)

  final DateTime updatedAt;

  KGStudents({
    required this.id,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.dateOfBirth,
    required this.kgStudentId,
    required this.phoneNumber,
    required this.gender,
    this.nationalId,
    required this.addressInfo,
    required this.birthCertificate,
    required this.schoolId,
    required this.academicYearId,
    required this.recordedBy,
    required this.guardianId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory KGStudents.fromJson(Map<String, dynamic> json) =>
      _$KGStudentsFromJson(json);
  Map<String, dynamic> toJson() => _$KGStudentsToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, createFactory: true)
class BirthCertificate {
  final String certificateNumber;

  final IssuingAuthority issuingAuthority;

  final bool originalCopy;

  final bool photocopyProvided;

  final String issueDate;

  BirthCertificate({
    required this.certificateNumber,
    required this.issuingAuthority,
    required this.originalCopy,
    required this.photocopyProvided,
    required this.issueDate,
  });

  factory BirthCertificate.fromJson(Map<String, dynamic> json) =>
      _$BirthCertificateFromJson(json);
  Map<String, dynamic> toJson() => _$BirthCertificateToJson(this);
}

// Enums for IssuingAuthority
// ignore: constant_identifier_names
enum IssuingAuthority { CityAdministration, Woreda, Kebele, Other }

extension IssuingAuthorityExtension on IssuingAuthority {
  String toJson() {
    switch (this) {
      case IssuingAuthority.CityAdministration:
        return 'CityAdministration';
      case IssuingAuthority.Woreda:
        return 'Woreda';
      case IssuingAuthority.Kebele:
        return 'Kebele';
      case IssuingAuthority.Other:
        return 'Other';
    }
  }

  static IssuingAuthority fromJson(String value) {
    switch (value) {
      case 'CityAdministration':
        return IssuingAuthority.CityAdministration;
      case 'Woreda':
        return IssuingAuthority.Woreda;
      case 'Kebele':
        return IssuingAuthority.Kebele;
      case 'Other':
        return IssuingAuthority.Other;
      default:
        return IssuingAuthority.Other;
    }
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Students {
  @UuidJsonConverter()
  final UuidValue id;

  @UuidJsonConverter()
  final UuidValue authUserId;

  final String firstName;
  final String middleName;
  final String lastName;
  final DateTime dateOfBirth;
  final String phoneNumber;
  final String gender;
  final AddressInfo addressInfo;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Students({
    required this.id,
    required this.authUserId,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.dateOfBirth,
    required this.phoneNumber,
    required this.gender,
    required this.addressInfo,
    required this.createdAt,
    required this.updatedAt,
  });

  String get fullName =>
      '$firstName ${middleName.isNotEmpty ? '$middleName  $lastName' : ''}';

  factory Students.create({
    UuidValue? authUserId,
    required String firstName,
    required String middleName,
    required String lastName,
    required DateTime dateOfBirth,
    required String phoneNumber,
    required String gender,
    required AddressInfo addressInfo,
  }) {
    final uuid = Uuid(); // Remove const if you're using non-const
    final now = DateTime.now();
    return Students(
      id: UuidValue.fromString(uuid.v4()),
      authUserId: authUserId ?? UuidValue.fromString(uuid.v4()),
      firstName: firstName,
      middleName: middleName,
      lastName: lastName,
      dateOfBirth: dateOfBirth,
      phoneNumber: phoneNumber,
      gender: gender,
      addressInfo: addressInfo,
      createdAt: now,
      updatedAt: now,
    );
  }

  factory Students.fromJson(Map<String, dynamic> json) =>
      _$StudentsFromJson(json);
  Map<String, dynamic> toJson() => _$StudentsToJson(this);

  String get initials {
    if (fullName.isEmpty) return '';
    final words = fullName.trim().split(RegExp(r'\s+'));
    if (words.length > 1) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    }
    return words[0][0].toUpperCase();
  }
}
