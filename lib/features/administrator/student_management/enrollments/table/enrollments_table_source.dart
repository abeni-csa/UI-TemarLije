import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/data/models/student_enrollment.dart';
import 'package:ui_temarlije/features/administrator/student_management/enrollments/enrollments_controller.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';

class EnrollmentsTableSource extends DataTableSource {
  final StudentEnrollmentsController controller =
      Get.find<StudentEnrollmentsController>();

  @override
  DataRow? getRow(int index) {
    if (index >= controller.filteredEnrollments.length) return null;
    final enrollment = controller.filteredEnrollments[index];

    return DataRow2(
      cells: [
        // Student Name
        DataCell(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                enrollment.studentName,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(
                enrollment.studentId.toString(),
                style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
        // Section
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
        // Classroom
        DataCell(Text(enrollment.classroomName)),
        // Grade Level
        DataCell(Text(enrollment.gradeLevel)),
        // Status
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: enrollment.enrollmentStatus.color.withOpacity(0.2),
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
        // Enrollment Date
        DataCell(
          Text(
            '${enrollment.enrollmentDate.day}/${enrollment.enrollmentDate.month}/${enrollment.enrollmentDate.year}',
          ),
        ),
        // Actions
        DataCell(
          Row(
            children: [
              // Transfer button
              if (enrollment.enrollmentStatus == EnrollmentStatus.Active)
                IconButton(
                  icon: Icon(Icons.swap_horiz, color: Colors.orange.shade700),
                  tooltip: 'Transfer',
                  onPressed: () => _showTransferDialog(enrollment),
                  constraints: const BoxConstraints(maxWidth: 30),
                  padding: EdgeInsets.zero,
                ),
              // Withdraw button
              if (enrollment.enrollmentStatus == EnrollmentStatus.Active)
                IconButton(
                  icon: Icon(Icons.exit_to_app, color: TemarLijeColors.error),
                  tooltip: 'Withdraw',
                  onPressed: () => _showWithdrawDialog(enrollment),
                  constraints: const BoxConstraints(maxWidth: 30),
                  padding: EdgeInsets.zero,
                ),
              // Delete button
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
  int get selectedRowCount => 0;

  void _showTransferDialog(StudentEnrollmentWithDetails enrollment) {
    // Show dialog to select new section
    Get.dialog(
      AlertDialog(
        title: const Text('Transfer Student'),
        content: const Text('Select new section for the student'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Get.back();
              // TODO: Implement section selection
              // controller.transferStudent(
              //   enrollmentId: enrollment.id,
              //   newSectionId: selectedSectionId,
              // );
            },
            child: const Text('Transfer'),
          ),
        ],
      ),
    );
  }

  void _showWithdrawDialog(StudentEnrollmentWithDetails enrollment) {
    Get.dialog(
      AlertDialog(
        title: const Text('Withdraw Student'),
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
        content: Text('Are you sure you want to delete this enrollment?'),
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
