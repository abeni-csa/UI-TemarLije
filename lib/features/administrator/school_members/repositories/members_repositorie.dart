import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ui_temarlije/data/models/membeship.dart';
import 'package:ui_temarlije/service/network/dio_client.dart';
import 'package:ui_temarlije/data/models/auth_models.dart';

class MembersRepositorie extends GetxService {
  static MembersRepositorie get instance => Get.find();

  final DioClient _dioClient = Get.find<DioClient>();

  final GetStorage _storage = GetStorage();

  Future<void> createUserProfile(
    String jwtToken,
    String endpoint,
    Map<String, dynamic> userData,
  ) async {
    try {
      final dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $jwtToken';
      dio.options.headers['Content-Type'] = 'application/json';

      await dio.post('${DioClient.baseUrl}$endpoint', data: userData);
    } catch (e) {
      throw _handleError(e);
    }
  }

  String _handleError(dynamic error) {
    if (error is DioException) {
      if (error.response?.data != null) {
        return error.response?.data['message'] ?? 'An error occurred';
      }
      return error.message ?? 'Network error occurred';
    }
    return error.toString();
  }

  // Future<List<Membership>> getPendingRequest() async {
  //   try {
  //     final response = await _dioClient.post(
  //       '/org/school/015cb15a-86d8-7052-8376-15ec5d6bc8d3/members/pending-requests',
  //     );

  //     final membership = Membership.fromJson(response.data);

  //     return membership;
  //   } on DioException catch (e) {
  //     if (e.response?.statusCode == 401) {
  //       throw Exception('Invalid username or password');
  //     } else if (e.response?.statusCode == 403) {
  //       throw Exception('Account locked. Please contact support.');
  //     } else {
  //       throw Exception(e.response?.data['message'] ?? 'Login failed');
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<Membership> signup(String email, String password) async {
    try {
      final response = await _dioClient.post(
        '/auth/signup',
        data: SignupRequest(email: email, password: password).toJson(),
      );

      final membership = Membership.fromJson(response.data);

      return membership;
    } on DioException catch (e) {
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

  Future<Membership> verifyTwoFactor(String code, {String? userId}) async {
    try {
      final response = await _dioClient.post(
        '/auth/verify-2fa',
        data: VerifyTwoFactorRequest(code: code, userId: userId).toJson(),
      );

      final membership = Membership.fromJson(response.data);

      return membership;
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

  Future<TwoFactorConfig> generateTwoFactorConfig() async {
    try {
      final response = await _dioClient.get('/auth/2fa/generate');
      return TwoFactorConfig.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to generate 2FA config');
    }
  }

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

  Future<void> logout() async {
    try {
      await _dioClient.post('/auth/logout');
    } catch (e) {
      throw _handleError(e);
    } finally {
      await _clearStorage();
    }
  }

  Future<void> _clearStorage() async {
    await _storage.remove('access_token');
    await _storage.remove('refresh_token');
    await _storage.remove('recovery_codes');
  }

  bool isLoggedIn() {
    final token = _storage.read('access_token');
    return token != null && token.isNotEmpty;
  }

  bool get isAuthteicated => true;

  String? getAccessToken() {
    return _storage.read('access_token');
  }
}
