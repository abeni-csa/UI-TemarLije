import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ui_temarlije/data/models/membeship.dart';
import 'package:ui_temarlije/service/teachers_enrollment_service.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';

class EnrollmentsController extends GetxController {
  final TeachersEnrollmentService _service =
      Get.find<TeachersEnrollmentService>();

  // Use String for schoolId
  final RxString schoolId = ''.obs;
  final GetStorage _storage = GetStorage();

  // Observable state - use String for IDs instead of Uuid
  final RxList<Membership> pendingRequests = <Membership>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxSet<Uuid> selectedIds = <Uuid>{}.obs; // Changed to String
  final RxString selectedAcademicYearId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadSchoolId();
  }

  Future<void> loadSchoolId() async {
    // Try to get from storage first
    final storedSchoolId = _storage.read('CURRENT_SCHOOL_ID');
    print('Stored School ID: $storedSchoolId');

    if (storedSchoolId != null && storedSchoolId.toString().isNotEmpty) {
      schoolId.value = storedSchoolId.toString();
      print('School ID set from storage: ${schoolId.value}');
      fetchPendingRequests();
    } else {
      // Try Get.arguments
      try {
        final args = Get.arguments;
        if (args != null && args is String && args.isNotEmpty) {
          schoolId.value = args;
          _storage.write('CURRENT_SCHOOL_ID', args);
          fetchPendingRequests();
          return;
        }
      } catch (e) {
        print('No arguments found');
      }

      // Try route parameters
      try {
        final paramId = Get.parameters['schoolId'];
        if (paramId != null && paramId.isNotEmpty) {
          schoolId.value = paramId;
          _storage.write('CURRENT_SCHOOL_ID', paramId);
          fetchPendingRequests();
          return;
        }
      } catch (e) {
        print('No route parameters found');
      }

      // If all else fails, use the default school ID from the API response
      // The school ID from the API is: 015cb15a-86d8-7462-bef0-a9ad9b735c27
      schoolId.value = "015cb15a-86d8-7462-bef0-a9ad9b735c27";
      print('Using default school ID: ${schoolId.value}');
      fetchPendingRequests();
    }
  }

  // Fetch pending requests
  Future<void> fetchPendingRequests() async {
    print("Calling fetchPendingRequests()");
    print("School ID: ${schoolId.value}");

    if (schoolId.isEmpty) {
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
      print(schoolId.value);
      final requests = await _service.getPendingRequests(schoolId.value);
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

      await _service.batchAcceptRequests(schoolId.value, userIds);

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

      await _service.batchRejectRequests(schoolId.value, userIds);

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
        schoolId.value,
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
      await _service.rejectRequest(schoolId.value, request.id);
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
