import 'package:ui_temarlije/data/models/fileds.dart';

class PrincipalUser {
  final String id;
  final String authUserId;
  final String firstName;
  final String? middleName;
  final String lastName;
  final String dateOfBirth;
  final String staffId;
  final String department;
  final String position;
  final String staffType;
  final AddressInfo addressInfo;
  final String employmentType;
  final String hireDate;
  final bool canManageUsers;
  final bool canManageFinances;
  final bool canManageAcademics;
  final DateTime createdAt;
  final DateTime updatedAt;

  PrincipalUser({
    required this.id,
    required this.authUserId,
    required this.firstName,
    this.middleName,
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

  factory PrincipalUser.fromJson(Map<String, dynamic> json) {
    return PrincipalUser(
      id: json['id'],
      authUserId: json['auth_user_id'],
      firstName: json['first_name'],
      middleName: json['middle_name'],
      lastName: json['last_name'],
      dateOfBirth: json['date_of_birth'],
      staffId: json['staff_id'],
      department: json['department'],
      position: json['position'],
      staffType: json['staff_type'],
      addressInfo: AddressInfo.fromJson(json['address_info']),
      employmentType: json['employment_type'],
      hireDate: json['hire_date'],
      canManageUsers: json['can_manage_users'],
      canManageFinances: json['can_manage_finances'],
      canManageAcademics: json['can_manage_academics'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
