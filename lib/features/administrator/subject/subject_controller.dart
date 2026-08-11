import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/data/models/academic_year.dart';
import 'package:ui_temarlije/data/models/subject.dart';
import 'package:ui_temarlije/features/administrator/academic_year/academic_year_controller.dart';
import 'package:ui_temarlije/features/administrator/school_org/global_school_controller.dart';
import 'package:ui_temarlije/features/administrator/subject/screens/widgets/subject_form.dart';
import 'package:ui_temarlije/service/subject_service.dart';
import 'package:ui_temarlije/service/academic_year_service.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';
import 'package:ui_temarlije/utils/constants/enums.dart';
import 'package:uuid/uuid.dart';

class SubjectController extends GetxController {
  static SubjectController get instance => Get.find<SubjectController>();

  final GlobalSchoolController _schoolController =
      Get.find<GlobalSchoolController>();
  final AcademicYearController _academicYearController =
      Get.find<AcademicYearController>();
  final SubjectService _subjectService = Get.find<SubjectService>();
  final AcademicYearService _academicYearService =
      Get.find<AcademicYearService>();

  // State
  final RxList<Subject> subjects = <Subject>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isLoadingFilters = false.obs;
  final RxString errorMessage = ''.obs;

  // Filters
  final Rx<UuidValue?> selectedAcademicYearId = Rx<UuidValue?>(null);
  final Rx<EducationLevel?> selectedEducationLevel = Rx<EducationLevel?>(null);
  final RxList<AcademicYear> availableAcademicYears = <AcademicYear>[].obs;
  final Rx<AcademicYear?> selectedAcademicYearObj = Rx<AcademicYear?>(null);

  // Form controllers
  final formKey = GlobalKey<FormState>();
  late final TextEditingController nameController;
  late final TextEditingController descriptionController;
  late final TextEditingController weeklyPeriodsController;
  late final TextEditingController teacherQualificationController;

  // Form selections
  final RxBool isCore = false.obs;
  final RxBool isFieldBased = false.obs;
  final RxBool requiresSpecialRoom = false.obs;
  final Rx<RoomType> selectedRoomType = RoomType.Regular.obs;
  final RxList<EducationLevel> selectedEducationLevels = <EducationLevel>[].obs;
  final RxList<SubjectTypeStream> selectedStreams = <SubjectTypeStream>[].obs;
  final RxList<String> teacherQualifications = <String>[].obs;

  Subject? editingSubject;

  UuidValue? get schoolId => _schoolController.schoolId;
  AcademicYear? get currentAcademicYear =>
      _academicYearController.currentAcademicYear.value;

  @override
  void onInit() {
    super.onInit();
    _initializeControllers();
    _initializeFilters();
    loadSubjects();
  }

  void _initializeControllers() {
    nameController = TextEditingController();
    descriptionController = TextEditingController();
    weeklyPeriodsController = TextEditingController();
    teacherQualificationController = TextEditingController();
  }

