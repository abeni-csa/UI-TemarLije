import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/data/models/fileds.dart';
import 'package:ui_temarlije/data/models/students.dart';
import 'package:ui_temarlije/features/administrator/academic_year/academic_year_controller.dart';
import 'package:ui_temarlije/features/administrator/school_org/global_school_controller.dart';
import 'package:ui_temarlije/service/student_service.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';
import 'package:uuid/uuid.dart';
import 'package:ui_temarlije/data/models/section.dart';

class SectionStudentsController extends GetxController {
  static SectionStudentsController get instance =>
      Get.find<SectionStudentsController>();

  final StudentService _kgStudentService = Get.find<StudentService>();
  final GlobalSchoolController _schoolController =
      Get.find<GlobalSchoolController>();
  final AcademicYearController _academicYearController =
      Get.find<AcademicYearController>();

  // Current section
  final Rx<Section?> currentSection = Rx<Section?>(null);

  // Students enrolled in this section
  final RxList<Students> enrolledStudents = <Students>[].obs;

  // Available students (not enrolled in any section)
  final RxList<Students> availableStudents = <Students>[].obs;

  // Loading states
  final RxBool isLoadingStudents = false.obs;
  final RxBool isLoadingAvailable = false.obs;
  final RxBool isAddingStudents = false.obs;

  // Error messages
  final RxString errorMessage = ''.obs;

  // Selected students for bulk enrollment
  final RxList<Students> selectedStudents = <Students>[].obs;

  /// Load section details and its students
  Future<void> loadSectionDetails(Section section) async {
    currentSection.value = section;
    await loadEnrolledStudents(section.id);
  }

