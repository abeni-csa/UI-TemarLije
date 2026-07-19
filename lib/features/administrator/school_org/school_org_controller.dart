import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ui_temarlije/data/models/fileds.dart';
import 'package:ui_temarlije/data/models/school_organzation.dart';
import 'package:ui_temarlije/data/repositories/school_organzation_repository.dart';
import 'package:ui_temarlije/features/administrator/school_org/model/school.dart';
import 'package:ui_temarlije/features/administrator/school_org/screens/widgets/school_org_form.dart';
import 'package:ui_temarlije/service/school_orginzation_service.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';

class SchoolOrgController extends GetxController {
  static SchoolOrgController get instance => Get.find<SchoolOrgController>();

  // Services
  final SchoolOrganizationService _schoolService =
      Get.find<SchoolOrganizationService>();
  // final SchoolOrganzationRepository _repository = SchoolOrganzationRepository();
  final GetStorage _storage = GetStorage();

  // State
  final RxList<SchoolOrganzationModel> schools = <SchoolOrganzationModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  // Form controllers
  final formKey = GlobalKey<FormState>();
  late final TextEditingController nameController;
  late final TextEditingController establishedYearController;
  late final TextEditingController regionController;
  late final TextEditingController zoneController;
  late final TextEditingController cityController;
  late final TextEditingController kebeleController;
  late final TextEditingController phoneController;
  late final TextEditingController emailController;
  late final TextEditingController websiteController;
  final Rx<SchoolType> selectedSchoolType = SchoolType.Public.obs;

  // Form data
  SchoolOrganzationModel? editingSchool;

  @override
  void onInit() {
    super.onInit();
    _initializeControllers();
    loadSchools();
  }

  void _initializeControllers() {
    nameController = TextEditingController();
    establishedYearController = TextEditingController();
    regionController = TextEditingController();
    zoneController = TextEditingController();
    cityController = TextEditingController();
    kebeleController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
    websiteController = TextEditingController();
  }

  @override
  void onClose() {
    nameController.dispose();
    establishedYearController.dispose();
    regionController.dispose();
    zoneController.dispose();
    cityController.dispose();
    kebeleController.dispose();
    phoneController.dispose();
    emailController.dispose();
    websiteController.dispose();
    super.onClose();
  }

  // Load schools from local database
  Future<void> loadSchools() async {
    isLoading.value = true;
    error.value = '';
    try {
      final loadedSchools = await _schoolService.getMySchools();
      schools.assignAll(loadedSchools);
    } catch (e) {
      error.value = 'Failed to load schools: $e';
    } finally {
      isLoading.value = false;
    }
  }

  // Refresh schools
  Future<void> refreshSchools() async {
    await loadSchools();
  }

