import 'package:get/get.dart';
import 'package:ui_temarlije/data/models/student_enrollment.dart';
import 'package:ui_temarlije/service/network/dio_client.dart';

class StudentEnrollmentService extends GetxService {
  final DioClient _dioClient = Get.find<DioClient>();

  // Enroll a single student
  Future<StudentEnrollment> enrollStudent({
    required String schoolId,
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
    required String schoolId,
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
    required String schoolId,
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

  // Get enrollments (with filters)
  Future<List<StudentEnrollmentWithDetails>> getEnrollments({
    required String schoolId,
    String? studentId,
    String? sectionId,
    String? academicYearId,
    EnrollmentStatus? status,
  }) async {
    try {
      // final queryParams = <String, dynamic>{};
      // if (studentId != null) queryParams['student_id'] = studentId;
      // if (sectionId != null) queryParams['section_id'] = sectionId;
      // if (academicYearId != null)
      //   queryParams['academic_year_id'] = academicYearId;
      // if (status != null)
      //   queryParams['status'] = status.toString().split('.').last;

      final response = await _dioClient.get(
        // '/org/school/$schoolId/enrollments',
        '/org/school/015cb15a-86d8-7591-bc8f-1945d440c398/enrollments?section_id=2a48e239-87f8-4fd7-b60c-fc3a48949814&academic_year_id=015cb15a-86d8-7101-ba13-c9e332e61ce0',
        // queryParameters: queryParams,
      );
      print(response.data);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['enrollments'] ?? [];
        print(data);

        return data
            .map((json) => StudentEnrollmentWithDetails.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to get enrollments: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error getting enrollments: $e');
    }
  }

  // Get student's current enrollment
  Future<StudentEnrollmentWithDetails?> getCurrentEnrollment({
    required String schoolId,
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
    required String schoolId,
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
    required String schoolId,
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
    required String schoolId,
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
    required String schoolId,
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
    required String schoolId,
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
