import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/data/models/student_enrollment.dart';
import 'package:ui_temarlije/features/administrator/student_management/enrollments/enrollments_controller.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';

class EnrollmentsTableSource extends DataTableSource {
  final StudentEnrollmentsController controller =
      Get.find<StudentEnrollmentsController>();
  // Store selected row indices
  final Set<int> selectedIndices = {};

  // Flag to prevent multiple listeners
  bool _isListening = false;

  EnrollmentsTableSource() {
    _setupListeners();
  }

  void _setupListeners() {
    if (_isListening) return;
    _isListening = true;

    // Listen to filteredEnrollments changes
    ever(controller.filteredEnrollments, (_) {
      _refreshTable();
    });

    // Listen to isLoading changes to update UI
    ever(controller.isLoading, (_) {
      _refreshTable();
    });
  }

  void _refreshTable() {
    // Notify the table to rebuild
    notifyListeners();
  }

  @override
  DataRow? getRow(int index) {
    if (index >= controller.filteredEnrollments.length) return null;

    final enrollment = controller.filteredEnrollments[index];
    final isSelected = selectedIndices.contains(index);

    return DataRow2(
      selected: isSelected,
      onSelectChanged: (selected) {
        if (selected == true) {
          selectedIndices.add(index);
        } else {
          selectedIndices.remove(index);
        }
        notifyListeners();
      },
      cells: [
        DataCell(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                enrollment.studentName,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(
                enrollment.studentId.toString(),
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
        DataCell(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(enrollment.sectionName),
              Text(
                enrollment.sectionCode,
                style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
        DataCell(Text(enrollment.classroomName)),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: enrollment.enrollmentStatus.color.withAlpha(20),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              enrollment.enrollmentStatus.displayName,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: enrollment.enrollmentStatus.color,
              ),
            ),
          ),
        ),
        DataCell(
          Text(
            '${enrollment.enrollmentDate.day}/${enrollment.enrollmentDate.month}/${enrollment.enrollmentDate.year}',
          ),
        ),
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (enrollment.enrollmentStatus == EnrollmentStatus.Active)
                IconButton(
                  icon: Icon(Icons.swap_horiz, color: Colors.orange.shade700),
                  tooltip: 'Transfer',
                  onPressed: () => _showTransferDialog(enrollment),
                  constraints: const BoxConstraints(maxWidth: 30),
                  padding: EdgeInsets.zero,
                ),
              if (enrollment.enrollmentStatus == EnrollmentStatus.Active)
                IconButton(
                  icon: Icon(Icons.exit_to_app, color: TemarLijeColors.error),
                  tooltip: 'Withdraw',
                  onPressed: () => _showWithdrawDialog(enrollment),
                  constraints: const BoxConstraints(maxWidth: 30),
                  padding: EdgeInsets.zero,
                ),
              IconButton(
                icon: Icon(Icons.delete_outline, color: Colors.grey.shade700),
                tooltip: 'Delete',
                onPressed: () => _showDeleteDialog(enrollment),
                constraints: const BoxConstraints(maxWidth: 30),
                padding: EdgeInsets.zero,
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  int get rowCount => controller.filteredEnrollments.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => selectedIndices.length;

  // Get selected enrollments
  List<StudentEnrollmentWithDetails> getSelectedEnrollments() {
    return selectedIndices
        .where((index) => index < controller.filteredEnrollments.length)
        .map((index) => controller.filteredEnrollments[index])
        .toList();
  }

  // Clear selection
  void clearSelection() {
    selectedIndices.clear();
    notifyListeners();
  }

  // Batch actions
  Future<void> batchWithdraw() async {
    final selected = getSelectedEnrollments();
    if (selected.isEmpty) return;

    final confirm = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Batch Withdraw'),
        content: Text(
          'Are you sure you want to withdraw ${selected.length} student(s)?',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Withdraw All'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      for (final enrollment in selected) {
        await controller.withdrawStudent(
          enrollmentId: enrollment.id.toString(),
        );
      }

      Get.back(); // Close loading
      clearSelection();

      Get.snackbar(
        'Success',
        'Successfully withdrew ${selected.length} student(s)',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.back(); // Close loading
      Get.snackbar(
        'Error',
        'Failed to withdraw students: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> batchDelete() async {
    final selected = getSelectedEnrollments();
    if (selected.isEmpty) return;

    final confirm = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Batch Delete'),
        content: Text(
          'Are you sure you want to delete ${selected.length} enrollment(s)?',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete All'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      for (final enrollment in selected) {
        await controller.deleteEnrollment(
          enrollmentId: enrollment.id.toString(),
        );
      }

      Get.back(); // Close loading
      clearSelection();

      Get.snackbar(
        'Success',
        'Successfully deleted ${selected.length} enrollment(s)',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.back(); // Close loading
      Get.snackbar(
        'Error',
        'Failed to delete enrollments: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void _showTransferDialog(StudentEnrollmentWithDetails enrollment) {
    // Show dialog with section selection
    final controller = Get.find<StudentEnrollmentsController>();

    Get.dialog(
      AlertDialog(
        title: const Text('Transfer Student'),
        backgroundColor: TemarLijeColors.primaryBackground,

        content: SizedBox(
          width: 300,
          child: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Transfer ${enrollment.studentName} to:'),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: null,
                  hint: const Text('Select Section'),
                  isExpanded: true,
                  items: controller.availableSections
                      .where(
                        (s) =>
                            s.id.toString() != enrollment.sectionId.toString(),
                      )
                      .map((section) {
                        return DropdownMenuItem<String>(
                          value: section.id
                              .toString(), // Convert UuidValue to String
                          child: Text(section.sectionName),
                        );
                      })
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      Get.back();
                      controller.transferStudent(
                        enrollmentId: enrollment.id.toString(),
                        newSectionId: value, // value is already a String
                      );
                    }
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
        ],
      ),
    );
  }

  void _showWithdrawDialog(StudentEnrollmentWithDetails enrollment) {
    Get.dialog(
      AlertDialog(
        title: const Text('Withdraw Student'),
        backgroundColor: TemarLijeColors.primaryBackground,
        content: Text(
          'Are you sure you want to withdraw ${enrollment.studentName}?',
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Get.back();
              controller.withdrawStudent(
                enrollmentId: enrollment.id.toString(),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Withdraw'),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(StudentEnrollmentWithDetails enrollment) {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete Enrollment'),
        backgroundColor: TemarLijeColors.primaryBackground,
        content: Text(
          'Are you sure you want to delete the enrollment for ${enrollment.studentName}?',
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Get.back();
              controller.deleteEnrollment(
                enrollmentId: enrollment.id.toString(),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
