// lib/features/administrator/teacher_management/teacher_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/data/models/teacher.dart';
import 'package:ui_temarlije/features/administrator/school_org/global_school_controller.dart';
import 'package:ui_temarlije/service/teacher_service.dart';

class AllTeacherController extends GetxController {
  static AllTeacherController get instance => Get.find();

  final TeacherService _teacherService = Get.find<TeacherService>();

  // Observables
  final RxList<Teacher> teachers = <Teacher>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxInt currentPage = 1.obs;
  final RxInt totalPages = 0.obs;
  final RxInt totalItems = 0.obs;
  final RxBool hasMoreData = true.obs;
  // Search and filter
  final RxString searchQuery = ''.obs;
  final TextEditingController searchController = TextEditingController();
  final GlobalSchoolController _schoolController =
      Get.find<GlobalSchoolController>();
  // Getter for selected school ID
  String? get schoolId => _schoolController.schoolId;
  @override
  void onInit() {
    super.onInit();
    //Load academic years when school is selected
    ever(_schoolController.selectedSchool, (_) {
      fetchAllTeachers();
    });
    fetchAllTeachers();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  /// Fetch all teachers from the API
  Future<void> fetchAllTeachers({int page = 1, int limit = 20}) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _teacherService.getAllTeachers(
        page: page,
        limit: limit,
        schoolId: schoolId!,
      );

      if (page == 1) {
        teachers.value = response.teachers;
      } else {
        teachers.addAll(response.teachers);
      }

      totalPages.value = response.totalPages;
      totalItems.value = response.totalItems;
      currentPage.value = page;
      hasMoreData.value = page < response.totalPages;
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar(
        'Error',
        'Failed to load teachers: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Load more data for pagination
  Future<void> loadMoreTeachers() async {
    if (!hasMoreData.value || isLoading.value) return;
    await fetchAllTeachers(page: currentPage.value + 1);
  }

  /// Refresh the teacher list
  Future<void> refreshTeachers() async {
    await fetchAllTeachers(page: 1);
  }

  /// Search teachers by query
  Future<void> searchTeachers(String query) async {
    searchQuery.value = query;
    if (query.isEmpty) {
      await fetchAllTeachers(page: 1);
      return;
    }

    try {
      isLoading.value = true;
      final results = await _teacherService.searchTeachers(query);
      teachers.value = results;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  /// Get teacher by ID
  Future<Teacher?> getTeacherById(String teacherId) async {
    try {
      return await _teacherService.getTeacherById(teacherId);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load teacher details: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return null;
    }
  }

  /// Get teachers by school ID
  Future<void> fetchTeachersBySchool(String schoolId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final results = await _teacherService.getTeachersBySchool(schoolId);
      teachers.value = results;
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar(
        'Error',
        'Failed to load teachers for this school: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
