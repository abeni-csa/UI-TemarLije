import 'package:ui_temarlije/data/models/fileds.dart';
import 'package:ui_temarlije/data/models/membeship.dart';
import 'package:ui_temarlije/utils/constants/enums.dart';
import 'package:ui_temarlije/utils/helpers/uuid_json_converter.dart';
import 'package:uuid/uuid.dart';
import 'package:json_annotation/json_annotation.dart';
part 'teacher.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createFactory: true)
class Teacher {
  @UuidJsonConverter()
  final UuidValue id;
  @UuidJsonConverter()
  final UuidValue baseUserId;
  final String firstName;
  final String middleName;
  final String lastName;
  final DateTime dateOfBirth;
  final String teacherId;
  final String qualification;
  final List<String> specialization;
  final int yearsOfExperience;
  final DateTime? hireDate;
  final EmploymentType employmentType;
  final bool isHomeroomTeacher;
  final String phoneNumber;
  final String gender;
  final String createdAt;
  final String updatedAt;

  Teacher({
    required this.id,
    required this.baseUserId,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.dateOfBirth,
    required this.teacherId,
    required this.qualification,
    required this.specialization,
    required this.yearsOfExperience,
    this.hireDate,
    required this.employmentType,
    required this.isHomeroomTeacher,
    required this.phoneNumber,
    required this.gender,
    required this.createdAt,
    required this.updatedAt,
  });

  String get fullName =>
      '$firstName ${middleName.isNotEmpty ? '$middleName ' : ''}$lastName';

  factory Teacher.fromJson(Map<String, dynamic> json) =>
      _$TeacherFromJson(json);
  Map<String, dynamic> toJson() => _$TeacherToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, createFactory: true)
class TeacherWithMembership {
  @UuidJsonConverter()
  final UuidValue id;
  @UuidJsonConverter()
  final UuidValue baseUserId;
  final String firstName;
  final String? middleName;
  final String lastName;
  final DateTime dateOfBirth;
  final String teacherId;
  final String qualification;
  final List<String> specialization;
  final int yearsOfExperience;
  final DateTime? hireDate;
  final EmploymentType employmentType;
  final bool isHomeroomTeacher;
  final String phoneNumber;
  final String gender;
  final AddressInfo addressInfo;
  final DateTime createdAt;
  final DateTime updatedAt;
  // Membership fields
  @UuidJsonConverter()
  final UuidValue membershipId;
  final MembershipStatus membershipStatus;
  @UuidJsonConverter()
  final UuidValue? joinedAcadmicYearId;
  final UserType membershipType;

  TeacherWithMembership({
    required this.id,
    required this.baseUserId,
    required this.firstName,
    this.middleName,
    required this.lastName,
    required this.dateOfBirth,
    required this.teacherId,
    required this.qualification,
    required this.specialization,
    required this.yearsOfExperience,
    this.hireDate,
    required this.employmentType,
    required this.isHomeroomTeacher,
    required this.phoneNumber,
    required this.gender,
    required this.addressInfo,
    required this.createdAt,
    required this.updatedAt,
    required this.membershipId,
    required this.membershipStatus,
    this.joinedAcadmicYearId,
    required this.membershipType,
  });

  String get fullName => '$firstName $middleName $lastName';

  factory TeacherWithMembership.fromJson(Map<String, dynamic> json) =>
      _$TeacherWithMembershipFromJson(json);
  Map<String, dynamic> toJson() => _$TeacherWithMembershipToJson(this);
}
