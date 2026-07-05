import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:ui_temarlije/common/widgets/containers/rounded_container.dart';
import 'package:ui_temarlije/features/administrator/teacher_management/enrollments/enrollments_controller.dart';
import 'package:ui_temarlije/features/administrator/teacher_management/enrollments/table/data_table.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class EnrollmentsTeacherDesktop extends StatelessWidget {
  const EnrollmentsTeacherDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EnrollmentsController>();

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(TemarLijeSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TemarLijeBreadcrumbsWithHeading(
              heading: 'Enrollment Requests',
              breadcrumbsItems: ['/enrollments', '/pending'],
              returnToPreviousScreen: true,
            ),
            SizedBox(height: TemarLijeSizes.sm),
            // Table Body
            TemarLijeRoundedContainer(
              child: Column(
                children: [
                  // Custom header with batch actions
                  Padding(
                    padding: const EdgeInsets.all(TemarLijeSizes.sm),
                    child: Obx(() {
                      final selectedCount = controller.selectedIds.length;
                      return Row(
                        children: [
                          // Left side - Checkbox for Select All
                          Row(
                            children: [
                              Checkbox(
                                value: controller.isAllSelected,
                                onChanged: (_) => controller.toggleSelectAll(),
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                              ),
                              Text(
                                selectedCount > 0
                                    ? '$selectedCount selected'
                                    : 'Select All',
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          const Spacer(),

                          // Batch actions (visible when items are selected)
                          if (selectedCount > 0) ...[
                            ElevatedButton.icon(
                              onPressed: () => controller.acceptSelected(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                              ),
                              icon: const Icon(Icons.check_circle, size: 18),
                              label: Text('Accept ($selectedCount)'),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton.icon(
                              onPressed: () => controller.rejectSelected(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                              ),
                              icon: const Icon(Icons.cancel, size: 18),
                              label: Text('Reject ($selectedCount)'),
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              onPressed: () => controller.selectedIds.clear(),
                              icon: const Icon(Icons.clear),
                              tooltip: 'Clear Selection',
                            ),
                          ] else ...[
                            ElevatedButton.icon(
                              // onPressed: controller.fetchPendingRequests,
                              onPressed: controller.loadSchoolId,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: TemarLijeColors.primary,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                              ),
                              icon: const Icon(Icons.refresh, size: 18),
                              label: const Text('Refresh'),
                            ),
                          ],
                        ],
                      );
                    }),
                  ),
                  const SizedBox(height: 8),

                  // Data Table
                  const TeachersEnrollmentDataTable(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
