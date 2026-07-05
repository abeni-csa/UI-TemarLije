import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/data/models/teacher.dart';
import 'package:ui_temarlije/data/repositories/teacher_repository.dart';
import 'package:uuid/uuid.dart';

class TeacherController extends GetxController {
  static TeacherController get instance => Get.find<TeacherController>();
  final TeacherRepository _repository = TeacherRepository.instance;

  // Observable states
  final RxList<Teacher> teachers = <Teacher>[].obs;
  final Rx<Teacher?> selectedTeacher = Rx<Teacher?>(null);
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxBool isSuccess = false.obs;
  // Reactive variables
  var selectedGender = Rx<String?>(null);

  // Pagination
  final RxInt currentPage = 1.obs;
  final RxInt totalPages = 1.obs;
  final RxBool hasMoreData = true.obs;

  // Form Data Holeres

  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final middleNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final qualificationController = TextEditingController();
  final specializationController = TextEditingController();
  final yearsOfExperienceController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final genderController = TextEditingController();
  final regionController = TextEditingController();
  final zoneController = TextEditingController();
  final cityController = TextEditingController();
  final kebeleController = TextEditingController();
  String? selectedEmploymentType;
  bool isHomeroomTeacher = false;

  final List<String> employmentTypes = [
    'Permanent',
    'Contract',
    'PartTime',
    'Internship',
  ];

  @override
  void onInit() {
    super.onInit();
    loadTeachers();
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
      dateOfBirthController.text = picked.toIso8601String().split('T').first;
    }
  }

  /// Load all teachers
  Future<void> loadTeachers() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final result = await _repository.getTeachers();
      teachers.assignAll(result);
      isSuccess.value = true;
    } catch (e) {
      errorMessage.value = e.toString();
      isSuccess.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  /// Load teacher by ID
  Future<void> loadTeacherById(String id) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final result = await _repository.getTeacherById(id);
      selectedTeacher.value = result;
      isSuccess.value = true;
    } catch (e) {
      errorMessage.value = e.toString();
      isSuccess.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  /// Create new teacher
  Future<bool> createTeacher(CreateTeacherRequest request) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final result = await _repository.createTeacher(request);
      teachers.add(result);
      isSuccess.value = true;
      return true;
    } catch (e) {
      errorMessage.value = e.toString();
      isSuccess.value = false;
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  /// Update teacher
  Future<bool> updateTeacher(Uuid id, UpdateTeacherRequest request) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final result = await _repository.updateTeacher(id, request);

      // Update in list
      final index = teachers.indexWhere((t) => t.id == id);
      if (index != -1) {
        teachers[index] = result;
      }

      // Update selected if it's the same
      if (selectedTeacher.value?.id == id) {
        selectedTeacher.value = result;
      }

      isSuccess.value = true;
      return true;
    } catch (e) {
      errorMessage.value = e.toString();
      isSuccess.value = false;
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  /// Delete teacher
  Future<bool> deleteTeacher(Uuid id) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      await _repository.deleteTeacher(id);

      // Remove from list
      teachers.removeWhere((t) => t.id == id);

      // Clear selected if it's the same
      if (selectedTeacher.value?.id == id) {
        selectedTeacher.value = null;
      }

      isSuccess.value = true;
      return true;
    } catch (e) {
      errorMessage.value = e.toString();
      isSuccess.value = false;
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  /// Filter teachers by specialization
  Future<void> filterBySpecialization(String specialization) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final result = await _repository.getTeachersBySpecialization(
        specialization,
      );
      teachers.assignAll(result);
      isSuccess.value = true;
    } catch (e) {
      errorMessage.value = e.toString();
      isSuccess.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  /// Filter homeroom teachers
  Future<void> filterHomeroomTeachers() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final result = await _repository.getHomeroomTeachers();
      teachers.assignAll(result);
      isSuccess.value = true;
    } catch (e) {
      errorMessage.value = e.toString();
      isSuccess.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  /// Clear error message
  void clearError() {
    errorMessage.value = '';
  }

  /// Reset state
  void resetState() {
    isLoading.value = false;
    errorMessage.value = '';
    isSuccess.value = false;
  }

  void _clearForm() {
    firstNameController.clear();
    middleNameController.clear();
    lastNameController.clear();
    dateOfBirthController.clear();
    qualificationController.clear();
    specializationController.clear();
    yearsOfExperienceController.clear();
    phoneNumberController.clear();
    genderController.clear();
    regionController.clear();
    zoneController.clear();
    cityController.clear();
    kebeleController.clear();
  }
}
