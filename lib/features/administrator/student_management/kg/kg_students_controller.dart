import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/data/models/academic_year.dart';
import 'package:ui_temarlije/data/models/fileds.dart';
import 'package:ui_temarlije/data/models/students.dart';
import 'package:ui_temarlije/features/administrator/academic_year/academic_year_controller.dart';
import 'package:ui_temarlije/features/administrator/school_org/global_school_controller.dart';
import 'package:ui_temarlije/features/administrator/student_management/kg/widgets/kg_student_form.dart';
import 'package:ui_temarlije/service/student_service.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';
import 'package:ui_temarlije/utils/constants/enums.dart';
import 'package:uuid/uuid.dart';

class KGStudentsController extends GetxController {
  static KGStudentsController get instance => Get.find<KGStudentsController>();
  final StudentService _kgStudentService = Get.find<StudentService>();
  final GlobalSchoolController _schoolController =
      Get.find<GlobalSchoolController>();
  final AcademicYearController _academicYearController =
      Get.find<AcademicYearController>();

  // Use Rx for better reactivity
  final Rx<IssuingAuthority?> selectedIssuingAuthority = Rx<IssuingAuthority?>(
    IssuingAuthority.CityAdministration,
  );

  final RxList<String> genderItems = ['Male', 'Female'].obs;
  final valueListenableOnGender = ValueNotifier<String?>(null);
  final Rx<RegionalStatesAndCities> regionalStatesDefult =
      RegionalStatesAndCities.AddisAbaba.obs;
  final valueListenableOnRegionalStates =
      ValueNotifier<RegionalStatesAndCities?>(null);
  final ValueNotifier<IssuingAuthority?>
  valueListenableOnSelectedIssuingAuthority = ValueNotifier<IssuingAuthority?>(
    null,
  );
  // final RxList<String> genderItems = ['Male', 'Female'].obs;
  // final Rx<String?> selectedGender = Rx<String?>(null);
  final Rx<RegionalStatesAndCities?> selectedRegion =
      Rx<RegionalStatesAndCities?>(RegionalStatesAndCities.AddisAbaba);

  // State
  final RxList<KGStudents> kgStudents = <KGStudents>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isSubmitting = false.obs;
  final RxString errorMessage = ''.obs;

  // Pagination
  final RxInt currentPage = 1.obs;
  final RxInt totalPages = 0.obs;
  final RxBool hasMoreData = true.obs;

  // Form Controllers
  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final middleNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final nationalIdController = TextEditingController();

  // Address Controllers
  final cityController = TextEditingController();
  final zoneController = TextEditingController();
  final woredaController = TextEditingController();
  final kebeleController = TextEditingController();
  final houseNumberController = TextEditingController();

  // Birth Certificate Controllers
  final certificateNumberController = TextEditingController();
  final issueDateController = TextEditingController();
  final isOriginalCopy = false.obs;
  final isPhotocopyProvided = false.obs;

  // Guardian
  final guardianIdController = TextEditingController();

  // Getters
  UuidValue? get schoolId => _schoolController.schoolId;
  UuidValue? get academicYearId =>
      _academicYearController.currentAcademicYear.value?.id;

  AcademicYear? get currentAcademicYear =>
      _academicYearController.currentAcademicYear.value;

  @override
  void onInit() {
    super.onInit();
    // Load students when academic year changes
    ever(_academicYearController.currentAcademicYear, (_) {
      loadKGStudents();
    });
    // Load students when school changes
    ever(_schoolController.selectedSchool, (_) {
      loadKGStudents();
    });
  }

  @override
  void onClose() {
    firstNameController.dispose();
    middleNameController.dispose();
    lastNameController.dispose();
    dateOfBirthController.dispose();
    phoneNumberController.dispose();
    nationalIdController.dispose();
    cityController.dispose();
    zoneController.dispose();
    woredaController.dispose();
    kebeleController.dispose();
    houseNumberController.dispose();
    certificateNumberController.dispose();
    issueDateController.dispose();
    guardianIdController.dispose();
    super.onClose();
  }

  // Load KG Students
  Future<void> loadKGStudents({int page = 1}) async {
    if (schoolId == null || academicYearId == null) {
      kgStudents.clear();
      return;
    }

    if (page == 1) {
      isLoading.value = true;
    }

    errorMessage.value = '';

    try {
      final students = await _kgStudentService.getKGStudents(
        schoolId: schoolId!,
        academicYearId: academicYearId!,
        page: page,
        limit: 20,
      );

      if (page == 1) {
        kgStudents.assignAll(students);
      } else {
        kgStudents.addAll(students);
      }

      hasMoreData.value = students.length >= 20;
      currentPage.value = page;
    } catch (e) {
      errorMessage.value = e.toString();
      _showError(errorMessage.value);
    } finally {
      if (page == 1) {
        isLoading.value = false;
      }
    }
  }

  // Load more for pagination
  Future<void> loadMoreKGStudents() async {
    if (!hasMoreData.value || isLoading.value) return;
    await loadKGStudents(page: currentPage.value + 1);
  }

