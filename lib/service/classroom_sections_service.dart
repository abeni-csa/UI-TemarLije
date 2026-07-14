import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/data/models/classroom.dart';
import 'package:ui_temarlije/data/models/section.dart';
import 'package:ui_temarlije/service/network/dio_client.dart';

class ClassroomService extends GetxService {
  static ClassroomService get instance => Get.find();

  final DioClient _dioClient = Get.find<DioClient>();

  /// Get all classrooms for a school and academic year
  Future<List<Classroom>> getClassroomsByAcademicYear(
    String schoolId,
    String academicYearId,
  ) async {
    try {
      final response = await _dioClient.get(
        '/org/school/$schoolId/classroom/accadmic_year/$academicYearId',
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data is List
            ? response.data
            : (response.data['classrooms'] ?? response.data['data'] ?? []);
        return data.map((json) => Classroom.fromJson(json)).toList();
      }
      return [];
    } on DioException catch (e) {
      print('Error getting classrooms: ${e.message}');
      return [];
    }
  }

  /// Get all classrooms grouped by grade level
  Future<Map<GradeLevel, List<Classroom>>> getClassroomsGroupedByLevel(
    String schoolId,
    String academicYearId,
  ) async {
    final classrooms = await getClassroomsByAcademicYear(
      schoolId,
      academicYearId,
    );
    final Map<GradeLevel, List<Classroom>> grouped = {};

    for (final classroom in classrooms) {
      grouped.putIfAbsent(classroom.gradeLevel, () => []);
      grouped[classroom.gradeLevel]!.add(classroom);
    }

    // Sort each group by display order
    for (final key in grouped.keys) {
      grouped[key]!.sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
    }

    return grouped;
  }

  /// Generate classrooms for a grade level
  Future<List<Classroom>> generateClassrooms(
    String schoolId,
    CreateClassroomRequest request,
  ) async {
    try {
      final response = await _dioClient.post(
        '/org/school/$schoolId/classroom/generate',
        data: request.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        final classrooms = data['classrooms'] ?? data['data'] ?? [];
        if (classrooms is List) {
          return classrooms.map((json) => Classroom.fromJson(json)).toList();
        }
        return [];
      }
      throw Exception('Failed to generate classrooms');
    } on DioException catch (e) {
      throw Exception('Failed to generate classrooms: ${e.message}');
    }
  }

  /// Delete a classroom
  Future<void> deleteClassroom(String schoolId, String classroomId) async {
    try {
      await _dioClient.delete('/org/school/$schoolId/classroom/$classroomId');
    } on DioException catch (e) {
      throw Exception('Failed to delete classroom: ${e.message}');
    }
  }

  /// Get sections for a classroom
  Future<List<Section>> getSectionsByClassroom(
    String schoolId,
    String classroomId,
  ) async {
    try {
      final response = await _dioClient.get(
        '/org/school/$schoolId/sections?classroom_id=$classroomId',
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data is List
            ? response.data
            : (response.data['sections'] ?? response.data['data'] ?? []);
        return data.map((json) => Section.fromJson(json)).toList();
      }
      return [];
    } on DioException catch (e) {
      print('Error getting sections: ${e.message}');
      return [];
    }
  }

  Future<void> createBulkSections(
    String schoolId,
    BulkSectionRequest request,
  ) async {
    try {
      final response = await _dioClient.post(
        '/org/school/$schoolId/sections/bulk',
        data: request.toJson(),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Failed to create sections: ${response.data}');
      }
    } catch (e) {
      throw Exception('Failed to create sections: $e');
    }
  }

  /// Bulk create sections for all classrooms
  Future<List<Section>> bulkCreateSections(
    String schoolId,
    BulkSectionRequest request,
  ) async {
    try {
      final response = await _dioClient.post(
        '/org/school/$schoolId/sections/bulk',
        data: request.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        final sections = data['sections'] ?? data['data'] ?? [];
        if (sections is List) {
          return sections.map((json) => Section.fromJson(json)).toList();
        }
        return [];
      }
      throw Exception('Failed to create sections');
    } on DioException catch (e) {
      throw Exception('Failed to create sections: ${e.message}');
    }
  }

  /// Create single section for a classroom
  Future<Section> createSection(
    String schoolId,
    String academicYearId,
    Map<String, dynamic> request,
  ) async {
    try {
      final response = await _dioClient.post(
        '/org/school/$schoolId/sections/single-section',
        data: {...request, 'academic_year_id': academicYearId},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Section.fromJson(response.data);
      }
      throw Exception('Failed to create section');
    } on DioException catch (e) {
      throw Exception('Failed to create section: ${e.message}');
    }
  }
}