  /// Load students enrolled in the section
  /// TODO: Replace with actual API call
  Future<void> loadEnrolledStudents(UuidValue sectionId) async {
    isLoadingStudents.value = true;
    errorMessage.value = '';

    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 800));

      // MOCK DATA - Replace with actual API call
      // GET /org/school/{schoolId}/sections/{sectionId}/students
      final mockStudents = _generateMockStudents(count: 15);
      enrolledStudents.assignAll(mockStudents);
    } catch (e) {
      errorMessage.value = 'Failed to load students: $e';
      _showError(errorMessage.value);
    } finally {
      isLoadingStudents.value = false;
    }
  }

  /// Load students available for enrollment (not in any section)
  /// TODO: Replace with actual API call
  Future<void> loadAvailableStudents() async {
    isLoadingAvailable.value = true;
    errorMessage.value = '';

    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 600));

      // MOCK DATA - Replace with actual API call
      // GET /org/school/{schoolId}/students/unenrolled?academic_year_id={yearId}
      final mockStudents = _generateMockStudents(count: 25);

      // Filter out already enrolled students
      final enrolledIds = enrolledStudents.map((s) => s.id).toSet();
      final available = mockStudents
          .where((s) => !enrolledIds.contains(s.id))
          .toList();

      availableStudents.assignAll(available);
    } catch (e) {
      errorMessage.value = 'Failed to load available students: $e';
      _showError(errorMessage.value);
    } finally {
      isLoadingAvailable.value = false;
    }
  }

  /// Add selected students to the current section
  /// TODO: Replace with actual API call
  Future<void> addStudentsToSection() async {
    if (currentSection.value == null) {
      _showError('No section selected');
      return;
    }

    if (selectedStudents.isEmpty) {
      _showError('Please select at least one student');
      return;
    }

    // Check capacity
    final section = currentSection.value!;
    final availableCapacity = section.capacity - section.currentEnrollment;
    if (selectedStudents.length > availableCapacity) {
      _showError(
        'Cannot add ${selectedStudents.length} students. Only $availableCapacity spots available.',
      );
      return;
    }

    isAddingStudents.value = true;

    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 10000));

      // MOCK API CALL - Replace with actual implementation
      // POST /org/school/{schoolId}/sections/{sectionId}/enroll
      // Body: { "student_ids": ["uuid1", "uuid2", ...] }
      //
      // Expected Response:
      // {
      //   "success": true,
      //   "enrolled_count": 3,
      //   "section_id": "uuid",
      //   "message": "Students enrolled successfully"
      // }

      // Add to enrolled list
      enrolledStudents.addAll(selectedStudents);

      // Remove from available list
      availableStudents.removeWhere(
        (s) => selectedStudents.any((sel) => sel.id == s.id),
      );

      // Update section enrollment count (in real app, this would come from API)
      final updatedSection = Section(
        id: section.id,
        schoolId: section.schoolId,
        classroomId: section.classroomId,
        roomTeacherId: section.roomTeacherId,
        sectionName: section.sectionName,
        sectionCode: section.sectionCode,
        capacity: section.capacity,
        currentEnrollment: section.currentEnrollment + selectedStudents.length,
        createdAt: section.createdAt,
        updatedAt: DateTime.now(),
      );
      currentSection.value = updatedSection;

      _showSuccess(
        '${selectedStudents.length} student(s) enrolled successfully!',
      );

      // Clear selection
      selectedStudents.clear();
    } catch (e) {
      _showError('Failed to add students: $e');
    } finally {
      isAddingStudents.value = false;
    }
  }

  /// Remove a student from the section
  /// TODO: Replace with actual API call
  Future<void> removeStudentFromSection(Students student) async {
    if (currentSection.value == null) return;

    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        backgroundColor: TemarLijeColors.cardBackgroundColor,
        title: const Text('Remove Student'),
        content: Text(
          'Are you sure you want to remove "${student.fullName}" from this section?',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Get.back(result: true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Remove'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      isLoadingStudents.value = true;

      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 500));

      // MOCK API CALL - Replace with actual implementation
      // DELETE /org/school/{schoolId}/sections/{sectionId}/students/{studentId}

      enrolledStudents.removeWhere((s) => s.id == student.id);

      // Update section enrollment count
      final section = currentSection.value!;
      final updatedSection = Section(
        id: section.id,
        schoolId: section.schoolId,
        classroomId: section.classroomId,
        roomTeacherId: section.roomTeacherId,
        sectionName: section.sectionName,
        sectionCode: section.sectionCode,
        capacity: section.capacity,
        currentEnrollment: section.currentEnrollment - 1,
        createdAt: section.createdAt,
        updatedAt: DateTime.now(),
      );
      currentSection.value = updatedSection;

      _showSuccess('Student removed from section');
    } catch (e) {
      _showError('Failed to remove student: $e');
    } finally {
      isLoadingStudents.value = false;
    }
  }

  /// Toggle student selection for enrollment
  void toggleStudentSelection(Students student) {
    if (selectedStudents.any((s) => s.id == student.id)) {
      selectedStudents.removeWhere((s) => s.id == student.id);
    } else {
      selectedStudents.add(student);
    }
  }

  /// Check if student is selected
  bool isStudentSelected(Students student) {
    return selectedStudents.any((s) => s.id == student.id);
  }

  /// Clear selection
  void clearSelection() {
    selectedStudents.clear();
  }

  /// Select all available students
  void selectAllAvailable() {
    selectedStudents.assignAll(availableStudents);
  }

  /// Deselect all
  void deselectAll() {
    selectedStudents.clear();
  }

  // ============== MOCK DATA GENERATORS ==============

  List<Students> _generateMockStudents({required int count}) {
    final uuid = Uuid();
    final firstNames = [
      'Abebe',
      'Kebede',
      'Tesfaye',
      'Dawit',
      'Hanna',
      'Sara',
      'Meron',
      'Yohannes',
      'Bekele',
      'Tigist',
      'Selam',
      'Nardos',
      'Samuel',
      'Daniel',
      'Ruth',
      'Eden',
      'Liya',
      'Nahom',
      'Bereket',
      'Mikias',
      'Fikir',
      'Hawi',
      'Kalkidan',
      'Rediet',
      'Tsion',
    ];
    final middleNames = [
      'Girma',
      'Tadesse',
      'Alemu',
      'Hailu',
      'Mekonnen',
      'Assefa',
      'Bekele',
      'Wolde',
      'Desta',
      'Ayele',
      'Tesema',
      'Kassa',
      'Gebre',
      'Negash',
    ];
    final lastNames = [
      'Tesfaye',
      'Kebede',
      'Alemu',
      'Girma',
      'Haile',
      'Mengistu',
      'Assefa',
      'Woldemariam',
      'Tadesse',
      'Bekele',
      'Desta',
      'Ayele',
      'Kassa',
    ];
    final cities = ['Addis Ababa', 'Bahir Dar', 'Hawassa', 'Mekelle', 'Adama'];
    final subCities = ['Bole', 'Yeka', 'Kirkos', 'Arada', 'Gulele', 'Lideta'];
    final woredas = ['01', '02', '03', '04', '05', '06', '07', '08'];
    final kebeles = ['01', '02', '03', '04', '05'];

    return List.generate(count, (index) {
      final gender = index % 2 == 0 ? 'Male' : 'Female';
      final firstName = firstNames[index % firstNames.length];
      final middleName = middleNames[index % middleNames.length];
      final lastName = lastNames[index % lastNames.length];
      final birthYear = 2015 + (index % 5);
      final birthMonth = 1 + (index % 12);
      final birthDay = 1 + (index % 28);

      return Students(
        id: UuidValue.fromString(uuid.v4()),
        authUserId: UuidValue.fromString(uuid.v4()),
        firstName: firstName,
        middleName: middleName,
        lastName: lastName,
        dateOfBirth: DateTime(birthYear, birthMonth, birthDay),
        phoneNumber:
            '+2519${(10000000 + index * 111111).toString().substring(0, 8)}',
        gender: gender,
        addressInfo: AddressInfo(
          region: 'Addis Ababa',
          city: cities[index % cities.length],
          zone: subCities[index % subCities.length],
          kebeleNo:
              '${woredas[index % woredas.length]}/${kebeles[index % kebeles.length]}',
        ),
        createdAt: DateTime.now().subtract(Duration(days: 30 + index)),
        updatedAt: DateTime.now().subtract(Duration(days: index)),
      );
    });
  }

  // ============== HELPER METHODS ==============

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
