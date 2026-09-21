import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/data/models/academic_year.dart';
import 'package:ui_temarlije/data/models/classroom.dart';
import 'package:ui_temarlije/data/models/section.dart';
import 'package:ui_temarlije/data/models/student_enrollment.dart';
import 'package:ui_temarlije/features/administrator/academic_year/academic_year_controller.dart';
import 'package:ui_temarlije/features/administrator/school_org/global_school_controller.dart';
import 'package:ui_temarlije/service/academic_year_service.dart';
import 'package:ui_temarlije/service/classroom_sections_service.dart';
import 'package:ui_temarlije/service/student_enrollment_service.dart';
import 'package:uuid/uuid.dart';

class StudentEnrollmentsController extends GetxController {
  final StudentEnrollmentService _service =
      Get.find<StudentEnrollmentService>();
  final GlobalSchoolController _schoolController =
      Get.find<GlobalSchoolController>();
  final AcademicYearController _academicYearController =
      Get.find<AcademicYearController>();
  final ClassroomService _classroomService = Get.find<ClassroomService>();
  final AcademicYearService _academicYearService =
      Get.find<AcademicYearService>();

  UuidValue? get schoolId => _schoolController.schoolId;

  // Observable state
  final RxList<StudentEnrollmentWithDetails> enrollments =
      <StudentEnrollmentWithDetails>[].obs;
  final RxList<StudentEnrollmentWithDetails> filteredEnrollments =
      <StudentEnrollmentWithDetails>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString searchQuery = ''.obs;

  // Filter options
  final Rx<EnrollmentStatus?> filterStatus = Rx<EnrollmentStatus?>(null);
  final Rx<String?> selectedSectionId = Rx<String?>(null);
  final Rx<String?> selectedAcademicYearId = Rx<String?>(null);
  final Rx<String?> selectedGradeId = Rx<String?>(null);

  // Available filters data
  final RxList<AcademicYear> availableAcademicYears = <AcademicYear>[].obs;
  final RxList<Section> availableSections = <Section>[].obs;
  final RxList<Classroom> availableClassrooms = <Classroom>[].obs;
  final RxBool isLoadingFilters = false.obs;

  // Selected objects for display
  final Rx<AcademicYear?> selectedAcademicYearObj = Rx<AcademicYear?>(null);
  final Rx<Section?> selectedSectionObj = Rx<Section?>(null);

  AcademicYear? get currentAcademicYear =>
      _academicYearController.currentAcademicYear.value;

  @override
  void onInit() {
    super.onInit();
    ever(_schoolController.selectedSchool, (_) {
      fetchEnrollments();
      loadFilterData();
    });
    ever(_academicYearController.currentAcademicYear, (_) {
      // Only auto-load if no specific AY is selected
      if (selectedAcademicYearId.value == null) {
        fetchEnrollments();
      }
    });
    ever(filterStatus, (_) => applyFilters());
    ever(searchQuery, (_) => applyFilters());
    ever(selectedSectionId, (_) => applyFilters());
    ever(selectedAcademicYearId, (_) {
      applyFilters();
      loadSectionsForAcademicYear(selectedAcademicYearId.value);
    });
    fetchEnrollments();
    loadFilterData();
  }

  // Load filter data (academic years, sections, etc.)
  Future<void> loadFilterData() async {
    if (schoolId == null) return;

    isLoadingFilters.value = true;
    try {
      // Load academic years
      await loadAcademicYears();
      // Load sections if academic year is selected or use current
      final ayId =
          selectedAcademicYearId.value ?? currentAcademicYear?.id.toString();
      if (ayId != null) {
        await loadSectionsForAcademicYear(ayId);
      }
    } catch (e) {
      print('Error loading filter data: $e');
    } finally {
      isLoadingFilters.value = false;
    }
  }

  Future<void> loadAcademicYears() async {
    if (schoolId == null) return;

    try {
      final response = await _academicYearService.getAcademicYears(schoolId!);
      availableAcademicYears.assignAll(response.academicYears);

      // Set default selection to current academic year if available
      if (currentAcademicYear != null && selectedAcademicYearId.value == null) {
        selectedAcademicYearId.value = currentAcademicYear!.id.toString();
        selectedAcademicYearObj.value = currentAcademicYear;
      } else if (availableAcademicYears.isNotEmpty &&
          selectedAcademicYearId.value == null) {
        // Fallback to first available if no current
        selectedAcademicYearId.value = availableAcademicYears.first.id
            .toString();
        selectedAcademicYearObj.value = availableAcademicYears.first;
      }
    } catch (e) {
      print('Error loading academic years: $e');
    }
  }

