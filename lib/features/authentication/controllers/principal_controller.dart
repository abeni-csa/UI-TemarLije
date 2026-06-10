// lib/features/principal/controllers/principal_controller.dart
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ui_temarlije/data/models/fileds.dart';
import 'package:ui_temarlije/data/models/principal.dart';
import 'package:ui_temarlije/data/repositories/principal_repository.dart';
import 'package:ui_temarlije/routes/routes.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';

class PrincipalController extends GetxController {
  static PrincipalController get instance => Get.find();

  final PrincipalRepository _repository = PrincipalRepository.instance;
  final formKey = GlobalKey<FormState>();

  // Observable state
  final principals = <PrincipalModel>[].obs;
  final currentPrincipal = Rx<PrincipalModel?>(null);
  final isLoading = false.obs;
  final isSyncing = false.obs;
  // Text Controllers
  final firstName = TextEditingController();
  final middleName = TextEditingController();
  final lastName = TextEditingController();
  final dateOfBirth = TextEditingController();
  final phoneNumber = TextEditingController();

  // Address Controllers
  final region = TextEditingController();
  final zone = TextEditingController();
  final city = TextEditingController();
  final kebeleNo = TextEditingController();

  // Reactive variables
  var selectedGender = Rx<String?>(null);
  var agreeToTerms = false.obs;

  final kebele = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchCurrentPrincipal();
  }

  @override
  void onClose() {
    firstName.dispose();
    middleName.dispose();
    lastName.dispose();
    dateOfBirth.dispose();
    phoneNumber.dispose();
    region.dispose();
    zone.dispose();
    city.dispose();
    kebeleNo.dispose();
    super.onClose();
  }

  // Date Picker
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      dateOfBirth.text = picked.toIso8601String().split('T').first;
    }
  }

  // Create principal
  Future<void> createPrincipal() async {
    try {
      final addressInfo = AddressInfo(
        region: region.text,
        zone: zone.text,
        city: city.text,
        kebeleNo: kebeleNo.text,
      );
      final request = CreatePrincipalRequest(
        firstName: firstName.text,
        middleName: middleName.text,
        lastName: lastName.text,
        dateOfBirth: DateTime.parse(dateOfBirth.text),
        addressInfo: addressInfo,
      );

      isLoading.value = true;
      final newPrincipal = await _repository.createPrincipal(request);
      principals.insert(0, newPrincipal!);
      Get.snackbar(
        'Success',
        'Principal profile created successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: TemarLijeColors.success,
        colorText: Colors.white,
      );
      // Navigate to dashboard on success
      Get.offNamed(TemarLijeRoutes.dashbord);
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar(
        'Error',
        'Failed to create principal',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: TemarLijeColors.error,
        colorText: Colors.white,
      );
      return;
    } finally {
      isLoading.value = false;
    }
  }

  // Fetch current principal (logged-in user)
  Future<void> fetchCurrentPrincipal() async {
    try {
      final principal = await _repository.getCurrentPrincipal();
      currentPrincipal.value = principal;
    } catch (e) {
      debugPrint('Failed to fetch current principal: $e');
    }
  }

  // Update principal
  Future<void> updatePrincipal(
    String id,
    UpdatePrincipalRequest request,
  ) async {
    try {
      isLoading.value = true;
      final updated = await _repository.updatePrincipal(id, request);

      // Update in list
      final index = principals.indexWhere((p) => p.id.toString() == id);
      if (index != -1) {
        principals[index] = updated;
      }

      // Update current if needed
      if (currentPrincipal.value?.id.toString() == id) {
        currentPrincipal.value = updated;
      }

      Get.snackbar(
        'Success',
        'Principal updated successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update principal: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Delete principal
  Future<void> deletePrincipal(String id) async {
    try {
      final confirmed = await Get.dialog<bool>(
        AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text(
            'Are you sure you want to delete this principal? This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(result: false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Get.back(result: true),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Delete'),
            ),
          ],
        ),
      );

      if (confirmed == true) {
        isLoading.value = true;
        await _repository.deletePrincipal(id);
        principals.removeWhere((p) => p.id.toString() == id);

        if (currentPrincipal.value?.id.toString() == id) {
          currentPrincipal.value = null;
        }

        Get.snackbar(
          'Success',
          'Principal deleted successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to delete principal: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Sync with remote server
  Future<void> syncWithServer() async {
    try {
      isSyncing.value = true;
      await _repository.syncPendingChanges();

      Get.snackbar(
        'Sync Complete',
        'All data has been synchronized with the server',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Sync Failed',
        'Failed to sync with server: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
    } finally {
      isSyncing.value = false;
    }
  }
}
