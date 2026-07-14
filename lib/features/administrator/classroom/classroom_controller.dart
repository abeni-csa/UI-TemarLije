import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/data/models/academic_year.dart';
import 'package:ui_temarlije/data/models/classroom.dart';
import 'package:ui_temarlije/data/models/section.dart';
import 'package:ui_temarlije/features/administrator/academic_year/academic_year_controller.dart';
import 'package:ui_temarlije/features/administrator/school_org/global_school_controller.dart';
import 'package:ui_temarlije/service/classroom_sections_service.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';

class ClassroomController extends GetxController {
  static ClassroomController get instance => Get.find();

  final ClassroomService _classroomService = Get.find<ClassroomService>();
  final GlobalSchoolController _schoolController =
      Get.find<GlobalSchoolController>();
  final AcademicYearController _academicYearController =
      Get.find<AcademicYearController>();

  // State
  final RxList<Classroom> classrooms = <Classroom>[].obs;
  final RxMap<GradeLevel, List<Classroom>> groupedClassrooms =
      <GradeLevel, List<Classroom>>{}.obs;
  final RxMap<String, List<Section>> sectionsByClassroom =
      <String, List<Section>>{}.obs;
  final RxBool isLoading = false.obs;
  final RxBool isGenerating = false.obs;
  final RxString error = ''.obs;
  final Rx<GradeLevel?> selectedGradeLevel = Rx<GradeLevel?>(null);

  // Selected classroom for section view
  final Rx<Classroom?> selectedClassroom = Rx<Classroom?>(null);
  // Number of section
  final RxInt numberOfSection = 1.obs;
  // Form
  final formKey = GlobalKey<FormState>();
  // Bulk section creation state
  final RxInt sectionsPerClassroom = 1.obs;
  final RxString namingPrefix = 'Section '.obs;
  final RxInt startIndex = 1.obs;
  final RxString namingSuffix = ''.obs;
  final RxInt defaultCapacity = 45.obs;
  final RxString selectedNamingPattern =
      'sequential'.obs; // 'sequential' or 'alpha'

  // Form controllers for bulk sections
  late final TextEditingController sectionsPerClassroomController;
  late final TextEditingController namingPrefixController;
  late final TextEditingController startIndexController;
  late final TextEditingController namingSuffixController;
  late final TextEditingController defaultCapacityController;
  // Grade level colors
  final Map<GradeLevel, Color> gradeColors = {
    GradeLevel.kindergarten: const Color(0xFFFF6B6B),
    GradeLevel.primary: const Color(0xFF4ECDC4),
    GradeLevel.secondary: const Color(0xFF6C63FF),
    GradeLevel.highSchool: const Color(0xFFFFE66D),
    GradeLevel.preparatory: const Color(0xFFFF8A5C),
  };

  String? get schoolId => _schoolController.schoolId;
  AcademicYear? get currentAcademicYear =>
      _academicYearController.currentAcademicYear.value;

  @override
  void onInit() {
    // _initializeControllers();
    _initializeBulkControllers();
    super.onInit();
    ever(_academicYearController.currentAcademicYear, (_) {
      loadClassrooms();
    });
    ever(_schoolController.selectedSchool, (_) {
      loadClassrooms();
    });
    loadClassrooms();
  }

  // Validate and submit form
  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  void _initializeBulkControllers() {
    sectionsPerClassroomController = TextEditingController(text: '1');
    namingPrefixController = TextEditingController(text: 'Section ');
    startIndexController = TextEditingController(text: '1');
    namingSuffixController = TextEditingController(text: '');
    defaultCapacityController = TextEditingController(text: '45');
  }

  @override
  void onClose() {
    sectionsPerClassroomController.dispose();
    namingPrefixController.dispose();
    startIndexController.dispose();
    namingSuffixController.dispose();
    defaultCapacityController.dispose();
    super.onClose();
  }

