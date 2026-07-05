import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/data/models/membeship.dart';
import 'package:ui_temarlije/features/administrator/teacher_management/enrollments/enrollments_controller.dart';

class TeachersEnrollmentDataTableSource extends DataTableSource {
  final EnrollmentsController controller = Get.find<EnrollmentsController>();

  @override
  DataRow? getRow(int index) {
    if (index >= controller.pendingRequests.length) return null;
    final request = controller.pendingRequests[index];
    final isSelected = controller.selectedIds.contains(request.id);

    return DataRow2(
      selected: isSelected,
      onSelectChanged: (selected) {
        controller.toggleSelection(request.id);
      },
      cells: [
        // // 1. ID
        // DataCell(
        //   Text(
        //     '${request.id}',
        //     style: const TextStyle(fontWeight: FontWeight.w500),
        //   ),
        // ),

        // // 2. School ID
        // DataCell(
        //   Text(
        //     request.schoolId.toString().substring(0, 8),
        //     style: const TextStyle(fontWeight: FontWeight.w500),
        //   ),
        // ),

        // 3. Base User ID
        DataCell(
          Text(
            request.userId.toString().substring(0, 8),
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),

        // 4. Academic Year ID
        // DataCell(
        //   Text(
        //     request.joinedAcademicYearId?.toString().substring(0, 8) ?? 'N/A',
        //     style: const TextStyle(fontWeight: FontWeight.w500),
        //   ),
        // ),

        // 5. Membership Type
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _getMembershipTypeColor(request.membershipType),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              request.membershipType.displayName,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),

        // 6. Status
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: request.status.color,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              request.status.displayName,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),

        // 7. Actions
        DataCell(
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.check_circle, color: Colors.green),
                tooltip: 'Accept',
                onPressed: () => controller.acceptSingleRequest(request),
                constraints: const BoxConstraints(maxWidth: 30),
                padding: EdgeInsets.zero,
              ),
              IconButton(
                icon: const Icon(Icons.cancel, color: Colors.red),
                tooltip: 'Reject',
                onPressed: () => controller.rejectSingleRequest(request),
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
  int get rowCount => controller.pendingRequests.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => controller.selectedIds.length;

  // Helper methods
  Color _getMembershipTypeColor(UserType type) {
    switch (type) {
      case UserType.student:
        return Colors.blue;
      case UserType.teacher:
        return Colors.orange;
      case UserType.staff:
        return Colors.purple;
    }
  }
}
