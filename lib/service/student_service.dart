import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/data/models/students.dart';
import 'package:ui_temarlije/service/network/dio_client.dart';
import 'package:ui_temarlije/utils/constants/enums.dart';
import 'package:uuid/uuid.dart';

class StudentService extends GetxService {
  final DioClient _dioClient = Get.find<DioClient>();

  // lib/service/student_service.dart - FIXED createKgStudent method
  Future<KGStudents> createKgStudent({
    required KGStudentRegistrationRequest kgStudent,
    required UuidValue schoolId,
    required String academicYearId,
  }) async {
    final requestData = <String, dynamic>{
      "first_name": kgStudent.firstName,
      "middle_name": kgStudent.middleName,
      "last_name": kgStudent.lastName,
      "date_of_birth": kgStudent.dateOfBirth.toIso8601String().split('T')[0],
      "phone_number": kgStudent.phoneNumber,
      "gender": kgStudent.gender,
      "guardian_id": kgStudent.guardianId
          .toString(), // Convert UuidValue to String
      "national_id": kgStudent.nationalId,
      "address_info": {
        "region": kgStudent.addressInfo.region,
        "zone": kgStudent.addressInfo.zone,
        "city": kgStudent.addressInfo.city,
        "kebele_no": kgStudent.addressInfo.kebeleNo,
      },
      "birth_certificate": {
        "certificate_number": kgStudent.birthCertificate.certificateNumber,
        "issuing_authority": kgStudent.birthCertificate.issuingAuthority.name
            .toTitleCase(), // Use enum name
        "original_copy": kgStudent.birthCertificate.originalCopy,
        "photocopy_provided": kgStudent.birthCertificate.photocopyProvided,
        "issue_date": kgStudent.birthCertificate.issueDate
            .toIso8601String()
            .split('T')[0],
      },
    };

    debugPrint('Request JSON being sent: ${jsonEncode(requestData)}');

    try {
      final response = await _dioClient.post(
        '/org/school/$schoolId/members/$academicYearId/kg',
        data: requestData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return KGStudents.fromJson(response.data);
      } else {
        throw Exception('Failed to enroll student: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error creating KG student: $e');
      throw Exception('Error enrolling student: $e');
    }
  }

  Future<KGStudents> createKgStudentsss({
    required KGStudentRegistrationRequest kgStudent,
    required UuidValue schoolId,
    required String academicYearId,
  }) async {
    final requestData = <String, dynamic>{
      "first_name": kgStudent.firstName,
      "middle_name": kgStudent.middleName,
      "last_name": kgStudent.lastName,
      "date_of_birth": kgStudent.dateOfBirth.toIso8601String().split('T')[0],
      "phone_number": kgStudent.phoneNumber,
      "gender": kgStudent.gender,
      "guardian_id": kgStudent.guardianId,
      "national_id": kgStudent.nationalId,
      "address_info": {
        "region": kgStudent.addressInfo.region,
        "zone": kgStudent.addressInfo.zone,
        "city": kgStudent.addressInfo.city,
        "kebele_no": kgStudent.addressInfo.kebeleNo,
      },
      "birth_certificate": {
        "certificate_number": kgStudent.birthCertificate.certificateNumber,
        "issuing_authority": kgStudent.birthCertificate.issuingAuthority,
        "original_copy": kgStudent.birthCertificate.originalCopy,
        "photocopy_provided": kgStudent.birthCertificate.photocopyProvided,
        "issue_date": kgStudent.birthCertificate.issueDate
            .toIso8601String()
            .split('T')[0],
      },
    };
    debugPrint('Request JSON being sent: ${jsonEncode(requestData)}');
    try {
      final response = await _dioClient.post(
        '/org/school/$schoolId/members/$academicYearId/kg',
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return KGStudents.fromJson(response.data);
      } else {
        throw Exception('Failed to enroll student: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error enrolling student: $e');
    }
  }

  // Get KG Students by Academic Year
  Future<List<KGStudents>> getKGStudents({
    required UuidValue schoolId,
    required UuidValue academicYearId,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await _dioClient.get(
        '/org/school/$schoolId/members/$academicYearId/kg',
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => KGStudents.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load KG students: ${response.data}');
      }
    } catch (e) {
      throw Exception('Failed to load KG students: $e');
    }
  }

  // Get KG Student by ID
  Future<KGStudents> getKGStudentById({
    required UuidValue schoolId,
    required UuidValue academicYearId,
    required UuidValue studentId,
  }) async {
    try {
      final response = await _dioClient.get(
        '/api/schools/$schoolId/academic-years/$academicYearId/kg-students/$studentId',
      );

      if (response.statusCode == 200) {
        return KGStudents.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to load KG student: ${response.data}');
      }
    } catch (e) {
      throw Exception('Failed to load KG student: $e');
    }
  }

  // Update KG Student
  Future<void> updateKGStudent({
    required UuidValue schoolId,
    required UuidValue academicYearId,
    required UuidValue studentId,
    required Map<String, dynamic> updateData,
  }) async {
    try {
      final response = await _dioClient.put(
        '/api/schools/$schoolId/academic-years/$academicYearId/kg-students/$studentId',
        data: updateData,
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update KG student: ${response.data}');
      }
    } catch (e) {
      throw Exception('Failed to update KG student: $e');
    }
  }

  // Delete KG Student
  Future<void> deleteKGStudent({
    required UuidValue schoolId,
    required UuidValue academicYearId,
    required UuidValue studentId,
  }) async {
    try {
      final response = await _dioClient.delete(
        '/org/school/$schoolId/members/$academicYearId/kg-students/$studentId',
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete KG student: ${response.data}');
      }
    } catch (e) {
      throw Exception('Failed to delete KG student: $e');
    }
  }

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
