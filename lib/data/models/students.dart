import 'package:ui_temarlije/data/models/fileds.dart';
import 'package:uuid/uuid.dart';
import 'package:json_annotation/json_annotation.dart';
part 'students.g.dart';

class UuidJsonConverter implements JsonConverter<UuidValue, String> {
  const UuidJsonConverter();

  @override
  UuidValue fromJson(String json) {
    return UuidValue.fromString(json);
  }

  @override
  String toJson(UuidValue uuid) {
    return uuid.toString();
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
}