  // Refresh
  Future<void> refreshKGStudents() async {
    await loadKGStudents(page: 1);
  }

  // Create KG Student - FIXED VERSION
  Future<void> createKGStudent() async {
    if (schoolId == null) {
      _showError('No school selected');
      return;
    }

    if (academicYearId == null) {
      _showError('No academic year selected');
      return;
    }

    if (!formKey.currentState!.validate()) {
      return;
    }

    isSubmitting.value = true;
    errorMessage.value = '';

    try {
      // Parse date of birth
      DateTime dateOfBirth;
      try {
        dateOfBirth = DateTime.parse(dateOfBirthController.text.trim());
      } catch (e) {
        _showError('Invalid date of birth format');
        isSubmitting.value = false;
        return;
      }

      // Parse issue date
      DateTime issueDate;
      try {
        issueDate = DateTime.parse(issueDateController.text.trim());
      } catch (e) {
        _showError('Invalid issue date format');
        isSubmitting.value = false;
        return;
      }

      // Get issuing authority from selected value
      final issuingAuthority = selectedIssuingAuthority.value;
      if (issuingAuthority == null) {
        _showError('Please select issuing authority');
        isSubmitting.value = false;
        return;
      }

      // Get gender from selected value
      final gender = valueListenableOnGender.value;
      if (gender == null || gender.isEmpty) {
        _showError('Please select gender');
        isSubmitting.value = false;
        return;
      }

      // Get region from selected value
      final region = selectedRegion.value;
      if (region == null) {
        _showError('Please select region');
        isSubmitting.value = false;
        return;
      }

      final request = KGStudentRegistrationRequest(
        firstName: firstNameController.text.trim(),
        middleName: middleNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        dateOfBirth: dateOfBirth,
        phoneNumber: phoneNumberController.text.trim(),
        gender: gender,
        guardianId: UuidValue.fromString(guardianIdController.text.trim()),
        nationalId: nationalIdController.text.trim().isEmpty
            ? null
            : nationalIdController.text.trim(),
        addressInfo: AddressInfo(
          region: region.name.toTitleCase(), // Use the enum value name
          city: cityController.text.trim(),
          zone: zoneController.text.trim(),
          kebeleNo: kebeleController.text.trim(),
        ),
        birthCertificate: BirthCertificate(
          certificateNumber: certificateNumberController.text.trim(),
          issuingAuthority: issuingAuthority,
          originalCopy: isOriginalCopy.value,
          photocopyProvided: isPhotocopyProvided.value,
          issueDate: issueDate,
        ),
      );

      await _kgStudentService.createKgStudent(
        kgStudent: request,
        schoolId: schoolId!,
        academicYearId: academicYearId!.toString(),
      );

      await loadKGStudents(page: 1);
      _showSuccess('KG Student created successfully!');
      _clearForm();
      Navigator.pop(Get.context!);
    } catch (e) {
      errorMessage.value = e.toString();
      debugPrint('Error creating KG student: $e');
      _showError('Failed to create KG student: $e');
    } finally {
      isSubmitting.value = false;
    }
  }

  // Delete KG Student
  Future<void> deleteKGStudent(KGStudents student) async {
    if (schoolId == null || academicYearId == null) return;

    try {
      isLoading.value = true;
      await _kgStudentService.deleteKGStudent(
        schoolId: schoolId!,
        academicYearId: academicYearId!,
        studentId: student.id,
      );

      kgStudents.remove(student);
      _showSuccess('KG Student deleted successfully!');
    } catch (e) {
      _showError('Failed to delete student: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Show delete confirmation
  Future<void> showDeleteConfirmation(KGStudents student) async {
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        backgroundColor: TemarLijeColors.cardBackgroundColor,
        title: const Text('Delete KG Student'),
        content: Text(
          'Are you sure you want to delete "${student.fullName}"?\n\nThis action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Get.back(result: true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await deleteKGStudent(student);
    }
  }

  // Show create form dialog
  void showCreateForm() {
    _clearForm();
    Get.dialog(
      KGStudentFormDialog(
        onSubmit: createKGStudent,
        isSubmitting: isSubmitting,
      ),
      barrierDismissible: false,
    );
  }

  // Helper methods
  void _clearForm() {
    firstNameController.clear();
    middleNameController.clear();
    lastNameController.clear();
    dateOfBirthController.clear();
    phoneNumberController.clear();
    nationalIdController.clear();
    cityController.clear();
    zoneController.clear();
    woredaController.clear();
    kebeleController.clear();
    houseNumberController.clear();
    certificateNumberController.clear();
    issueDateController.clear();
    guardianIdController.clear();
    isOriginalCopy.value = false;
    isPhotocopyProvided.value = false;
    selectedRegion.value = RegionalStatesAndCities.AddisAbaba;
    selectedIssuingAuthority.value = IssuingAuthority.CityAdministration;
    formKey.currentState?.reset();
  }

  void _showSuccess(String message) {
    Get.snackbar(
      'Success',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  void _showError(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }
}
