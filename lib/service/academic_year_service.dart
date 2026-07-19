import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:ui_temarlije/data/models/academic_year.dart';
import 'package:ui_temarlije/service/network/dio_client.dart';
import 'package:uuid/uuid.dart';

class AcademicYearService extends GetxService {
  final DioClient _dioClient = Get.find<DioClient>();

  // Base path for academic year endpoints
  static const String _basePath = '/org/school';

  Future<AcademicYearListResponse> getAcademicYears(UuidValue schoolId) async {
    try {
      final response = await _dioClient.get(
        '$_basePath/$schoolId/academic_year/list',
      );

      if (response.statusCode == 200) {
        return AcademicYearListResponse.fromJson(response.data);
      } else {
        throw Exception(
          'Failed to load academic years: ${response.statusMessage}',
        );
      }
    } on d.DioException catch (e) {
      throw Exception('Error loading academic years: ${e.message}');
    } catch (e) {
      throw Exception('Error loading academic years: $e');
    }
  }

  Future<AcademicYear> getAcademicYear(
    UuidValue schoolId,
    UuidValue academicYearId,
  ) async {
    try {
      final response = await _dioClient.get(
        '$_basePath/$schoolId/academic_year/$academicYearId',
      );

      if (response.statusCode == 200) {
        return AcademicYear.fromJson(response.data);
      } else {
        throw Exception(
          'Failed to load academic year: ${response.statusMessage}',
        );
      }
    } on d.DioException catch (e) {
      throw Exception('Error loading academic year: ${e.message}');
    } catch (e) {
      throw Exception('Error loading academic year: $e');
    }
  }

  Future<AcademicYear> getCurrentAcademicYear(UuidValue schoolId) async {
    try {
      final response = await _dioClient.get(
        '$_basePath/$schoolId/academic_year/current',
      );

      if (response.statusCode == 200) {
        return AcademicYear.fromJson(response.data);
      } else if (response.statusCode == 404) {
        throw Exception('No current academic year found');
      } else {
        throw Exception(
          'Failed to load current academic year: ${response.statusMessage}',
        );
      }
    } on d.DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw Exception('No current academic year found');
      }
      throw Exception('Error loading current academic year: ${e.message}');
    } catch (e) {
      throw Exception('Error loading current academic year: $e');
    }
  }

  Future<AcademicYear> createAcademicYear(
    UuidValue schoolId,
    CreateAcademicYearRequest request,
  ) async {
    try {
      final response = await _dioClient.post(
        '$_basePath/$schoolId/academic_year',
        data: request.toJson(),
      );

      if (response.statusCode == 201) {
        return AcademicYear.fromJson(response.data);
      } else {
        final errorMessage = 'Failed to create academic year';

        throw Exception(errorMessage);
      }
    } on d.DioException catch (e) {
      final errorMessage = 'Failed to create academic year $e';
      print(e.toString());
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('Error creating academic year: $e');
    }
  }

  Future<AcademicYear> updateAcademicYear(
    UuidValue schoolId,
    UuidValue academicYearId,
    UpdateAcademicYearRequest request,
  ) async {
    try {
      final response = await _dioClient.put(
        '$_basePath/$schoolId/academic_year/$academicYearId',
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        return AcademicYear.fromJson(response.data);
      } else {
        final errorMessage = 'Failed to update academic year';
        throw Exception(errorMessage);
      }
    } on d.DioException catch (e) {
      final errorMessage = 'Failed to update academic year $e';
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('Error updating academic year: $e');
    }
  }

  Future<void> deleteAcademicYear(
    UuidValue schoolId,
    UuidValue academicYearId,
  ) async {
    try {
      final response = await _dioClient.delete(
        '$_basePath/$schoolId/academic_year/$academicYearId',
      );

      if (response.statusCode != 200) {
        final errorMessage = 'Failed to delete academic year';
        throw Exception(errorMessage);
      }
    } on d.DioException catch (e) {
      final errorMessage = 'Failed to delete academic year $e';
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('Error deleting academic year: $e');
    }
  }
}
