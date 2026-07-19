import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/features/administrator/school_org/global_school_controller.dart';
import 'package:uuid/uuid.dart';
import 'package:ui_temarlije/data/models/membeship.dart';
import 'package:ui_temarlije/service/teachers_enrollment_service.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';

class EnrollmentsController extends GetxController {
  final TeachersEnrollmentService _service =
      Get.find<TeachersEnrollmentService>();
  final GlobalSchoolController _schoolController =
      Get.find<GlobalSchoolController>();
  // Use String for schoolId
  UuidValue? get schoolId => _schoolController.schoolId;

  // Observable state - use String for IDs instead of Uuid
  final RxList<Membership> pendingRequests = <Membership>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxSet<Uuid> selectedIds = <Uuid>{}.obs; // Changed to String
  final RxString selectedAcademicYearId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    ever(_schoolController.selectedSchool, (_) {
      loadSchoolId();
    });
    loadSchoolId();
  }

  Future<void> loadSchoolId() async {
    fetchPendingRequests();
  }

  // Fetch pending requests
  Future<void> fetchPendingRequests() async {
    print("Calling fetchPendingRequests()");
    print("School ID: ${schoolId}");

    if (schoolId == null) {
      errorMessage.value = 'School ID is empty';
      print(errorMessage.value);
      Get.snackbar(
        'Error',
        'School ID is empty. Please log in again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;
      errorMessage.value = '';

      final requests = await _service.getPendingRequests(schoolId!);
      pendingRequests.assignAll(requests);
      print('Fetched ${requests.length} pending requests');
    } catch (e) {
      errorMessage.value = e.toString();
      print('Error: $e');
      Get.snackbar(
        'Error',
        'Failed to load pending requests: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Select/Deselect all
  void toggleSelectAll() {
    if (selectedIds.length == pendingRequests.length) {
      selectedIds.clear();
    } else {
      // selectedIds.addAll(pendingRequests.map((r) => r.id));
    }
  }

  // Toggle selection for a single item
  void toggleSelection(String id) {
    if (selectedIds.contains(id)) {
      selectedIds.remove(id);
    } else {
      // selectedIds.add(id);
    }
  }

  // Check if all items are selected
  bool get isAllSelected =>
      pendingRequests.isNotEmpty &&
      selectedIds.length == pendingRequests.length;

  // Get selected count
  int get selectedCount => selectedIds.length;

  // Accept selected requests
  Future<void> acceptSelected() async {
    if (selectedIds.isEmpty) {
      Get.snackbar(
        'Info',
        'Please select at least one request',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Show confirmation dialog
    final confirm = await Get.dialog<bool>(
      AlertDialog(
        backgroundColor: TemarLijeColors.lightBackground,
        title: const Text('Confirm Acceptance'),
        content: Text(
          'Are you sure you want to accept ${selectedIds.length} selected request(s)?',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            style: TextButton.styleFrom(foregroundColor: Colors.green),
            child: const Text('Accept'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      isLoading.value = true;

      final userIds = selectedIds.toList();

      await _service.batchAcceptRequests(schoolId!, userIds);

      // Remove accepted requests from the list
      pendingRequests.removeWhere((r) => selectedIds.contains(r.id));
      selectedIds.clear();

      Get.snackbar(
        'Success',
        'Requests accepted successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to accept requests: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Reject selected requests
  Future<void> rejectSelected() async {
    if (selectedIds.isEmpty) {
      Get.snackbar(
        'Info',
        'Please select at least one request',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Show confirmation dialog
    final confirm = await Get.dialog<bool>(
      AlertDialog(
        backgroundColor: TemarLijeColors.lightBackground,
        title: const Text('Confirm Rejection'),
        content: Text(
          'Are you sure you want to reject ${selectedIds.length} selected request(s)?',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Reject'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      isLoading.value = true;

      final userIds = selectedIds.toList();

      await _service.batchRejectRequests(schoolId!, userIds);

      // Remove rejected requests from the list
      pendingRequests.removeWhere((r) => selectedIds.contains(r.id));
      selectedIds.clear();

      Get.snackbar(
        'Success',
        'Requests rejected successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to reject requests: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Accept single request
  Future<void> acceptSingleRequest(Membership request) async {
    // Show confirmation
    final confirm = await Get.dialog<bool>(
      AlertDialog(
        backgroundColor: TemarLijeColors.lightBackground,
        title: const Text('Confirm Acceptance'),
        content: const Text('Are you sure you want to accept this request?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            style: TextButton.styleFrom(foregroundColor: Colors.green),
            child: const Text('Accept'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      isLoading.value = true;
      await _service.acceptRequest(
        schoolId!,
        request.userId,
        selectedAcademicYearId.value,
      );
      pendingRequests.remove(request);

      Get.snackbar(
        'Success',
        'Request accepted successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to accept request: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Reject single request
  Future<void> rejectSingleRequest(Membership request) async {
    final confirm = await Get.dialog<bool>(
      AlertDialog(
        backgroundColor: TemarLijeColors.lightBackground,
        title: const Text('Confirm Rejection'),
        content: const Text('Are you sure you want to reject this request?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Reject'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      isLoading.value = true;
      await _service.rejectRequest(schoolId!, request.id);
      pendingRequests.remove(request);

      Get.snackbar(
        'Success',
        'Request rejected successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to reject request: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
