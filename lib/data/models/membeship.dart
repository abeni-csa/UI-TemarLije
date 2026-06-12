// lib/models/user.dart
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
  active,
  pending,
  archived,
  transferred,
  promoted;

  String get displayName {
    switch (this) {
      case MembershipStatus.active:
        return 'Active';
      case MembershipStatus.pending:
        return 'Pending';
      case MembershipStatus.archived:
        return 'Archived';
      case MembershipStatus.transferred:
        return 'Transferred';
      case MembershipStatus.promoted:
        return 'Promoted';
    }
  }

  Color get color {
    switch (this) {
      case MembershipStatus.active:
        return Colors.green;
      case MembershipStatus.pending:
        return Colors.orange;
      case MembershipStatus.archived:
        return Colors.grey;
      case MembershipStatus.transferred:
        return Colors.blue;
      case MembershipStatus.promoted:
        return Colors.purple;
    }
  }

  static MembershipStatus fromString(String value) {
    switch (value.toLowerCase()) {
      case 'active':
        return MembershipStatus.active;
      case 'pending':
        return MembershipStatus.pending;
      case 'archived':
        return MembershipStatus.archived;
      case 'transferred':
        return MembershipStatus.transferred;
      case 'promoted':
        return MembershipStatus.promoted;
      default:
        return MembershipStatus.pending;
    }
  }
}

enum UserType {
  student,
  staff,
  teacher,
  admin;

  String get displayName {
    switch (this) {
      case UserType.student:
        return 'Student';
      case UserType.staff:
        return 'Staff';
      case UserType.teacher:
        return 'Teacher';
      case UserType.admin:
        return 'Admin';
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
      case 'admin':
        return UserType.admin;
      default:
        return UserType.student;
    }
  }
}

class Membership {
  final String id;
  final String schoolId;
  final String schoolName;
  final String userId;
  final String userName;
  final String userEmail;
  final UserType membershipType;
  final String? joinedAcademicYearId;
  final MembershipStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Membership({
    required this.id,
    required this.schoolId,
    this.schoolName = '',
    required this.userId,
    this.userName = '',
    this.userEmail = '',
    required this.membershipType,
    this.joinedAcademicYearId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Membership.fromJson(Map<String, dynamic> json) {
    return Membership(
      id: json['id'].toString(),
      schoolId: json['school_id'].toString(),
      schoolName: json['school_name'] ?? json['school']?['name'] ?? '',
      userId: json['base_user_id'].toString(),
      userName: json['user_name'] ?? json['user']?['name'] ?? '',
      userEmail: json['user_email'] ?? json['user']?['email'] ?? '',
      membershipType: UserType.fromString(
        json['membership_type']?.toString() ?? 'student',
      ),
      joinedAcademicYearId: json['joined_academic_year_id']?.toString(),
      status: MembershipStatus.fromString(
        json['status']?.toString() ?? 'pending',
      ),
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

  bool get isActive => status == MembershipStatus.active;
  bool get isPending => status == MembershipStatus.pending;
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
