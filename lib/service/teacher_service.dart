import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/data/models/teacher.dart';
import 'package:ui_temarlije/service/network/dio_client.dart';
import 'package:uuid/uuid.dart';

class TeacherService extends GetxService {
  final DioClient _dioClient = Get.find<DioClient>();

  /// Get teachers by school ID
  Future<List<Teacher>> getTeachersBySchool(String schoolId) async {
    try {
      final response = await _dioClient.get(
        '/org/school/$schoolId/members/teachers',
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data is List
            ? response.data
            : (response.data['teachers'] ?? response.data['data'] ?? []);
        return data.map((json) => Teacher.fromJson(json)).toList();
      }
      return [];
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Error loading teachers for school: $e');
    }
  }

  /// Get all teachers with pagination
  Future<TeacherListResponse> getAllTeachers({
    int page = 1,
    int limit = 20,
    String? search,
    required UuidValue schoolId,
    String? employmentType,
    String? gender,
    bool? isHomeroom,
  }) async {
    try {
      final response = await _dioClient.get(
        '/org/school/$schoolId/members/teachers',
      );
      if (response.statusCode == 200) {
        // Handle different response structures
        if (response.data is List) {
          // If it returns a list directly
          final List<Teacher> teachers = (response.data as List)
              .map((json) => Teacher.fromJson(json))
              .toList();
          return TeacherListResponse(
            teachers: teachers,
            totalItems: teachers.length,
            totalPages: 1,
            currentPage: 1,
          );
        } else if (response.data is Map) {
          final data = response.data as Map<String, dynamic>;

          // Check if it has a data field
          if (data.containsKey('data')) {
            final List<dynamic> teacherData = data['data'] is List
                ? data['data']
                : data['data']['teachers'] ?? [];

            final List<Teacher> teachers = teacherData
                .map((json) => Teacher.fromJson(json))
                .toList();

            return TeacherListResponse(
              teachers: teachers,
              totalItems:
                  data['total'] ?? data['totalItems'] ?? teachers.length,
              totalPages: data['totalPages'] ?? 1,
              currentPage: data['currentPage'] ?? 1,
            );
          }
        }

        // Fallback: try to parse anyway
        final List<dynamic> data = response.data is List ? response.data : [];
        return TeacherListResponse(
          teachers: data.map((json) => Teacher.fromJson(json)).toList(),
          totalItems: data.length,
          totalPages: 1,
          currentPage: 1,
        );
      } else {
        throw Exception('Failed to load teachers: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Error loading teachers: $e');
    }
  }

  /// Search teachers by query
  Future<List<Teacher>> searchTeachers(String query) async {
    try {
      final response = await _dioClient.get(
        '/user/teacher/search',
        queryParameters: {'q': query},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data is List
            ? response.data
            : (response.data['teachers'] ?? response.data['data'] ?? []);
        return data.map((json) => Teacher.fromJson(json)).toList();
      }
      return [];
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Error searching teachers: $e');
    }
  }

  /// Get teacher by ID
  Future<Teacher> getTeacherById(String teacherId) async {
    try {
      final response = await _dioClient.get('/user/teacher/$teacherId');

      if (response.statusCode == 200) {
        return Teacher.fromJson(response.data);
      } else {
        throw Exception('Failed to load teacher details');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Error loading teacher details: $e');
    }
  }
}

/// Response model for paginated teacher list
class TeacherListResponse {
  final List<Teacher> teachers;
  final int totalItems;
  final int totalPages;
  final int currentPage;

  TeacherListResponse({
    required this.teachers,
    required this.totalItems,
    required this.totalPages,
    required this.currentPage,
  });

  factory TeacherListResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> data = json['data'] ?? [];
    return TeacherListResponse(
      teachers: data.map((e) => Teacher.fromJson(e)).toList(),
      totalItems: json['total'] ?? json['totalItems'] ?? data.length,
      totalPages: json['totalPages'] ?? 1,
      currentPage: json['currentPage'] ?? 1,
    );
  }
}
