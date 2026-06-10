// File: school_organzation_service.dart (Complete Remote Service)
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:ui_temarlije/data/models/school_organzation.dart';
import 'package:ui_temarlije/data/repositories/school_organzation_repository.dart';
import 'package:ui_temarlije/service/network/dio_client.dart';

/// import 'package:ui_temarlije/utils/helpers/network_manager.dart';
/// Service for remote school organization operations
/// Handles all API calls to the backend server
class SchoolOrganizationService extends GetxService {
  static SchoolOrganizationService get instance => Get.find();

  final DioClient _dioClient = Get.find<DioClient>();
  // final NetworkManager _networkManager = Get.find<NetworkManager>();

  /// Creates a new school organization on the remote server
  /// Returns the created SchoolOrganizationModel
  /// Throws exception with user-friendly message on failure
  Future<SchoolOrganzationModel> createSchoolOrg(
    CreateSchoolOrganzationRequest schoolData,
  ) async {
    // Check internet connectivity before making request
    // if (!await _networkManager.checkConnectivity()) {
    //   throw Exception('No internet connection');
    // }
    final SchoolOrganzationRepository localRepo = SchoolOrganzationRepository();
    try {
      final response = await _dioClient.post(
        '/org/school',
        data: schoolData.toJson(),
      );

      final schoolOrganizationResponse = SchoolOrganzationModel.fromJson(
        response.data,
      );
      await localRepo.createSchoolOrg(schoolOrganizationResponse);
      return schoolOrganizationResponse;
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

  /// Retrieves a school organization by tenant ID
  Future<SchoolOrganzationModel?> getSchoolByTenantId(String tenantId) async {
    // if (!await _networkManager.checkConnectivity()) {
    //   throw Exception('No internet connection');
    // }

    try {
      final response = await _dioClient.get('/org/$tenantId');
      return SchoolOrganzationModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return null;
      }
      throw Exception(e.response?.data['message'] ?? 'Failed to fetch school');
    } catch (e) {
      rethrow;
    }
  }

  /// Retrieves a school organization by ID
  Future<SchoolOrganzationModel?> getSchoolById(String schoolId) async {
    // if (!await _networkManager.checkConnectivity()) {
    //   throw Exception('No internet connection');
    // }

    try {
      final response = await _dioClient.get('/org/id/$schoolId');
      return SchoolOrganzationModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return null;
      }
      throw Exception(e.response?.data['message'] ?? 'Failed to fetch school');
    } catch (e) {
      rethrow;
    }
  }

  /// Updates an existing school organization
  Future<SchoolOrganzationModel> updateSchoolOrg(
    String schoolId,
    UpdateSchoolOrganzationRequest updateData,
  ) async {
    // if (!await _networkManager.checkConnectivity()) {
    //   throw Exception('No internet connection');
    // }

    try {
      final response = await _dioClient.put(
        '/org/school/$schoolId',
        data: updateData.toJson(),
      );
      return SchoolOrganzationModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw Exception('School not found');
      } else if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized. Please login again.');
      }
      throw Exception(e.response?.data['message'] ?? 'Failed to update school');
    } catch (e) {
      rethrow;
    }
  }

  /// Deletes a school organization
  Future<void> deleteSchoolOrg(String schoolId) async {
    // if (!await _networkManager.checkConnectivity()) {
    //   throw Exception('No internet connection');
    // }

    try {
      await _dioClient.delete('/org/school/$schoolId');
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw Exception('School not found');
      }
      throw Exception(e.response?.data['message'] ?? 'Failed to delete school');
    } catch (e) {
      rethrow;
    }
  }

  /// Lists all school organizations for the current user
  Future<List<SchoolOrganzationModel>> listSchools() async {
    // if (!await _networkManager.checkConnectivity()) {
    //   throw Exception('No internet connection');
    // }

    try {
      final response = await _dioClient.get('/org/school');
      final List<dynamic> data = response.data;
      return data.map((json) => SchoolOrganzationModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Failed to fetch schools');
    } catch (e) {
      rethrow;
    }
  }
}
