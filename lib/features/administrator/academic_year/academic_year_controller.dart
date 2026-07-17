import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ui_temarlije/data/models/academic_year.dart';
import 'package:ui_temarlije/data/models/school_organzation.dart';
import 'package:ui_temarlije/features/administrator/academic_year/screens/widgets/academic_year_form.dart';
import 'package:ui_temarlije/features/administrator/school_org/global_school_controller.dart';
import 'package:ui_temarlije/service/academic_year_service.dart';
import 'package:ui_temarlije/service/school_orginzation_service.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';

class AcademicYearController extends GetxController {
  static AcademicYearController get instance =>
      Get.find<AcademicYearController>();

  final AcademicYearService _academicYearService =
      Get.find<AcademicYearService>();
  final SchoolOrganizationService _schoolService = Get.put(
    SchoolOrganizationService(),
  );
  final GlobalSchoolController _schoolController =
      Get.find<GlobalSchoolController>();

  // State
  final RxList<AcademicYear> academicYears = <AcademicYear>[].obs;
  final Rx<AcademicYear?> currentAcademicYear = Rx<AcademicYear?>(null);
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  // School selection state
  final RxList<SchoolOrganzationModel> schools = <SchoolOrganzationModel>[].obs;
  final Rx<SchoolOrganzationModel?> selectedSchool =
      Rx<SchoolOrganzationModel?>(null);
  final RxBool isLoadingSchools = false.obs;

  // Form controllers
  final formKey = GlobalKey<FormState>();
  final yearRangeController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final isCurrentController = false.obs;

  // Form data
  AcademicYear? editingAcademicYear;

  // Getter for selected school ID
  String? get schoolId => _schoolController.schoolId;
  @override
  void onInit() {
    super.onInit();
    // Load academic years when school is selected
    ever(_schoolController.selectedSchool, (_) {
      loadAcademicYears();
    });

    loadAcademicYears();
  }

  @override
  void onClose() {
    yearRangeController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    super.onClose();
  }

  // Load schools for the current user
  Future<void> loadSchools() async {
    isLoadingSchools.value = true;
    error.value = '';

    try {
      final schoolList = await _schoolService.getMySchools();
      schools.assignAll(schoolList);

      if (schoolList.isNotEmpty) {
        // If only one school, select it automatically
        if (schoolList.length == 1) {
          selectedSchool.value = schoolList.first;
          await loadAcademicYears();
        } else {
          // Multiple schools - user must select one
          selectedSchool.value = null;
          academicYears.clear();
          currentAcademicYear.value = null;
        }
      } else {
        error.value = 'No schools found. Please join or create a school first.';
      }
    } catch (e) {
      error.value = 'Failed to load schools: ${e.toString()}';
      _showError(error.value);
    } finally {
      isLoadingSchools.value = false;
    }
  }

  // Load academic years from API
  Future<void> loadAcademicYears() async {
    if (schoolId == null) {
      academicYears.clear();
      currentAcademicYear.value = null;
      return;
    }

    isLoading.value = true;
    error.value = '';

    try {
      final response = await _academicYearService.getAcademicYears(schoolId!);
      academicYears.assignAll(response.academicYears);
      currentAcademicYear.value = response.currentAcademicYear;
    } catch (e) {
      error.value = e.toString();
      _showError(error.value);
    } finally {
      isLoading.value = false;
    }
  }

  // Refresh academic years
  Future<void> refreshAcademicYears() async {
    await loadAcademicYears();
  }

  // Select a school from dropdown
  void selectSchool(SchoolOrganzationModel school) {
    selectedSchool.value = school;
    loadAcademicYears();
  }