  Future<void> loadSectionsForAcademicYear(String? academicYearId) async {
    if (schoolId == null || academicYearId == null) return;

    try {
      // Get all classrooms for the academic year
      final classrooms = await _classroomService.getClassroomsByAcademicYear(
        schoolId!,
        UuidValue.fromString(academicYearId),
      );
      availableClassrooms.assignAll(classrooms);

      // Load sections for all classrooms
      final List<Section> allSections = [];
      for (final classroom in classrooms) {
        final sections = await _classroomService.getSectionsByClassroom(
          schoolId!,
          classroom.id,
        );
        allSections.addAll(sections);
      }
      availableSections.assignAll(allSections);

      // Auto-select current section if it matches
      if (selectedSectionId.value != null) {
        final foundSection = availableSections.firstWhereOrNull(
          (s) => s.id.toString() == selectedSectionId.value,
        );
        selectedSectionObj.value = foundSection;
      }
    } catch (e) {
      print('Error loading sections: $e');
    }
  }

  // Fetch enrollments with filters
  Future<void> fetchEnrollments() async {
    if (schoolId == null) {
      errorMessage.value = 'School ID is empty';
      return;
    }

    try {
      isLoading.value = true;
      errorMessage.value = '';

      // Build query parameters
      final queryParams = <String, dynamic>{};

      // Use selected academic year or fallback to current
      final ayId =
          selectedAcademicYearId.value ?? currentAcademicYear?.id.toString();
      if (ayId != null && ayId.isNotEmpty) {
        queryParams['academic_year_id'] = ayId;
      }

      if (selectedSectionId.value != null &&
          selectedSectionId.value!.isNotEmpty) {
        queryParams['section_id'] = selectedSectionId.value;
      }

      if (filterStatus.value != null) {
        queryParams['status'] = filterStatus.value.toString().split('.').last;
      }

      print('Fetching enrollments with params: $queryParams');

      final results = await _service.getEnrollments(
        schoolId: schoolId!,
        academicYearId: ayId,
        sectionId: selectedSectionId.value,
        status: filterStatus.value,
      );

      enrollments.assignAll(results);
      filteredEnrollments.assignAll(results);
      filteredEnrollments.refresh(); // Force UI update

      print('Fetched ${results.length} enrollments');
    } catch (e) {
      errorMessage.value = e.toString();
      print('Error: $e');
      Get.snackbar(
        'Error',
        'Failed to load enrollments: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Apply filters to the enrollment list
  void applyFilters() {
    var filtered = enrollments.toList();

    // Filter by status
    if (filterStatus.value != null) {
      filtered = filtered
          .where((e) => e.enrollmentStatus == filterStatus.value)
          .toList();
    }

    // Filter by section
    if (selectedSectionId.value != null &&
        selectedSectionId.value!.isNotEmpty) {
      filtered = filtered
          .where((e) => e.sectionId.toString() == selectedSectionId.value)
          .toList();
    }

    // Filter by search query
    if (searchQuery.value.isNotEmpty) {
      final query = searchQuery.value.toLowerCase();
      filtered = filtered
          .where(
            (e) =>
                e.studentName.toLowerCase().contains(query) ||
                e.sectionName.toLowerCase().contains(query) ||
                e.classroomName.toLowerCase().contains(query) ||
                (e.studentId.toString().toLowerCase().contains(query)),
          )
          .toList();
    }

    filteredEnrollments.assignAll(filtered);
    filteredEnrollments.refresh(); // Force UI update
  }

  // Enroll a student
  Future<void> enrollStudent({
    required String studentId,
    required String sectionId,
    required String academicYearId,
    DateTime? enrollmentDate,
  }) async {
    try {
      isLoading.value = true;

      await _service.enrollStudent(
        schoolId: schoolId!,
        studentId: studentId,
        sectionId: sectionId,
        academicYearId: academicYearId,
        enrollmentDate: enrollmentDate,
      );

      Get.snackbar(
        'Success',
        'Student enrolled successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      await fetchEnrollments();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to enroll student: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Update enrollment status
  Future<void> updateStatus({
    required String enrollmentId,
    required EnrollmentStatus status,
  }) async {
    try {
      isLoading.value = true;

      await _service.updateEnrollmentStatus(
        schoolId: schoolId!,
        enrollmentId: enrollmentId,
        status: status,
      );

      Get.snackbar(
        'Success',
        'Enrollment status updated',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      await fetchEnrollments();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update status: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Transfer student
  Future<void> transferStudent({
    required String enrollmentId,
    required String newSectionId,
  }) async {
    try {
      isLoading.value = true;

      await _service.transferStudent(
        schoolId: schoolId!,
        enrollmentId: enrollmentId,
        newSectionId: newSectionId,
      );

      Get.snackbar(
        'Success',
        'Student transferred successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      await fetchEnrollments();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to transfer student: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Withdraw student
  Future<void> withdrawStudent({required String enrollmentId}) async {
    try {
      isLoading.value = true;

      await _service.withdrawStudent(
        schoolId: schoolId!,
        enrollmentId: enrollmentId,
      );

      Get.snackbar(
        'Success',
        'Student withdrawn successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      await fetchEnrollments();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to withdraw student: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Delete enrollment
  Future<void> deleteEnrollment({required String enrollmentId}) async {
    try {
      isLoading.value = true;

      await _service.deleteEnrollment(
        schoolId: schoolId!,
        enrollmentId: enrollmentId,
      );

      Get.snackbar(
        'Success',
        'Enrollment deleted successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      await fetchEnrollments();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to delete enrollment: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Get enrollment summary
  Future<EnrollmentSummary?> getSummary() async {
    final ayId =
        selectedAcademicYearId.value ?? currentAcademicYear?.id.toString();
    if (ayId == null || ayId.isEmpty) return null;

    try {
      return await _service.getEnrollmentSummary(
        schoolId: schoolId!,
        academicYearId: ayId,
      );
    } catch (e) {
      print('Error getting summary: $e');
      return null;
    }
  }

  // Clear filters
  void clearFilters() {
    filterStatus.value = null;
    searchQuery.value = '';
    selectedSectionId.value = null;
    selectedSectionObj.value = null;
    // Reset academic year to current
    if (currentAcademicYear != null) {
      selectedAcademicYearId.value = currentAcademicYear!.id.toString();
      selectedAcademicYearObj.value = currentAcademicYear;
    }
    applyFilters();
  }

  // Get enrollment statistics
  Map<String, dynamic> getStatistics() {
    final total = filteredEnrollments.length;
    final active = filteredEnrollments
        .where((e) => e.enrollmentStatus == EnrollmentStatus.Active)
        .length;
    final withdrawn = filteredEnrollments
        .where((e) => e.enrollmentStatus == EnrollmentStatus.Withdrawn)
        .length;
    final transferred = filteredEnrollments
        .where((e) => e.enrollmentStatus == EnrollmentStatus.Transferred)
        .length;

    return {
      'total': total,
      // 'filtered': filtered,
      'active': active,
      'withdrawn': withdrawn,
      'transferred': transferred,
      'activePercentage': total > 0 ? (active / total * 100).round() : 0,
    };
  }

  // Update selected academic year
  void selectAcademicYear(String? academicYearId) {
    if (academicYearId != null && academicYearId.isNotEmpty) {
      selectedAcademicYearId.value = academicYearId;
      final foundAY = availableAcademicYears.firstWhereOrNull(
        (ay) => ay.id.toString() == academicYearId,
      );
      selectedAcademicYearObj.value = foundAY;
    } else {
      selectedAcademicYearId.value = null;
      selectedAcademicYearObj.value = null;
    }
  }

  // Update selected section
  void selectSection(String? sectionId) {
    if (sectionId != null && sectionId.isNotEmpty) {
      selectedSectionId.value = sectionId;
      final foundSection = availableSections.firstWhereOrNull(
        (s) => s.id.toString() == sectionId,
      );
      selectedSectionObj.value = foundSection;
    } else {
      selectedSectionId.value = null;
      selectedSectionObj.value = null;
    }
  }
}
