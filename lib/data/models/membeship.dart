import 'package:flutter/material.dart';
import 'package:ui_temarlije/data/models/student_enrollment.dart';
import 'package:ui_temarlije/utils/helpers/uuid_json_converter.dart';
import 'package:uuid/uuid.dart';
import 'package:ui_temarlije/data/models/fileds.dart';
import 'package:json_annotation/json_annotation.dart';
part 'membeship.g.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String role;
  final DateTime createdAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? json['user_id'] ?? const Uuid().v4(),
      name: json['name'] ?? json['full_name'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? 'student',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

class School {
  final String id;
  final String name;
  final String address;
  final String phone;
  final String email;
  final String? adminId;
  final DateTime createdAt;

  School({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    this.adminId,
    required this.createdAt,
  });

  factory School.fromJson(Map<String, dynamic> json) {
    return School(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      adminId: json['admin_id']?.toString(),
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'phone': phone,
      'email': email,
      'admin_id': adminId,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

// lib/models/membership.dart
enum MembershipStatus {
  // ignore: constant_identifier_names
  Active,
  // ignore: constant_identifier_names
  Rejected,
  // ignore: constant_identifier_names
  Pending,
  // ignore: constant_identifier_names
  Archived,
  // ignore: constant_identifier_names
  TransferdToOther,
  // ignore: constant_identifier_names
  Promoted,
}

extension MembershipStatusExtension on MembershipStatus {
  String get displayName {
    switch (this) {
      case MembershipStatus.Active:
        return 'Active';
      case MembershipStatus.Rejected:
        return 'Rejected';
      case MembershipStatus.Pending:
        return 'Pending';
      case MembershipStatus.Archived:
        return 'Archived';
      case MembershipStatus.TransferdToOther:
        return 'Transferred';
      case MembershipStatus.Promoted:
        return 'Promoted';
    }
  }

  Color get color {
    switch (this) {
      case MembershipStatus.Active:
        return Colors.green;
      case MembershipStatus.Rejected:
        return Colors.red;
      case MembershipStatus.Pending:
        return Colors.orange;
      case MembershipStatus.Archived:
        return Colors.grey;
      case MembershipStatus.TransferdToOther:
        return Colors.purple;
      case MembershipStatus.Promoted:
        return Colors.blue;
    }
  }
}

@JsonSerializable(fieldRename: FieldRename.snake, createFactory: true)
class UnenrolledStudentWithDetails {
  @UuidJsonConverter()
  final UuidValue studentId;
  @UuidJsonConverter()
  final UuidValue authUserId;

  final String firstName;
  final String middleName;
  final String lastName;
  final DateTime dateOfBirth;

  final String phoneNumber;
  final String gender;
  final AddressInfo addressInfo;
  final String email;
  final DateTime userCreatedAt;

  @UuidJsonConverter()
  final UuidValue membershipId;
  @UuidJsonConverter()
  final UuidValue? schoolId;

  final UserType membershipType;
  final MembershipStatus membershipStatus;
  @UuidJsonConverter()
  final UuidValue? joinedAcademicYearId;

  final DateTime? membershipCreatedAt;

  final dynamic enrollmentId;
  final dynamic sectionId;
  final dynamic academicYearId;

  final EnrollmentStatus? enrollmentStatus;

  final String? enrollmentDate;

  final bool? hasActiveEnrollment;

  final List<EnrollmentHistoryEntry>? enrollmentHistory;

  final EnrollmentIntent? enrollmentIntent;

  const UnenrolledStudentWithDetails({
    required this.studentId,
    required this.authUserId,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.dateOfBirth,
    required this.phoneNumber,
    required this.gender,
    required this.addressInfo,
    required this.email,
    required this.userCreatedAt,
    required this.membershipId,
    this.schoolId,
    required this.membershipType,
    required this.membershipStatus,
    this.joinedAcademicYearId,
    this.membershipCreatedAt,
    this.enrollmentId,
    this.academicYearId,
    this.hasActiveEnrollment,
    this.enrollmentStatus,
    this.enrollmentDate,
    this.enrollmentHistory,
    this.sectionId,
    this.enrollmentIntent,
  });

  factory UnenrolledStudentWithDetails.fromJson(Map<String, dynamic> json) =>
      _$UnenrolledStudentWithDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$UnenrolledStudentWithDetailsToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, createFactory: true)
class EnrollmentHistoryEntry {
  final String enrollmentId;

  final String academicYearId;

  final String? sectionId;

  final String gradeLevel;

  final int? gradeNumber;

  final EnrollmentStatus status;
  final String enrolledAt;

  final String? leftAt;

  EnrollmentHistoryEntry({
    required this.enrollmentId,
    required this.academicYearId,
    this.sectionId,
    required this.gradeLevel,
    this.gradeNumber,
    required this.status,
    required this.enrolledAt,
    this.leftAt,
  });

  factory EnrollmentHistoryEntry.fromJson(Map<String, dynamic> json) =>
      _$EnrollmentHistoryEntryFromJson(json);
  Map<String, dynamic> toJson() => _$EnrollmentHistoryEntryToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, createFactory: true)
class EnrollmentIntent {
  final String id;

  final String? requestedGradeLevel;

  final int? requestedGradeNumber;

  final String? requestedKgClassType;

  final String? previousSchool;

  final String? previousGradeLevel;

  final int? previousGrade;

  final MembershipStatus status;

  EnrollmentIntent({
    required this.id,
    this.requestedGradeLevel,
    this.requestedGradeNumber,
    this.requestedKgClassType,
    this.previousSchool,
    this.previousGradeLevel,
    this.previousGrade,
    required this.status,
  });

  factory EnrollmentIntent.fromJson(Map<String, dynamic> json) =>
      _$EnrollmentIntentFromJson(json);
  Map<String, dynamic> toJson() => _$EnrollmentIntentToJson(this);
}

enum UserType {
  student,
  staff,
  teacher;

  String get displayName {
    switch (this) {
      case UserType.student:
        return 'Student';
      case UserType.staff:
        return 'Staff';
      case UserType.teacher:
        return 'Teacher';
    }
  }

  static UserType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'student':
        return UserType.student;
      case 'staff':
        return UserType.staff;
      case 'teacher':
        return UserType.teacher;

      default:
        return UserType.student;
    }
  }
}

// Request for batch operations
class BatchMembershipRequest {
  final List<Uuid> requestIds;
  final MembershipStatus status;

  BatchMembershipRequest({required this.requestIds, required this.status});

  Map<String, dynamic> toJson() {
    return {'request_ids': requestIds, 'status': status};
  }
}

@JsonSerializable(fieldRename: FieldRename.snake, createFactory: true)
class Membership {
  final String id; // Change from Uuid to String
  final String schoolId; // Change from Uuid to String
  final String userId; // Change from Uuid to String
  final String? joinedAcademicYearId;
  final UserType membershipType;
  final MembershipStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Membership({
    required this.id,
    required this.schoolId,
    required this.userId,
    this.joinedAcademicYearId,
    required this.membershipType,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  bool get isActive => status == MembershipStatus.Active;
  bool get isPending => status == MembershipStatus.Pending;
  factory Membership.fromJson(Map<String, dynamic> json) =>
      _$MembershipFromJson(json);
  Map<String, dynamic> toJson() => _$MembershipToJson(this);
}

class MembershipRequest {
  final String userId;
  final UserType membershipType;
  final int? requestedGradeLevel;
  final int? requestedGradeNumber;
  final String? previousSchool;
  final String? previousGrade;
  final double? testScore;

  MembershipRequest({
    required this.userId,
    required this.membershipType,
    this.requestedGradeLevel,
    this.requestedGradeNumber,
    this.previousSchool,
    this.previousGrade,
    this.testScore,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'membership_type': membershipType.name,
      'requested_grade_level': requestedGradeLevel,
      'requested_grade_number': requestedGradeNumber,
      'previous_school': previousSchool,
      'previous_grade': previousGrade,
      'test_score': testScore,
    };
  }
}

class BulkStatusUpdate {
  final MembershipStatus status;
  final List<String> userIds;

  BulkStatusUpdate({required this.status, required this.userIds});

  Map<String, dynamic> toJson() {
    return {'status': status.name, 'user_ids': userIds};
  }
}
