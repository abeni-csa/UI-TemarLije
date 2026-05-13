import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ui_temarlije/data/models/principal_user.dart';
import 'package:ui_temarlije/service/network/dio_client.dart';
import 'package:ui_temarlije/data/models/auth_models.dart';

/// Repository handling all authentication-related API operations
/// Manages token storage, network requests, and error handling
class UsersRepository extends GetxService {
  static UsersRepository get instance => Get.find();

  final DioClient _dioClient = Get.find<DioClient>();
  // final NetworkManager _networkManager = Get.find<NetworkManager>();
  final GetStorage _storage = GetStorage();

  /// Authenticates user with username/email and password
  /// Returns AuthResponse containing tokens and 2FA status
  /// Throws exception with user-friendly message on failure

  Future<PrincipalUser> getPrincipal() async {
    try {
      final response = await _dioClient.get('/user/principal');

      // Parse the response into PrincipalUser model
      final principalData = PrincipalUser.fromJson(response.data);

      return principalData;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized - Please login again');
      } else if (e.response?.statusCode == 404) {
        throw Exception('Principal not found');
      } else {
        throw Exception(
          e.response?.data['message'] ?? 'Failed to fetch principal data',
        );
      }
    } catch (e) {
      throw Exception('Error fetching principal data: $e');
    }
  }

  /// Creates a new principal user
  /// Returns created PrincipalUser object
  Future<PrincipalUser> createPrincipal(CreatePrincipalRequest request) async {
    try {
      final response = await _dioClient.post(
        '/user/principal',
        data: request.toJson(),
      );

      final principal = PrincipalUser.fromJson(response.data);
      return principal;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw Exception(
          'Invalid principal data: ${e.response?.data['message']}',
        );
      } else if (e.response?.statusCode == 409) {
        throw Exception('Principal with this staff ID already exists');
      } else if (e.response?.statusCode == 403) {
        throw Exception('You do not have permission to create principals');
      } else {
        throw Exception(
          e.response?.data['message'] ?? 'Failed to create principal',
        );
      }
    } catch (e) {
      throw Exception('Error creating principal: $e');
    }
  }

  // ==================== READ OPERATIONS ====================

  /// Fetches the principal user information
  /// Returns PrincipalUser object with user details
  Future<PrincipalUser> getPrincipals() async {
    try {
      final response = await _dioClient.get('/user/principal');
      final principalData = PrincipalUser.fromJson(response.data);
      return principalData;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized - Please login again');
      } else if (e.response?.statusCode == 404) {
        throw Exception('Principal not found');
      } else {
        throw Exception(
          e.response?.data['message'] ?? 'Failed to fetch principal data',
        );
      }
    } catch (e) {
      throw Exception('Error fetching principal data: $e');
    }
  }

  /// Fetches all principals (Admin only)
  Future<List<PrincipalUser>> getAllPrincipals({
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await _dioClient.get(
        '/user/principals',
        queryParameters: {'page': page, 'limit': limit},
      );

      if (response.data is List) {
        return response.data
            .map<PrincipalUser>((json) => PrincipalUser.fromJson(json))
            .toList();
      } else if (response.data['data'] is List) {
        return response.data['data']
            .map<PrincipalUser>((json) => PrincipalUser.fromJson(json))
            .toList();
      } else {
        return [];
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 403) {
        throw Exception('You do not have permission to view all principals');
      } else {
        throw Exception(
          'Failed to fetch principals: ${e.response?.data['message']}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching principals: $e');
    }
  }

  /// Searches principals by name or staff ID
  Future<List<PrincipalUser>> searchPrincipals(String query) async {
    try {
      final response = await _dioClient.get(
        '/user/principals/search',
        queryParameters: {'q': query},
      );

      if (response.data is List) {
        return response.data
            .map<PrincipalUser>((json) => PrincipalUser.fromJson(json))
            .toList();
      }
      return [];
    } catch (e) {
      throw Exception('Error searching principals: $e');
    }
  }

  // ==================== UPDATE OPERATIONS ====================

  /// Updates principal information
  /// Returns updated PrincipalUser object
  Future<PrincipalUser> updatePrincipal(
    String principalId,
    UpdatePrincipalRequest request,
  ) async {
    try {
      final response = await _dioClient.put(
        '/user/principal/$principalId',
        data: request.toJson(),
      );

      final updatedPrincipal = PrincipalUser.fromJson(response.data);

      // Update local storage if this is the current user
      final currentPrincipal = await getCurrentPrincipalId();
      if (currentPrincipal == principalId) {
        // await _cachePrincipalData(updatedPrincipal);
      }

      return updatedPrincipal;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw Exception('Invalid update data: ${e.response?.data['message']}');
      } else if (e.response?.statusCode == 404) {
        throw Exception('Principal not found');
      } else if (e.response?.statusCode == 403) {
        throw Exception('You do not have permission to update this principal');
      } else {
        throw Exception(
          e.response?.data['message'] ?? 'Failed to update principal',
        );
      }
    } catch (e) {
      throw Exception('Error updating principal: $e');
    }
  }

  /// Partially updates principal information (PATCH)
  Future<PrincipalUser> patchPrincipal(
    String principalId,
    Map<String, dynamic> updates,
  ) async {
    try {
      final response = await _dioClient.put(
        '/user/principal/$principalId',
        data: updates,
      );

      final updatedPrincipal = PrincipalUser.fromJson(response.data);

      // Update local storage if this is the current user
      final currentPrincipal = await getCurrentPrincipalId();
      // if (currentPrincipal == principalId) {
      //   await _cachePrincipalData(updatedPrincipal);
      // }

      return updatedPrincipal;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw Exception('Invalid patch data: ${e.response?.data['message']}');
      } else if (e.response?.statusCode == 404) {
        throw Exception('Principal not found');
      } else {
        throw Exception(
          e.response?.data['message'] ?? 'Failed to patch principal',
        );
      }
    } catch (e) {
      throw Exception('Error patching principal: $e');
    }
  }

  // ==================== DELETE OPERATIONS ====================

  /// Deletes a principal user
  /// Returns true if deletion was successful
  Future<bool> deletePrincipal(String principalId) async {
    try {
      await _dioClient.delete('/user/principal/$principalId');

      // Clear cached data if this was the current principal
      final currentPrincipal = await getCurrentPrincipalId();
      if (currentPrincipal == principalId) {
        await _clearCachedPrincipal();
      }

      return true;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw Exception('Principal not found');
      } else if (e.response?.statusCode == 403) {
        throw Exception('You do not have permission to delete principals');
      } else if (e.response?.statusCode == 409) {
        throw Exception('Cannot delete principal with existing dependencies');
      } else {
        throw Exception(
          e.response?.data['message'] ?? 'Failed to delete principal',
        );
      }
    } catch (e) {
      throw Exception('Error deleting principal: $e');
    }
  }

  /// Soft deletes a principal (if supported by backend)
  Future<bool> softDeletePrincipal(String principalId) async {
    try {
      await _dioClient.delete('/user/principal/$principalId/soft-delete');
      return true;
    } on DioException catch (e) {
      throw Exception(
        'Failed to soft delete principal: ${e.response?.data['message']}',
      );
    } catch (e) {
      throw Exception('Error soft deleting principal: $e');
    }
  }

  /// Restores a soft-deleted principal
  Future<bool> restorePrincipal(String principalId) async {
    try {
      await _dioClient.put(
        '/user/principal/$principalId/restore',
        data: {'is_active': true},
      );
      return true;
    } on DioException catch (e) {
      throw Exception(
        'Failed to restore principal: ${e.response?.data['message']}',
      );
    } catch (e) {
      throw Exception('Error restoring principal: $e');
    }
  }

  // ==================== HELPER METHODS ====================

  // /// Caches principal data locally for offline access
  // Future<void> _cachePrincipalData(PrincipalUser principal) async {
  //   await _storage.write('cached_principal', principal.toJson());
  //   await _storage.write('cached_principal_id', principal.id);
  //   await _storage.write(
  //     'cached_principal_time',
  //     DateTime.now().toIso8601String(),
  //   );
  // }

  /// Clears cached principal data
  Future<void> _clearCachedPrincipal() async {
    await _storage.remove('cached_principal');
    await _storage.remove('cached_principal_id');
    await _storage.remove('cached_principal_time');
  }

  /// Gets cached principal data if available and not expired
  Future<PrincipalUser?> getCachedPrincipal({
    Duration maxAge = const Duration(hours: 24),
  }) async {
    final cachedTimeStr = _storage.read('cached_principal_time');
    if (cachedTimeStr == null) return null;

    final cachedTime = DateTime.parse(cachedTimeStr);
    if (DateTime.now().difference(cachedTime) > maxAge) {
      await _clearCachedPrincipal();
      return null;
    }

    final cachedData = _storage.read('cached_principal');
    if (cachedData == null) return null;

    return PrincipalUser.fromJson(cachedData);
  }

  /// Gets current principal ID from storage
  Future<String?> getCurrentPrincipalId() async {
    return _storage.read('cached_principal_id');
  }
}
