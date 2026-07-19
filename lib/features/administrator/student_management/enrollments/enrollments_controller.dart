import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/data/models/student_enrollment.dart';
import 'package:ui_temarlije/features/administrator/school_org/global_school_controller.dart';
import 'package:ui_temarlije/service/student_enrollment_service.dart';

class StudentEnrollmentsController extends GetxController {
  final StudentEnrollmentService _service =
      Get.find<StudentEnrollmentService>();
  final GlobalSchoolController _schoolController =
      Get.find<GlobalSchoolController>();

  String? get schoolId => _schoolController.schoolId;

  // Observable state
  final RxList<StudentEnrollmentWithDetails> enrollments =
      <StudentEnrollmentWithDetails>[].obs;
  final RxList<StudentEnrollmentWithDetails> filteredEnrollments =
      <StudentEnrollmentWithDetails>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString selectedAcademicYearId = ''.obs;
  final RxString selectedSectionId = ''.obs;
  final RxString searchQuery = ''.obs;

  // Filter options
  final Rx<EnrollmentStatus?> filterStatus = Rx<EnrollmentStatus?>(null);

  @override
  void onInit() {
    super.onInit();
    ever(_schoolController.selectedSchool, (_) {
      fetchEnrollments();
    });
    ever(filterStatus, (_) => applyFilters());
    ever(searchQuery, (_) => applyFilters());
    fetchEnrollments();
  }

  // Fetch all enrollments for the current school
  Future<void> fetchEnrollments() async {
    if (schoolId == null || schoolId!.isEmpty) {
      errorMessage.value = 'School ID is empty';
      return;
    }

    try {
      isLoading.value = true;
      errorMessage.value = '';

      final results = await _service.getEnrollments(
        schoolId: schoolId!,
        academicYearId: selectedAcademicYearId.value.isNotEmpty
            ? selectedAcademicYearId.value
            : null,
      );
      print('WHat is GOing On ${results} enrollments');

      enrollments.assignAll(results);
      filteredEnrollments.assignAll(results);

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

    // Filter by search query
    if (searchQuery.value.isNotEmpty) {
      final query = searchQuery.value.toLowerCase();
      filtered = filtered
          .where(
            (e) =>
                e.studentName.toLowerCase().contains(query) ||
                e.sectionName.toLowerCase().contains(query) ||
                e.classroomName.toLowerCase().contains(query),
          )
          .toList();
    }

    filteredEnrollments.assignAll(filtered);
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
    if (selectedAcademicYearId.value.isEmpty) return null;

    try {
      return await _service.getEnrollmentSummary(
        schoolId: schoolId!,
        academicYearId: selectedAcademicYearId.value,
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
    selectedSectionId.value = '';
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
      'active': active,
      'withdrawn': withdrawn,
      'transferred': transferred,
      'activePercentage': total > 0 ? (active / total * 100).round() : 0,
    };
  }
}