  void _initializeFilters() async {
    if (schoolId != null) {
      await loadAcademicYears();
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    descriptionController.dispose();
    weeklyPeriodsController.dispose();
    teacherQualificationController.dispose();
    super.onClose();
  }

  // Load academic years for filtering
  Future<void> loadAcademicYears() async {
    if (schoolId == null) return;

    isLoadingFilters.value = true;
    try {
      final response = await _academicYearService.getAcademicYears(schoolId!);
      availableAcademicYears.assignAll(response.academicYears);
      if (availableAcademicYears.isNotEmpty) {
        // Set current academic year if not set
        final current = await _academicYearService.getCurrentAcademicYear(
          schoolId!,
        );
        // .catchError((err) => print('Error: $err'));
        selectedAcademicYearId.value = current.id;
        selectedAcademicYearObj.value = current;
      }
    } catch (e) {
      errorMessage.value = 'Failed to load academic years: $e';
    } finally {
      isLoadingFilters.value = false;
    }
  }

  // Load subjects with current filters
  Future<void> loadSubjects() async {
    if (schoolId == null || selectedAcademicYearId.value == null) return;

    isLoading.value = true;
    errorMessage.value = '';

    try {
      List<Subject> loadedSubjects;
      if (selectedEducationLevel.value != null) {
        loadedSubjects = await _subjectService.getSubjectsByEducationLevel(
          schoolId!,
          selectedAcademicYearId.value!,
          selectedEducationLevel.value!,
        );
      } else {
        loadedSubjects = await _subjectService.getSubjects(
          schoolId!,
          selectedAcademicYearId.value!,
        );
      }
      subjects.assignAll(loadedSubjects);
    } catch (e) {
      errorMessage.value = 'Failed to load subjects: $e';
      subjects.clear();
    } finally {
      isLoading.value = false;
    }
  }

  // Refresh subjects
  Future<void> refreshSubjects() async {
    await loadSubjects();
  }

  // Create subject
  Future<void> createSubject(CreateSubjectRequest request) async {
    if (schoolId == null || selectedAcademicYearId.value == null) {
      throw Exception('School or academic year not selected');
    }

    isLoading.value = true;
    errorMessage.value = '';

    try {
      final created = await _subjectService.createSubjects(
        request,
        schoolId!,
        selectedAcademicYearId.value!,
      );
      subjects.insert(0, created);
      showSuccess('Subject created successfully!');
    } catch (e) {
      errorMessage.value = 'Failed to create subject: $e';
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  // Update subject
  Future<void> updateSubject(
    UuidValue subjectId,
    UpdateSubjectRequest request,
  ) async {
    if (schoolId == null || selectedAcademicYearId.value == null) {
      throw Exception('School or academic year not selected');
    }

    isLoading.value = true;
    errorMessage.value = '';

    try {
      final updated = await _subjectService.updateSubject(
        subjectId,
        schoolId!,
        selectedAcademicYearId.value!,
        request,
      );
      final index = subjects.indexWhere((s) => s.id == subjectId);
      if (index != -1) {
        subjects[index] = updated;
      }
      showSuccess('Subject updated successfully!');
    } catch (e) {
      errorMessage.value = 'Failed to update subject: $e';
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  // Delete subject
  Future<void> deleteSubject(Subject subject) async {
    if (schoolId == null) return;

    isLoading.value = true;
    errorMessage.value = '';

    try {
      await _subjectService.deleteSubject(subject.id, schoolId!);
      subjects.removeWhere((s) => s.id == subject.id);
      showSuccess('Subject deleted successfully!');
    } catch (e) {
      errorMessage.value = 'Failed to delete subject: $e';
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  // Set form for editing
  void setEditingSubject(Subject? subject) {
    editingSubject = subject;
    if (subject != null) {
      nameController.text = subject.name;
      descriptionController.text = subject.description ?? '';
      weeklyPeriodsController.text = subject.weeklyPeriods.toString();
      isCore.value = subject.isCore;
      isFieldBased.value = subject.isFieldBased;
      requiresSpecialRoom.value = subject.requiresSpecialRoom;
      selectedRoomType.value = subject.roomType;
      selectedEducationLevels.assignAll(subject.educationLevels);
      selectedStreams.assignAll(subject.streams);
      teacherQualifications.assignAll(subject.teacherQualifications);
    } else {
      _clearForm();
    }
  }

  void _clearForm() {
    nameController.clear();
    descriptionController.clear();
    weeklyPeriodsController.clear();
    isCore.value = false;
    isFieldBased.value = false;
    requiresSpecialRoom.value = false;
    selectedRoomType.value = RoomType.Regular;
    selectedEducationLevels.clear();
    selectedStreams.clear();
    teacherQualifications.clear();
    editingSubject = null;
  }

  // Validate and submit form
  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  CreateSubjectRequest getCreateRequest() {
    return CreateSubjectRequest(
      name: nameController.text.trim(),
      description: descriptionController.text.isEmpty
          ? null
          : descriptionController.text.trim(),
      isCore: isCore.value,
      isFieldBased: isFieldBased.value,
      weeklyPeriods: int.tryParse(weeklyPeriodsController.text) ?? 0,
      teacherQualifications: teacherQualifications.toList(),
      educationLevels: selectedEducationLevels.toList(),
      streams: selectedStreams.toList(),
      requiresSpecialRoom: requiresSpecialRoom.value,
      roomType: selectedRoomType.value,
    );
  }

  UpdateSubjectRequest getUpdateRequest() {
    return UpdateSubjectRequest(
      subjectName: nameController.text.trim(),
      description: descriptionController.text.isEmpty
          ? null
          : descriptionController.text.trim(),
      isCore: isCore.value,
      isFieldBased: isFieldBased.value,
      weeklyPeriods: int.tryParse(weeklyPeriodsController.text) ?? 0,
      teacherQualifications: teacherQualifications.toList(),
      educationLevels: selectedEducationLevels.toList(),
      streams: selectedStreams.toList(),
      requiresSpecialRoom: requiresSpecialRoom.value,
      roomType: selectedRoomType.value,
    );
  }

  // Filter methods
  void setAcademicYearFilter(UuidValue? academicYearId) {
    selectedAcademicYearId.value = academicYearId;
    selectedAcademicYearObj.value = availableAcademicYears.firstWhereOrNull(
      (year) => year.id == academicYearId,
    );
    loadSubjects();
  }

  void setEducationLevelFilter(EducationLevel? level) {
    selectedEducationLevel.value = level;
    loadSubjects();
  }

  void clearFilters() {
    selectedEducationLevel.value = null;
    loadSubjects();
  }

  // Qualification management
  void addQualification() {
    final text = teacherQualificationController.text.trim();
    if (text.isNotEmpty) {
      teacherQualifications.add(text);
      teacherQualificationController.clear();
    }
  }

  void removeQualification(int index) {
    teacherQualifications.removeAt(index);
  }

  // UI Helpers
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

  // Dialog methods
  void showCreateForm() {
    setEditingSubject(null);
    Get.dialog(
      SubjectFormDialog(
        subject: null,
        onSubmit: (request) async {
          await createSubject(request);
        },
      ),
    );
  }

  void showEditForm(Subject subject) {
    setEditingSubject(subject);
    Get.dialog(
      SubjectFormDialog(
        subject: subject,
        onSubmitUpdate: (id, request) async {
          await updateSubject(id, request);
        },
      ),
    );
  }

  Future<bool?> showDeleteConfirmation(Subject subject) async {
    return await Get.dialog<bool>(
      AlertDialog(
        backgroundColor: TemarLijeColors.cardBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text('Delete Subject'),
        content: Text('Are you sure you want to delete "${subject.name}"?'),
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

  Future<void> handleDelete(Subject subject) async {
    final confirmed = await showDeleteConfirmation(subject);
    if (confirmed == true) {
      try {
        await deleteSubject(subject);
      } catch (e) {
        showError('Failed to delete subject: $e');
      }
    }
  }
}