  // Create school
  Future<void> createSchool(CreateSchoolOrganzationRequest request) async {
    isLoading.value = true;
    error.value = '';
    try {
      final createdSchool = await _schoolService.createSchoolOrg(request);
      // await _repository.saveSchoolOrgFromRemote(createdSchool);
      await _storage.write('CURRENT_SCHOOL_ID', createdSchool.id);

      await loadSchools();
      return;
    } catch (e) {
      error.value = 'Failed to create school: $e';
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  // Update school
  Future<void> updateSchool(
    String id,
    UpdateSchoolOrganzationRequest request,
  ) async {
    isLoading.value = true;
    error.value = '';
    try {
      await _schoolService.updateSchoolOrg(id, request);
      await loadSchools();
      return;
    } catch (e) {
      error.value = 'Failed to update school: $e';
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  // Delete school
  Future<void> deleteSchool(SchoolOrganzationModel school) async {
    isLoading.value = true;
    error.value = '';
    try {
      await _schoolService.deleteSchoolOrg(school.id.toString());
      // await _repository.deleteSchoolOrg(school.id.toString());
      await loadSchools();
      return;
    } catch (e) {
      error.value = 'Failed to delete school: $e';
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  // Set form for editing
  void setEditingSchool(SchoolOrganzationModel? school) {
    editingSchool = school;
    if (school != null) {
      nameController.text = school.name;
      establishedYearController.text = school.establishedYear.toString();
      regionController.text = school.address.region;
      zoneController.text = school.address.zone;
      cityController.text = school.address.city;
      kebeleController.text = school.address.kebeleNo;
      phoneController.text = school.contact.phone;
      emailController.text = school.contact.email;
      websiteController.text = school.contact.website;
      selectedSchoolType.value = school.schoolType;
    } else {
      _clearForm();
    }
  }

  void _clearForm() {
    nameController.clear();
    establishedYearController.clear();
    regionController.clear();
    zoneController.clear();
    cityController.clear();
    kebeleController.clear();
    phoneController.clear();
    emailController.clear();
    websiteController.clear();
    selectedSchoolType.value = SchoolType.Public;
    editingSchool = null;
  }

  // Validate and submit form
  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  CreateSchoolOrganzationRequest getCreateRequest() {
    final address = AddressInfo(
      region: regionController.text,
      zone: zoneController.text,
      city: cityController.text,
      kebeleNo: kebeleController.text,
    );
    final location = Location(
      region: regionController.text,
      zone: zoneController.text,
      city: cityController.text,
      kebeleNo: kebeleController.text,
    );
    final contact = Contact(
      phone: phoneController.text,
      email: emailController.text,
      website: websiteController.text,
    );

    return CreateSchoolOrganzationRequest(
      schoolName: nameController.text,
      address: address,
      location: location,
      contact: contact,
      establishedYear: int.parse(establishedYearController.text),
      schoolType: selectedSchoolType.value.toString().split('.').last,
    );
  }

  UpdateSchoolOrganzationRequest getUpdateRequest() {
    final address = AddressInfo(
      region: regionController.text,
      zone: zoneController.text,
      city: cityController.text,
      kebeleNo: kebeleController.text,
    );
    final location = Location(
      region: regionController.text,
      zone: zoneController.text,
      city: cityController.text,
      kebeleNo: kebeleController.text,
    );
    final contact = Contact(
      phone: phoneController.text,
      email: emailController.text,
      website: websiteController.text,
    );

    return UpdateSchoolOrganzationRequest(
      schoolName: nameController.text,
      address: address,
      location: location,
      contact: contact,
      establishedYear: int.parse(establishedYearController.text),
      schoolType: selectedSchoolType.value.toString().split('.').last,
    );
  }

  // Show snackbar
  void showSuccess(String message) {
    GetSnackBar(
      message: message,
      backgroundColor: TemarLijeColors.success,
      duration: const Duration(seconds: 2),
      snackPosition: SnackPosition.BOTTOM,
    ).show();
  }

  void showError(String message) {
    GetSnackBar(
      message: message,
      backgroundColor: TemarLijeColors.error,
      duration: const Duration(seconds: 3),
      snackPosition: SnackPosition.BOTTOM,
    ).show();
  }

  // Show form dialog
  void showCreateForm() {
    setEditingSchool(null);
    Get.dialog(
      SchoolOrgFormDialog(
        schoolOrganization: null,
        onSubmit: (request) async {
          await createSchool(request);
        },
      ),
    );
  }

  void showEditForm(SchoolOrganzationModel school) {
    setEditingSchool(school);
    Get.dialog(
      SchoolOrgFormDialog(
        schoolOrganization: school,
        onSubmitUpdate: (id, request) async {
          await updateSchool(id, request);
        },
      ),
    );
  }

  // Show delete confirmation
  Future<bool?> showDeleteConfirmation(SchoolOrganzationModel school) async {
    return await Get.dialog<bool>(
      AlertDialog(
        backgroundColor: TemarLijeColors.cardBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text('Delete School Organization'),
        content: Text('Are you sure you want to delete "${school.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            style: ElevatedButton.styleFrom(
              backgroundColor: TemarLijeColors.facebookBackgroundColor,
            ),
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
  Future<void> handleDelete(SchoolOrganzationModel school) async {
    final confirmed = await showDeleteConfirmation(school);
    if (confirmed == true) {
      try {
        await deleteSchool(school);
        showSuccess('School organization deleted successfully!');
      } catch (e) {
        showError('Failed to delete school: $e');
      }
    }
  }

  // Handle create
  Future<void> handleCreate(CreateSchoolOrganzationRequest request) async {
    try {
      await createSchool(request);
      showSuccess('School organization created successfully!');
    } catch (e) {
      showError('Failed to create school: $e');
    }
  }

  // Handle update
  Future<void> handleUpdate(
    String id,
    UpdateSchoolOrganzationRequest request,
  ) async {
    try {
      await updateSchool(id, request);
      showSuccess('School organization updated successfully!');
    } catch (e) {
      showError('Failed to update school: $e');
    }
  }
}
