// lib/features/school/global_school_controller.dart
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ui_temarlije/data/models/school_organzation.dart';
import 'package:ui_temarlije/features/administrator/academic_year/academic_year_controller.dart';
import 'package:ui_temarlije/features/authentication/controllers/teacher_controller.dart';
import 'package:ui_temarlije/features/authentication/screens/dashboard/responsive_screens/dashboard_tablet.dart';
import 'package:ui_temarlije/service/school_orginzation_service.dart';
import 'package:uuid/uuid.dart';

class GlobalSchoolController extends GetxController {
  static GlobalSchoolController get instance =>
      Get.put(GlobalSchoolController());

  final SchoolOrganizationService _schoolService = Get.put(
    SchoolOrganizationService(),
  );

  // State
  final RxList<SchoolOrganzationModel> schools = <SchoolOrganzationModel>[].obs;
  final Rx<SchoolOrganzationModel?> selectedSchool =
      Rx<SchoolOrganzationModel?>(null);
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  // Get the selected school ID
  UuidValue? get schoolId => selectedSchool.value?.id;

  // Get the selected school name
  String get schoolName => selectedSchool.value?.name ?? 'No School Selected';

  // Check if a school is selected
  bool get hasSchoolSelected => selectedSchool.value != null;

  @override
  void onInit() {
    super.onInit();
    loadUserSchools();
  }

  // Load schools for the current user
  Future<void> loadUserSchools() async {
    isLoading.value = true;
    error.value = '';

    try {
      final schoolList = await _schoolService.getMySchools();
      schools.assignAll(schoolList);

      if (schoolList.isNotEmpty) {
        // If only one school, select it automatically
        if (schoolList.length == 1) {
          selectedSchool.value = schoolList.first;
        } else {
          // Try to load previously selected school from storage
          final savedSchoolId = await _getSavedSchoolId();
          if (savedSchoolId != null) {
            final savedSchool = schoolList.firstWhere(
              (school) => school.id.toString() == savedSchoolId,
              orElse: () => schoolList.first,
            );
            selectedSchool.value = savedSchool;
          } else {
            selectedSchool.value = schoolList.first;
          }
        }

        // Save the selected school
        if (selectedSchool.value != null) {
          await _saveSelectedSchool(selectedSchool.value!.id.toString());
        }
      } else {
        error.value = 'No schools found. Please join or create a school first.';
      }
    } catch (e) {
      error.value = 'Failed to load schools: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  // Select a school
  Future<void> selectSchool(SchoolOrganzationModel school) async {
    if (selectedSchool.value?.id != school.id) {
      selectedSchool.value = school;
      await _saveSelectedSchool(school.id.toString());

      // Refresh all components that depend on school selection
      _refreshDependentComponents();
    }
  }

  // Refresh all components that depend on school selection
  void _refreshDependentComponents() {
    // Refresh academic years
    if (Get.isRegistered<AcademicYearController>()) {
      Get.find<AcademicYearController>().loadAcademicYears();
    }

    // Refresh students

    // Refresh teachers
    if (Get.isRegistered<TeacherController>()) {
      Get.find<TeacherController>().loadTeachers();
    }

    // Refresh dashboard
    if (Get.isRegistered<DashboardController>()) {
      Get.find<DashboardController>();
    }

    // Add more controllers as needed
  }

  // Save selected school to local storage
  Future<void> _saveSelectedSchool(String schoolId) async {
    // Use GetStorage or SharedPreferences to save
    final storage = GetStorage();
    await storage.write('selected_school_id', schoolId);
  }

  // Get saved school ID from storage
  Future<String?> _getSavedSchoolId() async {
    final storage = GetStorage();
    return storage.read('selected_school_id');
  }

  // Get a school by ID
  SchoolOrganzationModel? getSchoolById(String id) {
    try {
      return schools.firstWhere((school) => school.id.toString() == id);
    } catch (e) {
      return null;
    }
  }
}