  // Create bulk sections
  Future<void> createBulkSections() async {
    if (schoolId == null || currentAcademicYear == null) {
      _showError('No school or academic year selected');
      return;
    }

    isLoading.value = true;
    error.value = '';

    try {
      final request = BulkSectionRequest(
        schoolId: schoolId!,
        academicYearId: currentAcademicYear!.id,
        sectionsPerClassroom:
            int.tryParse(sectionsPerClassroomController.text) ?? 1,
        namingPattern: NamingPattern(
          prefix: namingPrefixController.text,
          startIndex: int.tryParse(startIndexController.text) ?? 1,
          suffix: namingSuffixController.text.isEmpty
              ? null
              : namingSuffixController.text,
        ),
        defaultCapacity: int.tryParse(defaultCapacityController.text) ?? 45,
      );

      await _classroomService.createBulkSections(schoolId!, request);

      // await loadSectionsForClassroom(classroomId);
      _showSuccess('Sections created successfully!');
      Get.back(); // Close dialog
    } catch (e) {
      error.value = e.toString();
      _showError(error.value);
    } finally {
      isLoading.value = false;
    }
  }

  /// Load classrooms for current school and academic year
  Future<void> loadClassrooms() async {
    if (schoolId == null || currentAcademicYear == null) {
      classrooms.clear();
      groupedClassrooms.clear();
      return;
    }

    isLoading.value = true;
    error.value = '';

    try {
      final classroomList = await _classroomService.getClassroomsByAcademicYear(
        schoolId!,
        currentAcademicYear!.id,
      );
      classrooms.assignAll(classroomList);

      // Group by grade level
      final grouped = <GradeLevel, List<Classroom>>{};
      for (final classroom in classroomList) {
        grouped.putIfAbsent(classroom.gradeLevel, () => []);
        grouped[classroom.gradeLevel]!.add(classroom);
        // Sort by display order
        grouped[classroom.gradeLevel]!.sort(
          (a, b) => a.displayOrder.compareTo(b.displayOrder),
        );
      }
      groupedClassrooms.assignAll(grouped);
    } catch (e) {
      error.value = e.toString();
      _showError(error.value);
    } finally {
      isLoading.value = false;
    }
  }

  /// Generate classrooms for a grade level
  Future<void> generateClassrooms(
    GradeLevel gradeLevel,
    int displayOrderOffset,
  ) async {
    print(currentAcademicYear.toString());
    print('Current ID${currentAcademicYear!.id}');
    if (schoolId == null || currentAcademicYear == null) {
      _showError('No school or academic year selected');
      return;
    }

    isGenerating.value = true;
    error.value = '';

    try {
      final request = CreateClassroomRequest(
        academicYearId: currentAcademicYear!.id,
        gradeLevel: gradeLevel,
        displayOrderOffset: displayOrderOffset,
        capacity: 45,
        createKgTypes: gradeLevel == GradeLevel.kindergarten,
      );

      await _classroomService.generateClassrooms(schoolId!, request);
      await loadClassrooms();
      _showSuccess('${_getGradeLevelDisplay(gradeLevel)} classrooms created!');
    } catch (e) {
      error.value = e.toString();
      _showError(error.value);
    } finally {
      isGenerating.value = false;
    }
  }

  /// Generate classrooms for a grade level
  Future<void> generateSectionsForClassrooms(
    GradeLevel gradeLevel,
    int displayOrderOffset,
  ) async {
    print(currentAcademicYear.toString());
    print('Current ID${currentAcademicYear!.id}');
    if (schoolId == null || currentAcademicYear == null) {
      _showError('No school or academic year selected');
      return;
    }

    isGenerating.value = true;
    error.value = '';

    try {
      final request = CreateClassroomRequest(
        academicYearId: currentAcademicYear!.id,
        gradeLevel: gradeLevel,
        displayOrderOffset: displayOrderOffset,
        capacity: 45,
        createKgTypes: gradeLevel == GradeLevel.kindergarten,
      );

      await _classroomService.generateClassrooms(schoolId!, request);
      await loadClassrooms();
      _showSuccess('${_getGradeLevelDisplay(gradeLevel)} classrooms created!');
    } catch (e) {
      error.value = e.toString();
      _showError(error.value);
    } finally {
      isGenerating.value = false;
    }
  }

