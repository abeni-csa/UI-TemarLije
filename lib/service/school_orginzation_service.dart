import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:ui_temarlije/data/models/membeship.dart';
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

  /// Fetches all school organizations from remote server
  Future<List<SchoolOrganzationModel>> getAllSchools() async {
    try {
      final response = await _dioClient.get('/school-organizations');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data
            .map((json) => SchoolOrganzationModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to fetch school organizations');
      }
    } catch (e) {
      print('Error fetching schools: $e');
      rethrow;
    }
  }

  // School endpoints
  Future<List<SchoolOrganzationModel>> getSchools() async {
    try {
      final response = await _dioClient.get('/school/list');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data is List
            ? response.data
            : (response.data['schools'] ?? response.data['data'] ?? []);
        return data
            .map((json) => SchoolOrganzationModel.fromJson(json))
            .toList();
      }
      return [];
    } on DioException catch (e) {
      if (kDebugMode) print('Error getting schools: ${_handleError(e)}');
      return [];
    }
  }

  Future<SchoolOrganzationModel?> getSchool(String schoolId) async {
    try {
      final response = await _dioClient.get('/school/$schoolId');

      if (response.statusCode == 200) {
        return SchoolOrganzationModel.fromJson(response.data);
      }
      return null;
    } on DioException catch (e) {
      if (kDebugMode) print('Error getting school: ${_handleError(e)}');
      return null;
    }
  }

  // Membership endpoints
  Future<Membership> joinSchool({
    required String schoolId,
    required String userId,
    required UserType membershipType,
  }) async {
    try {
      String endpoint;
      switch (membershipType) {
        case UserType.student:
          endpoint = '/school/$schoolId/members/join/student';
          break;
        case UserType.staff:
          endpoint = '/school/$schoolId/members/join/staff';
          break;
        case UserType.teacher:
          endpoint = '/school/$schoolId/members/join/teacher';
          break;
        default:
          endpoint = '/school/$schoolId/members/join/student';
      }

      final request = MembershipRequest(
        userId: userId,
        membershipType: membershipType,
      );

      final response = await _dioClient.post(endpoint, data: request.toJson());

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        final membershipData = data['created'] ?? data['membership'] ?? data;
        return Membership.fromJson(membershipData);
      }
      throw Exception('Failed to join school');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<List<Membership>> getUserMemberships(String userId) async {
    try {
      final response = await _dioClient.get('/members/my-memberships');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data is List
            ? response.data
            : (response.data['memberships'] ?? response.data['data'] ?? []);
        return data.map((json) => Membership.fromJson(json)).toList();
      }
      return [];
    } on DioException catch (e) {
      if (kDebugMode)
        print('Error getting user memberships: ${_handleError(e)}');
      return [];
    }
  }

  Future<List<Membership>> getSchoolMembers(String schoolId) async {
    try {
      final response = await _dioClient.get(
        '/school/$schoolId/members/list-members',
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data is List
            ? response.data
            : (response.data['members'] ?? response.data['data'] ?? []);
        return data.map((json) => Membership.fromJson(json)).toList();
      }
      return [];
    } on DioException catch (e) {
      if (kDebugMode) print('Error getting school members: ${_handleError(e)}');
      return [];
    }
  }

  Future<List<Membership>> getPendingRequests(String schoolId) async {
    try {
      final response = await _dioClient.get(
        '/school/$schoolId/members/pending-requests',
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data is List
            ? response.data
            : (response.data['requests'] ?? response.data['data'] ?? []);
        return data.map((json) => Membership.fromJson(json)).toList();
      }
      return [];
    } on DioException catch (e) {
      if (kDebugMode)
        print('Error getting pending requests: ${_handleError(e)}');
      return [];
    }
  }

  Future<List<Membership>> updateMembershipStatus({
    required String schoolId,
    required MembershipStatus status,
    required List<String> userIds,
  }) async {
    try {
      final bulkUpdate = BulkStatusUpdate(status: status, userIds: userIds);
      final response = await _dioClient.post(
        '/school/$schoolId/members/update-status',
        data: bulkUpdate.toJson(),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data is List
            ? response.data
            : (response.data['updated'] ?? response.data['data'] ?? []);
        return data.map((json) => Membership.fromJson(json)).toList();
      }
      throw Exception('Failed to update status');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> bulkUpdateStatus({
    required String schoolId,
    required MembershipStatus status,
    required List<String> userIds,
  }) async {
    await updateMembershipStatus(
      schoolId: schoolId,
      status: status,
      userIds: userIds,
    );
  }

  String _handleError(DioException error) {
    if (error.response != null) {
      final data = error.response!.data;
      if (data is Map) {
        return data['error'] ?? data['message'] ?? 'An error occurred';
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
