// lib/data/repositories/principal_registration_repository.dart
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/data/local/pricipal_repository.dart';
import 'package:ui_temarlije/data/models/principal.dart';
import 'package:ui_temarlije/service/network/dio_client.dart';

class PrincipalRegistrationRepository {
  static final PrincipalRegistrationRepository _instance =
      PrincipalRegistrationRepository._internal();
  static PrincipalRegistrationRepository get instance => _instance;
  final DioClient _dioClient = Get.find<DioClient>();

  final PricipalRepositoryLocalAppData _localDb =
      PricipalRepositoryLocalAppData.instance;

  PrincipalRegistrationRepository._internal();

  Future<PrincipalModel> registerPrincipal(
    PrincipalRegistrationRequest request,
  ) async {
    try {
      final response = await _dioClient.post(
        '/users/principal',
        data: request.toJson(),
      );

      if (response.statusCode == 201) {
        final principal = PrincipalModel.fromJson(response.data);
        await _localDb.insertPrincipal(principal, isSynced: true);
        return principal;
      } else {
        throw Exception('Registration failed: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
          'Registration failed: ${e.response?.data['message'] ?? e.message}',
        );
      }
      throw Exception('Network error: ${e.message}');
    }
  }
}