  /// Load sections for a specific classroom
  Future<void> loadSectionsForClassroom(String classroomId) async {
    if (schoolId == null) return;

    try {
      final sections = await _classroomService.getSectionsByClassroom(
        schoolId!,
        classroomId,
      );
      sectionsByClassroom[classroomId] = sections;
      update();
    } catch (e) {
      print('Error loading sections: $e');
    }
  }

  /// Get sections for a classroom (cached or loaded)
  Future<List<Section>> getSectionsForClassroom(String classroomId) async {
    if (!sectionsByClassroom.containsKey(classroomId)) {
      await loadSectionsForClassroom(classroomId);
    }
    return sectionsByClassroom[classroomId] ?? [];
  }

  /// Get classrooms by grade level
  List<Classroom> getClassroomsByLevel(GradeLevel level) {
    return groupedClassrooms[level] ?? [];
  }

  /// Check if grade level has classrooms
  bool hasClassroomsForLevel(GradeLevel level) {
    return (groupedClassrooms[level] ?? []).isNotEmpty;
  }

  /// Select a classroom to view sections
  void selectClassroom(Classroom classroom) {
    selectedClassroom.value = classroom;
    loadSectionsForClassroom(classroom.id);
  }

  /// Show dialog to create classrooms for a grade level
  void showGenerateDialog(GradeLevel gradeLevel) {
    // Show confirmation dialog before generating
    Get.dialog(
      AlertDialog(
        backgroundColor: TemarLijeColors.cardBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Generate ${_getGradeLevelDisplay(gradeLevel)} Classrooms'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'This will create all classrooms for ${_getGradeLevelDisplay(gradeLevel)} level.',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            Text(
              'Grade levels included:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 4),
            _buildGradeLevelList(gradeLevel),
            const SizedBox(height: 12),
            Text(
              'Each classroom will have a capacity of 45 students.',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Get.back();
              _generateWithOffset(gradeLevel);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: TemarLijeColors.primary,
            ),
            child: const Text('Generate'),
          ),
        ],
      ),
    );
  }

  Widget _buildGradeLevelList(GradeLevel gradeLevel) {
    final grades = _getGradeLevels(gradeLevel);
    return Wrap(
      spacing: 8,
      children: grades.map((grade) {
        return Chip(
          label: Text(grade),
          backgroundColor: gradeColors[gradeLevel]?.withAlpha(35),
          labelStyle: TextStyle(color: gradeColors[gradeLevel]),
          padding: const EdgeInsets.symmetric(horizontal: 4),
        );
      }).toList(),
    );
  }

  List<String> _getGradeLevels(GradeLevel level) {
    switch (level) {
      case GradeLevel.kindergarten:
        return ['Nursery', 'Lower KG', 'Upper KG'];
      case GradeLevel.primary:
        return [
          'Grade 1',
          'Grade 2',
          'Grade 3',
          'Grade 4',
          'Grade 5',
          'Grade 6',
        ];
      case GradeLevel.secondary:
        return ['Grade 7', 'Grade 8'];
      case GradeLevel.highSchool:
        return ['Grade 9', 'Grade 10'];
      case GradeLevel.preparatory:
        return ['Grade 11', 'Grade 12'];
    }
  }

  void _generateWithOffset(GradeLevel gradeLevel) {
    final offsetMap = {
      GradeLevel.kindergarten: 1,
      GradeLevel.primary: 4,
      GradeLevel.secondary: 10,
      GradeLevel.highSchool: 12,
      GradeLevel.preparatory: 14,
    };
    generateClassrooms(gradeLevel, offsetMap[gradeLevel] ?? 0);
  }

  String _getGradeLevelDisplay(GradeLevel level) {
    switch (level) {
      case GradeLevel.kindergarten:
        return 'Kindergarten';
      case GradeLevel.primary:
        return 'Primary';
      case GradeLevel.secondary:
        return 'Secondary';
      case GradeLevel.highSchool:
        return 'High School';
      case GradeLevel.preparatory:
        return 'Preparatory';
    }
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
}
