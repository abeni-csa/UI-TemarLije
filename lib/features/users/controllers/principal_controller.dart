import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ui_temarlije/data/models/principal_user.dart';
import 'package:ui_temarlije/data/repositories/user_repository.dart';

class PrincipalController extends GetxController {
  final UsersRepository _repository = UsersRepository.instance;
  static PrincipalController get instance => Get.find();

  var my = UsersRepository.instance.getPrincipal.obs;
  var principals = <PrincipalUser>[].obs;
  var currentPrincipal = Rx<PrincipalUser?>(null);
  Rx<PrincipalUser> currentPrincipall = PrincipalUser.def().obs;
  var isLoading = false.obs;

  var isDeleting = false.obs;
  var searchQuery = ''.obs;

  // Form controllers
  final searchController = TextEditingController();

  // Pagination
  var currentPage = 1.obs;
  var hasMoreData = true.obs;
  final int itemsPerPage = 20;

  @override
  void onInit() {
    super.onInit();
    fetchCurrentPrincipal();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  /// Update search query
  void updateSearchQuery(String value) {
    searchQuery.value = value;
    if (value.isEmpty) {
      fetchAllPrincipals();
    }
  }

  // CREATE
  Future<void> createNewPrincipal(CreatePrincipalRequest request) async {
    try {
      isLoading.value = true;
      final newPrincipal = await _repository.createPrincipal(request);
      principals.add(newPrincipal);
      Get.snackbar('Success', 'Principal created successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // READ (Single)
  Future<void> fetchCurrentPrincipal() async {
    try {
      isLoading.value = true;
      currentPrincipal.value = await _repository.getPrincipal();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // READ (All)
  Future<void> fetchAllPrincipals() async {
    try {
      isLoading.value = true;
      principals.value = await _repository.getAllPrincipals();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Search principals
  Future<void> searchPrincipals() async {
    if (searchQuery.value.isEmpty) {
      await fetchAllPrincipals();
      return;
    }

    try {
      isLoading.value = true;
      final results = await _repository.searchPrincipals(searchQuery.value);
      principals.value = results;
    } catch (e) {
      Get.snackbar('Error', 'Search failed: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  // UPDATE
  Future<void> updatePrincipalInfo(
    String id,
    UpdatePrincipalRequest request,
  ) async {
    try {
      isLoading.value = true;
      final updated = await _repository.updatePrincipal(id, request);

      // Update in list
      final index = principals.indexWhere((p) => p.id == id);
      if (index != -1) {
        principals[index] = updated;
      }

      // Update current if needed
      if (currentPrincipal.value?.id == id) {
        currentPrincipal.value = updated;
      }

      Get.snackbar('Success', 'Principal updated successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // DELETE
  Future<void> deletePrincipal(String id) async {
    try {
      isLoading.value = true;
      final confirmed = await Get.dialog<bool>(
        AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this principal?'),
          actions: [
            TextButton(
              onPressed: () => Get.back(result: false),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Get.back(result: true),
              child: Text('Delete'),
            ),
          ],
        ),
      );

      if (confirmed == true) {
        await _repository.deletePrincipal(id);
        principals.removeWhere((p) => p.id == id);
        Get.snackbar('Success', 'Principal deleted successfully');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
