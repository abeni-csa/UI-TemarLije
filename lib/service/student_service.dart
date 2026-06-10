import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/data/models/students.dart';
import 'package:ui_temarlije/service/network/dio_client.dart';

class StudentService {
  final DioClient _dioClient = Get.find<DioClient>();

  Future<Map<String, dynamic>> registerStudent({
    required Students student,
  }) async {
    debugPrint('Calling registerStudent()');

    try {
      final requestData = {
        'first_name': student.firstName,
        'middle_name': student.middleName,
        'last_name': student.lastName,
        'date_of_birth': student.dateOfBirth.toIso8601String().split(
          'T',
        )[0], // Just YYYY-MM-DD
        'phone_number': student.phoneNumber,
        'gender': student.gender,
        'address_info': {
          'region': student.addressInfo.region,
          'zone': student.addressInfo.zone,
          'city': student.addressInfo.city,
          'kebele_no': student.addressInfo.kebeleNo,
        },
      };

      debugPrint('Request JSON being sent: ${jsonEncode(requestData)}');

      final response = await _dioClient.post(
        '/user/student',
        data: requestData,
      );

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'data': response.data,
          'message': 'Registration successful',
        };
      } else {
        return {
          'success': false,
          'message': response.data['message'] ?? 'Registration failed',
        };
      }
    } catch (e) {
      if (e is DioException) {
        debugPrint('Dio error response: ${e.response?.data}');
        debugPrint('Dio error status: ${e.response?.statusCode}');
      }
      debugPrint('Error: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> registerStudentss({
    required Students student,
  }) async {
    debugPrint('Student object: $student');

    try {
      // IMPORTANT: toJson() should return a Map<String, dynamic>
      // NOT wrapped in any additional braces or brackets
      final requestData = student.toJson();
      // Log the exact JSON being sent
      debugPrint('Request JSON being sent: ${jsonEncode(requestData)}');

      final response = await _dioClient.post(
        '/user/student',
        data: requestData, // This must be a Map, not a List or Set
      );

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'data': response.data,
          'message': 'Registration successful',
        };
      } else {
        return {
          'success': false,
          'message': response.data['message'] ?? 'Registration failed',
        };
      }
    } catch (e) {
      debugPrint('Error: $e');
      return {'success': false, 'message': e.toString()};
    }
  } // Register student with email and password

  Future<Map<String, dynamic>> registerStudents({
    required Students student,
  }) async {
    debugPrint('$student');
    try {
      final requestData = student.toJson();

      final response = await _dioClient.post(
        '/user/student',
        data: requestData,
      );
      debugPrint(response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'data': response.data,
          'message': 'Registration successful',
        };
      } else {
        return {
          'success': false,
          'message': response.data['message'] ?? 'Registration failed',
        };
      }
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // Get all students
  Future<List<Students>> getAllStudents() async {
    try {
      final response = await _dioClient.get('/students');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => Students.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      throw Exception('Failed to load students: $e');
    }
  }

  // Get student by ID
  Future<Students?> getStudentById(String id) async {
    try {
      final response = await _dioClient.get('/students/$id');
      if (response.statusCode == 200) {
        return Students.fromJson(response.data);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to load student: $e');
    }
  }

  // Update student
  Future<bool> updateStudent(String id, Students student) async {
    try {
      final response = await _dioClient.put(
        '/students/$id',
        data: student.toJson(),
      );
      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Failed to update student: $e');
    }
  }

  // Delete student
  Future<bool> deleteStudent(String id) async {
    try {
      final response = await _dioClient.delete('/students/$id');
      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Failed to delete student: $e');
    }
  }
}