  // Create academic year
  Future<void> createAcademicYear(CreateAcademicYearRequest request) async {
    if (schoolId == null) {
      _showError('No school selected');
      return;
    }

    isLoading.value = true;
    error.value = '';

    try {
      await _academicYearService.createAcademicYear(schoolId!, request);
      await loadAcademicYears();
      _showSuccess('Academic year created successfully!');
    } catch (e) {
      error.value = e.toString();
      _showError(error.value);
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  // Update academic year
  Future<void> updateAcademicYear(
    String academicYearId,
    UpdateAcademicYearRequest request,
  ) async {
    if (schoolId == null) {
      _showError('No school selected');
      return;
    }

    isLoading.value = true;
    error.value = '';

    try {
      await _academicYearService.updateAcademicYear(
        schoolId!,
        academicYearId,
        request,
      );
      await loadAcademicYears();
      _showSuccess('Academic year updated successfully!');
    } catch (e) {
      error.value = e.toString();
      _showError(error.value);
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  // Delete academic year
  Future<void> deleteAcademicYear(String academicYearId) async {
    if (schoolId == null) {
      _showError('No school selected');
      return;
    }

    isLoading.value = true;
    error.value = '';

    try {
      await _academicYearService.deleteAcademicYear(schoolId!, academicYearId);
      await loadAcademicYears();
      _showSuccess('Academic year deleted successfully!');
    } catch (e) {
      error.value = e.toString();
      _showError(error.value);
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  // Set form for editing
  void setEditingAcademicYear(AcademicYear? academicYear) {
    editingAcademicYear = academicYear;
    if (academicYear != null) {
      yearRangeController.text = academicYear.yearRange;
      startDateController.text = _formatDate(academicYear.startDate);
      endDateController.text = _formatDate(academicYear.endDate);
      isCurrentController.value = academicYear.isCurrent;
    } else {
      _clearForm();
    }
  }

  void _clearForm() {
    yearRangeController.clear();
    startDateController.clear();
    endDateController.clear();
    isCurrentController.value = false;
    editingAcademicYear = null;
  }

  // Validate and submit form
  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  CreateAcademicYearRequest getCreateRequest() {
    return CreateAcademicYearRequest(
      yearRange: yearRangeController.text,
      startDate: startDateController.text,
      endDate: endDateController.text,
      isCurrent: isCurrentController.value,
    );
  }

  UpdateAcademicYearRequest getUpdateRequest() {
    return UpdateAcademicYearRequest(
      yearRange: yearRangeController.text.isNotEmpty
          ? yearRangeController.text
          : null,
      startDate: startDateController.text.isNotEmpty
          ? startDateController.text
          : null,
      endDate: endDateController.text.isNotEmpty
          ? endDateController.text
          : null,
      isCurrent: isCurrentController.value,
    );
  }

  // Helper methods
  String _formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  void _showSuccess(String message) {
    GetSnackBar(
      message: message,
      backgroundColor: TemarLijeColors.success,
      duration: const Duration(seconds: 2),
      snackPosition: SnackPosition.BOTTOM,
    ).show();
  }

  void _showError(String message) {
    GetSnackBar(
      message: message,
      backgroundColor: TemarLijeColors.error,
      duration: const Duration(seconds: 3),
      snackPosition: SnackPosition.BOTTOM,
    ).show();
  }

  // Show form dialog
  void showCreateForm() {
    if (schoolId == null) {
      _showError('Please select a school first');
      return;
    }

    setEditingAcademicYear(null);
    Get.dialog(
      AcademicYearFormDialog(
        academicYear: null,
        onSubmit: (request) async {
          await createAcademicYear(request);
        },
      ),
      barrierDismissible: false,
    );
  }

  void showEditForm(AcademicYear academicYear) {
    setEditingAcademicYear(academicYear);
    Get.dialog(
      AcademicYearFormDialog(
        academicYear: academicYear,
        onSubmitUpdate: (id, request) async {
          await updateAcademicYear(id, request);
        },
      ),
      barrierDismissible: false,
    );
  }

  // Show delete confirmation
  Future<bool?> showDeleteConfirmation(AcademicYear academicYear) async {
    return await Get.dialog<bool>(
      AlertDialog(
        backgroundColor: TemarLijeColors.cardBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text('Delete Academic Year'),
        content: Text(
          'Are you sure you want to delete "${academicYear.yearRange}"?\n\nThis action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Get.back(result: true),
            style: ElevatedButton.styleFrom(
              backgroundColor: TemarLijeColors.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  // Handle delete with confirmation
  Future<void> handleDelete(AcademicYear academicYear) async {
    final confirmed = await showDeleteConfirmation(academicYear);
    if (confirmed == true) {
      try {
        await deleteAcademicYear(academicYear.id);
      } catch (e) {
        // Error already handled in deleteAcademicYear
      }
    }
  }
}
