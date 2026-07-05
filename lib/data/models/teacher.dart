import 'package:ui_temarlije/utils/constants/enums.dart';
import 'package:ui_temarlije/utils/helpers/uuid_json_converter.dart';
import 'package:uuid/uuid.dart';
import 'package:json_annotation/json_annotation.dart';
part 'teacher.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
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
