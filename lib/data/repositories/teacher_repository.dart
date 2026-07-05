// lib/repositories/teacher_repository.dart
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/data/models/teacher.dart';
import 'package:ui_temarlije/service/network/dio_client.dart';
import 'package:uuid/uuid.dart';

class TeacherRepository extends GetxService {
  static final TeacherRepository _instance = TeacherRepository._internal();
  static TeacherRepository get instance => _instance;
  final DioClient _dioClient = Get.find<DioClient>();
  TeacherRepository._internal();

  /// Get all teachers
  Future<List<Teacher>> getTeachers() async {
    try {
      final response = await _dioClient.get('/teachers');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => Teacher.fromJson(json)).toList();
      }
      throw Exception('Failed to load teachers');
    } catch (e) {
      rethrow;
    }
  }

  /// Get teacher by ID
  Future<Teacher> getTeacherById(String id) async {
    try {
      final response = await _dioClient.get('/teachers/$id');
      if (response.statusCode == 200) {
        return Teacher.fromJson(response.data);
      }
      throw Exception('Failed to load teacher');
    } catch (e) {
      rethrow;
    }
  }

  /// Create new teacher
  Future<Teacher> createTeacherLLM(CreateTeacherRequest request) async {
    try {
      final response = await _dioClient.post(
        '/teachers',
        data: request.toJson(),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        return Teacher.fromJson(response.data);
      }
      throw Exception('Failed to create teacher');
    } catch (e) {
      rethrow;
    }
  }

  Future<Teacher> createTeacher(CreateTeacherRequest request) async {
    try {
      final requestData = {
        'first_name': request.firstName,
        'middle_name': request.middleName,
        'last_name': request.lastName,
        'date_of_birth': request.dateOfBirth.toIso8601String().split(
          'T',
        )[0], // Just YYYY-MM-DD
        'qualification': request.qualification,
        'specialization': request.specialization,
        "years_of_experience": request.yearsOfExperience,
        "employment_type": request.employmentType,
        "is_homeroom_teacher": false,
        "gender": request.gender,
        "phone_number": request.phoneNumber,
        'address_info': {
          'region': request.addressInfo.region,
          'zone': request.addressInfo.zone,
          'city': request.addressInfo.city,
          'kebele_no': request.addressInfo.kebeleNo,
        },
      };

      print('Request JSON being sent: ${jsonEncode(requestData)}');

      final response = await _dioClient.post(
        '/user/principal',
        data: requestData,
      );

      if (response.statusCode == 201) {
        final principal = Teacher.fromJson(response.data);

        return principal;
      } else if (response.statusCode == 409) {
        throw Exception('Alradey Exist  principal: ${response.statusCode}');
      } else {
        throw Exception('Failed to create principal: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    }
  }

  /// Update teacher
  Future<Teacher> updateTeacher(Uuid id, UpdateTeacherRequest request) async {
    try {
      final response = await _dioClient.put(
        '/teachers/$id',
        data: request.toJson(),
      );
      if (response.statusCode == 200) {
        return Teacher.fromJson(response.data);
      }
      throw Exception('Failed to update teacher');
    } catch (e) {
      rethrow;
    }
  }

  /// Delete teacher
  Future<void> deleteTeacher(Uuid id) async {
    try {
      final response = await _dioClient.delete('/teachers/$id');
      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception('Failed to delete teacher');
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Get teachers by specialization
  Future<List<Teacher>> getTeachersBySpecialization(
    String specialization,
  ) async {
    try {
      final response = await _dioClient.get(
        '/teachers',
        queryParameters: {'specialization': specialization},
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => Teacher.fromJson(json)).toList();
      }
      throw Exception('Failed to load teachers');
    } catch (e) {
      rethrow;
    }
  }

  /// Get homeroom teachers
  Future<List<Teacher>> getHomeroomTeachers() async {
    try {
      final response = await _dioClient.get(
        '/teachers',
        queryParameters: {'is_homeroom_teacher': true},
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => Teacher.fromJson(json)).toList();
      }
      throw Exception('Failed to load homeroom teachers');
    } catch (e) {
      rethrow;
    }
  }
}

/// Request model for creating a teacher
class CreateTeacherRequest {
  final String firstName;
  final String middleName;
  final String lastName;
  final DateTime dateOfBirth;
  final String qualification;
  final List<String> specialization;
  final int yearsOfExperience;
  final String employmentType;
  final bool isHomeroomTeacher;
  final String phoneNumber;
  final String gender;
  final AddressInfo addressInfo;

  CreateTeacherRequest({
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.dateOfBirth,
    required this.qualification,
    required this.specialization,
    required this.yearsOfExperience,
    required this.employmentType,
    required this.isHomeroomTeacher,
    required this.phoneNumber,
    required this.gender,
    required this.addressInfo,
  });

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'middle_name': middleName,
      'last_name': lastName,
      'date_of_birth': dateOfBirth,
      'qualification': qualification,
      'specialization': specialization,
      'years_of_experience': yearsOfExperience,
      'employment_type': employmentType,
      'is_homeroom_teacher': isHomeroomTeacher,
      'phone_number': phoneNumber,
      'gender': gender,
      'address_info': addressInfo.toJson(),
    };
  }
}

/// Request model for updating a teacher
class UpdateTeacherRequest {
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? dateOfBirth;
  final String? qualification;
  final List<String>? specialization;
  final int? yearsOfExperience;
  final String? employmentType;
  final bool? isHomeroomTeacher;
  final String? phoneNumber;
  final String? gender;
  final AddressInfo? addressInfo;

  UpdateTeacherRequest({
    this.firstName,
    this.middleName,
    this.lastName,
    this.dateOfBirth,
    this.qualification,
    this.specialization,
    this.yearsOfExperience,
    this.employmentType,
    this.isHomeroomTeacher,
    this.phoneNumber,
    this.gender,
    this.addressInfo,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    if (firstName != null) json['first_name'] = firstName;
    if (middleName != null) json['middle_name'] = middleName;
    if (lastName != null) json['last_name'] = lastName;
    if (dateOfBirth != null) json['date_of_birth'] = dateOfBirth;
    if (qualification != null) json['qualification'] = qualification;
    if (specialization != null) json['specialization'] = specialization;
    if (yearsOfExperience != null)
      json['years_of_experience'] = yearsOfExperience;
    if (employmentType != null) json['employment_type'] = employmentType;
    if (isHomeroomTeacher != null)
      json['is_homeroom_teacher'] = isHomeroomTeacher;
    if (phoneNumber != null) json['phone_number'] = phoneNumber;
    if (gender != null) json['gender'] = gender;
    if (addressInfo != null) json['address_info'] = addressInfo!.toJson();
    return json;
  }
}

/// Address information model
class AddressInfo {
  final String region;
  final String zone;
  final String city;
  final String kebeleNo;

  AddressInfo({
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

  factory AddressInfo.fromJson(Map<String, dynamic> json) {
    return AddressInfo(
      region: json['region'] ?? '',
      zone: json['zone'] ?? '',
      city: json['city'] ?? '',
      kebeleNo: json['kebele_no'] ?? '',
    );
  }
}
