import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:ui_temarlije/data/models/subject.dart';
import 'package:ui_temarlije/service/network/dio_client.dart';
import 'package:ui_temarlije/utils/constants/enums.dart';
import 'package:uuid/uuid.dart';

/// Service for remote Subject Related operations
/// Handles all API calls to the backend server
class SubjectService extends GetxService {
  static SubjectService get instance => Get.find();

  final DioClient _dioClient = Get.find<DioClient>();
  // final NetworkManager _networkManager = Get.find<NetworkManager>();
  static const String _basePath = '/org/school';

  /// Generate classrooms for a grade level
  /// Creates a new school organization on the remote server
  /// Returns the created SchoolOrganizationModel
  /// Throws exception with user-friendly message on failure
  Future<Subject> createSubjects(
    CreateSubjectRequest subjectData,
    UuidValue schoolId,
    UuidValue acadmicYear,
  ) async {
    // Check internet connectivity before making request
    // if (!await _networkManager.checkConnectivity()) {
    //   throw Exception('No internet connection');
    // }
    try {
      // scope("/school/{school_id}/")
      final response = await _dioClient.post(
        '$_basePath/$schoolId/subject/$acadmicYear',
        data: subjectData.toJson(),
      );
      print('Going To URL [+] ${(response.realUri.toString())} ');
      final subjectResponse = Subject.fromJson(response.data);
      return subjectResponse;
    } on DioException catch (e) {
      // Map HTTP errors to user-friendly messages
      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized. Please login again.');
      } else if (e.response?.statusCode == 403) {
        throw Exception('You do not have permission to create a school.');
      } else if (e.response?.statusCode == 409) {
        throw Exception('School with this tenant code already exists.');
      } else {
        throw Exception(
          e.response?.data['message'] ?? 'Failed to create school',
        );
      }
    } catch (e) {
      print('error at createSchoolOrg final catch $e');
      rethrow;
    }
  }

  /// Get all subjects for a school and academic year
  Future<List<Subject>> getSubjects(
    UuidValue schoolId,
    UuidValue academicYearId,
  ) async {
    try {
      final response = await _dioClient.get(
        '$_basePath/$schoolId/subject/$academicYearId',
      );
      if (response.statusCode == 200 && response.data is List) {
        final List<dynamic> data = response.data;
        return data.map((json) => Subject.fromJson(json)).toList();
      }
      return [];
    } on DioException catch (e) {
      if (kDebugMode) print('Error getting subjects: ${_handleError(e)}');
      return [];
    } catch (e) {
      return [];
    }
  }

  /// Get subjects by education level
  Future<List<Subject>> getSubjectsByEducationLevel(
    UuidValue schoolId,
    UuidValue academicYearId,
    EducationLevel level,
  ) async {
    try {
      final response = await _dioClient.get(
        '$_basePath/$schoolId/subject/$academicYearId/level/${level.toString().split('.').last}',
      );
      if (response.statusCode == 200 && response.data is List) {
        final List<dynamic> data = response.data;
        return data.map((json) => Subject.fromJson(json)).toList();
      }
      return [];
    } on DioException catch (e) {
      if (kDebugMode)
        print('Error getting subjects by level: ${_handleError(e)}');
      return [];
    } catch (e) {
      return [];
    }
  }

  /// Update a subject
  Future<Subject> updateSubject(
    UuidValue subjectId,
    UuidValue academicYearId,
    UuidValue schoolId,
    UpdateSubjectRequest request,
  ) async {
    try {
      final response = await _dioClient.put(
        // '$_basePath/$schoolId/subject/$subjectId',
        '$_basePath/$schoolId/subject/$academicYearId/subjects/$subjectId',
        data: request.toJson(),
      );
      return Subject.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    } catch (e) {
      rethrow;
    }
  }

  /// Delete a subject
  Future<void> deleteSubject(UuidValue subjectId, UuidValue schoolId) async {
    try {
      await _dioClient.delete(
        '$_basePath/$schoolId/subject/subjects/$subjectId',
      );
    } on DioException catch (e) {
      throw _handleError(e);
    } catch (e) {
      rethrow;
    }
  }

  String _handleError(DioException error) {
    if (error.response != null) {
      final data = error.response!.data;
      if (data is Map) {
        return data['message'] ?? data['error'] ?? 'An error occurred';
      }
      return 'Server error: ${error.response!.statusCode}';
    } else if (error.type == DioExceptionType.connectionTimeout) {
      return 'Connection timeout';
    } else if (error.type == DioExceptionType.receiveTimeout) {
      return 'Receive timeout';
    } else if (error.type == DioExceptionType.connectionError) {
      return 'No internet connection';
    }
    return error.message ?? 'An unexpected error occurred';
  }
}
