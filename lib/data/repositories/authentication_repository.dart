import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ui_temarlije/service/network/dio_client.dart';
import 'package:ui_temarlije/data/models/auth_models.dart';
import 'package:ui_temarlije/utils/helpers/network_manager.dart';

/// Repository handling all authentication-related API operations
/// Manages token storage, network requests, and error handling
class AuthRepository extends GetxService {
  static AuthRepository get instance => Get.find();

  final DioClient _dioClient = Get.find<DioClient>();
  // final NetworkManager _networkManager = Get.find<NetworkManager>();
  final GetStorage _storage = GetStorage();

  /// Authenticates user with username/email and password
  /// Returns AuthResponse containing tokens and 2FA status
  /// Throws exception with user-friendly message on failure
  Future<AuthResponse> login(String email, String password) async {
    // // Check internet connectivity before making request
    // if (!await _networkManager.checkConnectivity()) {
    //   throw Exception('No internet connection');
    // }

    try {
      final response = await _dioClient.post(
        '/auth/login',
        data: LoginRequest(email: email, password: password).toJson(),
      );

      final authResponse = AuthResponse.fromJson(response.data);

      // Store authentication tokens securely
      await _storage.write('access_token', authResponse.accessToken);
      await _storage.write('refresh_token', authResponse.refreshToken);

      return authResponse;
    } on DioException catch (e) {
      // Map HTTP errors to user-friendly messages
      if (e.response?.statusCode == 401) {
        throw Exception('Invalid username or password');
      } else if (e.response?.statusCode == 403) {
        throw Exception('Account locked. Please contact support.');
      } else {
        throw Exception(e.response?.data['message'] ?? 'Login failed');
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Registers a new user account
  /// Returns AuthResponse with tokens or 2FA setup requirements
  Future<AuthResponse> signup(String email, String password) async {
    // Verify internet connectivity
    // if (!await _networkManager.checkConnectivity()) {
    //   throw Exception('No internet connection');
    // }

    try {
      final response = await _dioClient.post(
        '/auth/signup',
        data: SignupRequest(email: email, password: password).toJson(),
      );

      final authResponse = AuthResponse.fromJson(response.data);

      // Auto-login after signup if 2FA not required
      if (!authResponse.requiresTwoFactor) {
        await _storage.write('access_token', authResponse.accessToken);
        await _storage.write('refresh_token', authResponse.refreshToken);

        // Store recovery codes if provided
        if (authResponse.recoveryCodes != null) {
          await _storage.write('recovery_codes', authResponse.recoveryCodes);
        }
      }

      return authResponse;
    } on DioException catch (e) {
      // Handle specific signup errors
      if (e.response?.statusCode == 409) {
        throw Exception('Username already exists');
      } else if (e.response?.statusCode == 400) {
        throw Exception(e.response?.data['message'] ?? 'Invalid input');
      } else {
        throw Exception('Signup failed');
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Verifies two-factor authentication code
  /// Returns AuthResponse with final tokens after successful verification
  Future<AuthResponse> verifyTwoFactor(String code, {String? userId}) async {
    // if (!await _networkManager.checkConnectivity()) {
    //   throw Exception('No internet connection');
    // }

    try {
      final response = await _dioClient.post(
        '/auth/verify-2fa',
        data: VerifyTwoFactorRequest(code: code, userId: userId).toJson(),
      );

      final authResponse = AuthResponse.fromJson(response.data);

      // Update stored tokens after 2FA verification
      await _storage.write('access_token', authResponse.accessToken);
      await _storage.write('refresh_token', authResponse.refreshToken);

      return authResponse;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Invalid verification code');
      } else {
        throw Exception('Verification failed');
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Generates new 2FA configuration for user
  /// Returns configuration containing OTP secret and URL
  Future<TwoFactorConfig> generateTwoFactorConfig() async {
    // if (!await _networkManager.checkConnectivity()) {
    //   throw Exception('No internet connection');
    // }

    try {
      final response = await _dioClient.get('/auth/2fa/generate');
      return TwoFactorConfig.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to generate 2FA config');
    }
  }

  /// Checks if a user has 2FA enabled for their account
  /// Returns true if 2FA is enabled, false otherwise
  Future<bool> checkTwoFactorStatus(String username) async {
    try {
      final response = await _dioClient.get(
        '/auth/2fa/status',
        queryParameters: {'username': username},
      );
      return response.data['enabled'] ?? false;
    } catch (e) {
      return false;
    }
  }

  /// Logs out user and clears all stored authentication data
  Future<void> logout() async {
    try {
      // Notify server about logout (optional)
      await _dioClient.post('/auth/logout');
    } finally {
      // Clear local storage regardless of server response
      await _clearStorage();
    }
  }

  /// Removes all authentication-related data from local storage
  Future<void> _clearStorage() async {
    await _storage.remove('access_token');
    await _storage.remove('refresh_token');
    await _storage.remove('recovery_codes');
  }

  /// Checks if user is currently logged in
  /// Returns true if access token exists and is not empty
  bool isLoggedIn() {
    final token = _storage.read('access_token');
    return token != null && token.isNotEmpty;
  }

  /// Retrieves current access token from storage
  /// Returns token string or null if not found
  String? getAccessToken() {
    return _storage.read('access_token');
  }
}
