import 'package:ui_temarlije/data/models/fileds.dart';
import 'package:ui_temarlije/data/models/users_models.dart';

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

  String get fullNameformated =>
      '$firstName ${middleName ?? ''} $lastName'.trim();
  String get fullName => '$firstName, $lastName';

  /// Default empty PrincipalUser used for initializing observables
  static PrincipalUser def() {
    return PrincipalUser(
      id: '',
      authUserId: '',
      firstName: '',
      middleName: null,
      lastName: '',
      dateOfBirth: '',
      staffId: '',
      department: '',
      position: '',
      staffType: '',
      addressInfo: AddressInfo(region: '', zone: '', city: '', kebeleNo: ''),
      employmentType: '',
      hireDate: '',
      canManageUsers: false,
      canManageFinances: false,
      canManageAcademics: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

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

/// Request model for creating a principal
class CreatePrincipalRequest {
  final String authUserId;
  final String firstName;
  final String? middleName;
  final String lastName;
  final String dateOfBirth;
  final String department;
  final String position;
  final AddressInfoRequest addressInfo;
  final String employmentType;
  final String hireDate;
  final bool canManageUsers;
  final bool canManageFinances;
  final bool canManageAcademics;

  CreatePrincipalRequest({
    required this.authUserId,
    required this.firstName,
    this.middleName,
    required this.lastName,
    required this.dateOfBirth,
    required this.department,
    required this.position,
    required this.addressInfo,
    required this.employmentType,
    required this.hireDate,
    this.canManageUsers = false,
    this.canManageFinances = false,
    this.canManageAcademics = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'auth_user_id': authUserId,
      'first_name': firstName,
      'middle_name': middleName,
      'last_name': lastName,
      'date_of_birth': dateOfBirth,
      'department': department,
      'position': position,
      'address_info': addressInfo.toJson(),
      'employment_type': employmentType,
      'hire_date': hireDate,
      'can_manage_users': canManageUsers,
      'can_manage_finances': canManageFinances,
      'can_manage_academics': canManageAcademics,
    };
  }
}

/// Request model for updating a principal
class UpdatePrincipalRequest {
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? dateOfBirth;
  final String? department;
  final String? position;
  final AddressInfoRequest? addressInfo;
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

  Map<String, dynamic> toJson() {
    return {
      if (firstName != null) 'first_name': firstName,
      if (middleName != null) 'middle_name': middleName,
      if (lastName != null) 'last_name': lastName,
      if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
      if (department != null) 'department': department,
      if (position != null) 'position': position,
      if (addressInfo != null) 'address_info': addressInfo!.toJson(),
      if (employmentType != null) 'employment_type': employmentType,
      if (hireDate != null) 'hire_date': hireDate,
      if (canManageUsers != null) 'can_manage_users': canManageUsers,
      if (canManageFinances != null) 'can_manage_finances': canManageFinances,
      if (canManageAcademics != null)
        'can_manage_academics': canManageAcademics,
    };
  }
}

/// Request model for address info
class AddressInfoRequest {
  final String region;
  final String zone;
  final String city;
  final String kebeleNo;

  AddressInfoRequest({
    required this.region,
    required this.zone,
    required this.city,
    required this.kebeleNo,
  });

  Map<String, dynamic> toJson() {
    return {
      'region': region,
      'zone': zone,
      'city': city,
      'kebele_no': kebeleNo,
    };
  }
}

/// Principal User Model (updated with toJson method)
class UpdatePrincipalUser {
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

  UpdatePrincipalUser({
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

  factory UpdatePrincipalUser.fromJson(Map<String, dynamic> json) {
    return UpdatePrincipalUser(
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'auth_user_id': authUserId,
      'first_name': firstName,
      'middle_name': middleName,
      'last_name': lastName,
      'date_of_birth': dateOfBirth,
      'staff_id': staffId,
      'department': department,
      'position': position,
      'staff_type': staffType,
      'address_info': addressInfo.toJson(),
      'employment_type': employmentType,
      'hire_date': hireDate,
      'can_manage_users': canManageUsers,
      'can_manage_finances': canManageFinances,
      'can_manage_academics': canManageAcademics,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  String get fullName => '$firstName ${middleName ?? ''} $lastName'.trim();
}
