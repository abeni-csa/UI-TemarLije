// lib/data/repositories/principal_repository.dart
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ui_temarlije/data/local/pricipal_repository.dart';
import 'package:ui_temarlije/data/models/principal.dart';
import 'package:ui_temarlije/service/network/dio_client.dart';

class PrincipalRepository {
  static final PrincipalRepository _instance = PrincipalRepository._internal();
  static PrincipalRepository get instance => _instance;
  final DioClient _dioClient = Get.find<DioClient>();

  final PricipalRepositoryLocalAppData _localDb =
      PricipalRepositoryLocalAppData.instance;
  final GetStorage _storage = GetStorage();

  PrincipalRepository._internal();

  // Create principal (remote + local)
  Future<PrincipalModel?> createPrincipal(
    CreatePrincipalRequest request,
  ) async {
    try {
      final requestData = {
        'first_name': request.firstName,
        'middle_name': request.middleName,
        'last_name': request.lastName,
        'date_of_birth': request.dateOfBirth.toIso8601String().split(
          'T',
        )[0], // Just YYYY-MM-DD
        'address_info': {
          'region': request.addressInfo.region,
          'zone': request.addressInfo.zone,
          'city': request.addressInfo.city,
          'kebele_no': request.addressInfo.kebeleNo,
        },
      };

      debugPrint('Request JSON being sent: ${jsonEncode(requestData)}');

      final response = await _dioClient.post(
        '/user/principal',
        data: requestData,
      );

      if (response.statusCode == 201) {
        final principal = PrincipalModel.fromJson(response.data);
        await _localDb.insertPrincipal(principal, isSynced: true);
        return principal;
      } else if (response.statusCode == 409) {
        throw Exception('Alradey Exist  principal: ${response.statusCode}');
      } else {
        throw Exception('Failed to create principal: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    }
  }

  // Get current principal (remote first, fallback to local)
  Future<PrincipalModel?> getCurrentPrincipal() async {
    try {
      final response = await _dioClient.get('/users/principal');

      if (response.statusCode == 200) {
        final principal = PrincipalModel.fromJson(response.data);
        await _localDb.insertPrincipal(principal, isSynced: true);
        return principal;
      } else if (response.statusCode == 404) {
        return null;
      } else {
        throw Exception('Failed to fetch principal: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return null;
      }
      // Fallback to local database
      final authUserId = _storage.read('auth_user_id');
      if (authUserId != null) {
        return await _localDb.getPrincipalByAuthUserId(authUserId);
      }
      return null;
    }
  }

  // Get all principals (remote with sync)
  Future<List<PrincipalModel>> getAllPrincipals() async {
    try {
      final response = await _dioClient.get('/users/principal/all');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final principals = data
            .map((json) => PrincipalModel.fromJson(json))
            .toList();

        // Sync to local database
        await _localDb.clearAllPrincipals();
        for (final principal in principals) {
          await _localDb.insertPrincipal(principal, isSynced: true);
        }

        return principals;
      } else {
        throw Exception('Failed to fetch principals');
      }
    } on DioException catch (e) {
      debugPrint(e.toString());
      // Fallback to local database
      return await _localDb.getAllPrincipals();
    }
  }

  // Update principal
  Future<PrincipalModel> updatePrincipal(
    String id,
    UpdatePrincipalRequest request,
  ) async {
    try {
      final response = await _dioClient.put(
        '/users/principal/$id',
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        final principal = PrincipalModel.fromJson(response.data);
        await _localDb.updatePrincipal(principal);
        return principal;
      } else {
        throw Exception('Failed to update principal');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    }
  }

  // Delete principal
  Future<void> deletePrincipal(String id) async {
    try {
      final response = await _dioClient.delete('/users/principal/$id');

      if (response.statusCode == 200 || response.statusCode == 204) {
        await _localDb.deletePrincipal(id);
      } else {
        throw Exception('Failed to delete principal');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    }
  }

  // Search principals
  Future<List<PrincipalModel>> searchPrincipals(String query) async {
    try {
      final response = await _dioClient.get(
        '/users/principal/search',
        queryParameters: {'q': query},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => PrincipalModel.fromJson(json)).toList();
      } else {
        // Fallback to local search
        return await _localDb.searchPrincipals(query);
      }
    } on DioException {
      // Fallback to local search
      return await _localDb.searchPrincipals(query);
    }
  }

  // Sync local changes to remote
  Future<void> syncPendingChanges() async {
    final unsynced = await _localDb.getUnsyncedPrincipals();

    for (final principal in unsynced) {
      try {
        // Check if exists on server
        final checkResponse = await _dioClient.get(
          '/users/principal/${principal.id}',
        );

        if (checkResponse.statusCode == 200) {
          // Update existing
          final updateRequest = UpdatePrincipalRequest(
            firstName: principal.firstName,
            middleName: principal.middleName,
            lastName: principal.lastName,
            dateOfBirth: principal.dateOfBirth,
            department: principal.department,
            position: principal.position,
            addressInfo: principal.addressInfo,
            employmentType: principal.employmentType,
            hireDate: principal.hireDate,
            canManageUsers: principal.canManageUsers,
            canManageFinances: principal.canManageFinances,
            canManageAcademics: principal.canManageAcademics,
          );
          await _dioClient.put(
            '/users/principal/${principal.id}',
            data: updateRequest.toJson(),
          );
        } else {
          // Create new
          final createRequest = CreatePrincipalRequest(
            firstName: principal.firstName,
            middleName: principal.middleName,
            lastName: principal.lastName,

            dateOfBirth: DateTime.parse(principal.dateOfBirth),

            addressInfo: principal.addressInfo,
          );
          await _dioClient.post(
            '/users/principal',
            data: createRequest.toJson(),
          );
        }

        await _localDb.markAsSynced(principal.id.toString());
      } catch (e) {
        debugPrint('Failed to sync principal ${principal.id}: $e');
      }
    }
  }
}
