import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

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

// lib/models/school.dart
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
  Active,
  Rejected,
  Pending,
  Archived,
  TransferdToOther,
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

//{
//id: 2c08d091-273a-4f4b-a579-d1a002819dcd,
//school_id: 015cb15a-86d8-7462-bef0-a9ad9b735c27,
//base_user_id: 015cb15a-86d8-7841-8595-cddc0640aded,
//joined_acadmic_year_id: null,
//membership_type: Teacher,
//status: Pending,
//created_at: 2026-07-04T06:53:07.531865Z,
//updated_at: 2026-07-04T06:53:07.531867Z
//}

// membership.dart

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

  factory Membership.fromJson(Map<String, dynamic> json) {
    return Membership(
      id: json['id']?.toString() ?? '',
      schoolId: json['school_id']?.toString() ?? '',
      userId: json['base_user_id']?.toString() ?? '',
      joinedAcademicYearId: json['joined_acadmic_year_id']?.toString(),
      membershipType: _parseUserType(json['membership_type']),
      status: _parseMembershipStatus(json['status']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  static UserType _parseUserType(String type) {
    switch (type.toLowerCase()) {
      case 'student':
        return UserType.student;
      case 'teacher':
        return UserType.teacher;
      case 'staff':
        return UserType.staff;
      default:
        return UserType.student;
    }
  }

  static MembershipStatus _parseMembershipStatus(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return MembershipStatus.Active;
      case 'rejected':
        return MembershipStatus.Rejected;
      case 'pending':
        return MembershipStatus.Pending;
      case 'archived':
        return MembershipStatus.Archived;
      case 'transferd_to_other':
        return MembershipStatus.TransferdToOther;
      case 'promoted':
        return MembershipStatus.Promoted;
      default:
        return MembershipStatus.Pending;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'school_id': schoolId,
      'base_user_id': userId,
      'joined_acadmic_year_id': joinedAcademicYearId,
      'membership_type': membershipType.toString().split('.').last,
      'status': status.toString().split('.').last,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class OldMembership {
  final Uuid id;
  final Uuid schoolId;
  final Uuid userId;
  final Uuid? joinedAcademicYearId;
  final UserType membershipType;
  final MembershipStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;

  OldMembership({
    required this.id,
    required this.schoolId,
    required this.userId,

    required this.membershipType,
    this.joinedAcademicYearId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OldMembership.fromJson(Map<String, dynamic> json) {
    return OldMembership(
      id: json['id'],
      schoolId: json['school_id'],
      userId: json['base_user_id'],
      membershipType: UserType.fromString(
        json['membership_type']?.toString() ?? 'student',
      ),
      joinedAcademicYearId: json['joined_academic_year_id'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'school_id': schoolId,
      'base_user_id': userId,
      'membership_type': membershipType.name,
      'joined_academic_year_id': joinedAcademicYearId,
      'status': status.name,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  bool get isActive => status == MembershipStatus.Active;
  bool get isPending => status == MembershipStatus.Pending;
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
