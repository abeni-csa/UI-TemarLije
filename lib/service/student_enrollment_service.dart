import 'package:get/get.dart';
import 'package:ui_temarlije/data/models/student_enrollment.dart';
import 'package:ui_temarlije/service/network/dio_client.dart';
import 'package:uuid/uuid.dart';

class StudentEnrollmentService extends GetxService {
  final DioClient _dioClient = Get.find<DioClient>();

  // Enroll a single student
  Future<StudentEnrollment> enrollStudent({
    required UuidValue schoolId,
    required String studentId,
    required String sectionId,
    required String academicYearId,
    DateTime? enrollmentDate,
  }) async {
    try {
      final response = await _dioClient.post(
        '/org/school/$schoolId/enrollments',
        data: {
          'student_id': studentId,
          'section_id': sectionId,
          'academic_year_id': academicYearId,
          'enrollment_date': enrollmentDate?.toIso8601String().split('T').first,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return StudentEnrollment.fromJson(response.data);
      } else {
        throw Exception('Failed to enroll student: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error enrolling student: $e');
    }
  }

  // Bulk enroll students
  Future<List<StudentEnrollment>> bulkEnrollStudents({
    required UuidValue schoolId,
    required List<String> studentIds,
    required String sectionId,
    required String academicYearId,
    DateTime? enrollmentDate,
  }) async {
    try {
      final response = await _dioClient.post(
        '/org/school/$schoolId/enrollments/bulk',
        data: {
          'student_ids': studentIds,
          'section_id': sectionId,
          'academic_year_id': academicYearId,
          'enrollment_date': enrollmentDate?.toIso8601String().split('T').first,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> data = response.data['enrollments'] ?? [];
        return data.map((json) => StudentEnrollment.fromJson(json)).toList();
      } else {
        throw Exception(
          'Failed to bulk enroll students: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error bulk enrolling students: $e');
    }
  }

  // Get single enrollment
  Future<StudentEnrollmentWithDetails> getEnrollment({
    required UuidValue schoolId,
    required String enrollmentId,
  }) async {
    try {
      final response = await _dioClient.get(
        '/org/school/$schoolId/enrollments/$enrollmentId',
      );

      if (response.statusCode == 200) {
        return StudentEnrollmentWithDetails.fromJson(response.data);
      } else {
        throw Exception('Failed to get enrollment: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error getting enrollment: $e');
    }
  }

  // Get enrollments with improved null safety
  Future<List<StudentEnrollmentWithDetails>> getEnrollments({
    required UuidValue schoolId,
    String? studentId,
    String? sectionId,
    String? academicYearId,
    EnrollmentStatus? status,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (studentId != null && studentId.isNotEmpty) {
        queryParams['student_id'] = studentId;
      }
      if (sectionId != null && sectionId.isNotEmpty) {
        queryParams['section_id'] = sectionId;
      }
      if (academicYearId != null && academicYearId.isNotEmpty) {
        queryParams['academic_year_id'] = academicYearId;
      }
      if (status != null) {
        queryParams['status'] = status.toString().split('.').last;
      }

      // Build URL with query parameters
      String url = '/org/school/$schoolId/enrollments';
      if (queryParams.isNotEmpty) {
        final queryString = queryParams.entries
            .map((e) => '${e.key}=${Uri.encodeComponent(e.value.toString())}')
            .join('&');
        url = '$url?$queryString';
      }

      print('GET $url');

      final response = await _dioClient.get(url);

      if (response.statusCode == 200) {
        // Handle different response structures with null safety
        List<dynamic> data = [];

        if (response.data is List) {
          data = response.data;
        } else if (response.data is Map) {
          data =
              response.data['enrollments'] ??
              response.data['data'] ??
              response.data['items'] ??
              [];
        }

        print('Found ${data.length} enrollments');
        print('Found ${data} enrollments');

        return data.map((json) {
          try {
            return StudentEnrollmentWithDetails.fromJson(_safeJson(json));
          } catch (e) {
            print('Error parsing enrollment: $e');
            print('JSON data: $json');
            // Return a default or rethrow
            rethrow;
          }
        }).toList();
      } else {
        throw Exception('Failed to get enrollments: ${response.statusCode}');
      }
    } catch (e) {
      print('Error getting enrollments: $e');
      throw Exception('Error getting enrollments: $e');
    }
  }

  // Safe JSON parsing helper
  Map<String, dynamic> _safeJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      return json;
    }
    return {};
  }

  // Get student's current enrollment
  Future<StudentEnrollmentWithDetails?> getCurrentEnrollment({
    required UuidValue schoolId,
    required String studentId,
  }) async {
    try {
      final response = await _dioClient.get(
        '/org/school/$schoolId/enrollments/current',
        queryParameters: {'student_id': studentId},
      );

      if (response.statusCode == 200) {
        return StudentEnrollmentWithDetails.fromJson(response.data);
      } else if (response.statusCode == 404) {
        return null;
      } else {
        throw Exception(
          'Failed to get current enrollment: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error getting current enrollment: $e');
    }
  }

  // Update enrollment status
  Future<StudentEnrollment> updateEnrollmentStatus({
    required UuidValue schoolId,
    required String enrollmentId,
    required EnrollmentStatus status,
  }) async {
    try {
      final response = await _dioClient.patch(
        '/org/school/$schoolId/enrollments/$enrollmentId/status',
        data: {'status': status.toString().split('.').last},
      );

      if (response.statusCode == 200) {
        return StudentEnrollment.fromJson(response.data);
      } else {
        throw Exception(
          'Failed to update enrollment status: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error updating enrollment status: $e');
    }
  }

  // Transfer student to new section
  Future<StudentEnrollment> transferStudent({
    required UuidValue schoolId,
    required String enrollmentId,
    required String newSectionId,
  }) async {
    try {
      final response = await _dioClient.put(
        '/org/school/$schoolId/enrollments/$enrollmentId/transfer',
        data: {'new_section_id': newSectionId},
      );

      if (response.statusCode == 200) {
        return StudentEnrollment.fromJson(response.data);
      } else {
        throw Exception('Failed to transfer student: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error transferring student: $e');
    }
  }

  // Withdraw student
  Future<StudentEnrollment> withdrawStudent({
    required UuidValue schoolId,
    required String enrollmentId,
  }) async {
    try {
      final response = await _dioClient.patch(
        '/org/school/$schoolId/enrollments/$enrollmentId/withdraw',
      );

      if (response.statusCode == 200) {
        return StudentEnrollment.fromJson(response.data);
      } else {
        throw Exception('Failed to withdraw student: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error withdrawing student: $e');
    }
  }

  // Delete enrollment
  Future<bool> deleteEnrollment({
    required UuidValue schoolId,
    required String enrollmentId,
  }) async {
    try {
      final response = await _dioClient.delete(
        '/org/school/$schoolId/enrollments/$enrollmentId',
      );

      if (response.statusCode == 204) {
        return true;
      } else {
        throw Exception('Failed to delete enrollment: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error deleting enrollment: $e');
    }
  }

  // Get enrollment summary
  Future<EnrollmentSummary> getEnrollmentSummary({
    required UuidValue schoolId,
    required String academicYearId,
  }) async {
    try {
      final response = await _dioClient.get(
        '/org/school/$schoolId/enrollments/summary',
        queryParameters: {'academic_year_id': academicYearId},
      );

      if (response.statusCode == 200) {
        return EnrollmentSummary.fromJson(response.data);
      } else {
        throw Exception(
          'Failed to get enrollment summary: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error getting enrollment summary: $e');
    }
  }
}
