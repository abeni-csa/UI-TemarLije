import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/features/administrator/teacher_management/enrollments/enrollments_controller.dart';
import 'package:ui_temarlije/features/administrator/teacher_management/enrollments/table/data_table.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class EnrollmentsTeacherTablet extends StatelessWidget {
  const EnrollmentsTeacherTablet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EnrollmentsController>();

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(TemarLijeSizes.spaceBtwItems),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Enrollment Requests',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: controller.fetchPendingRequests,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TemarLijeColors.primary,
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Refresh'),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Batch actions toolbar
            Obx(() {
              final selectedCount = controller.selectedIds.length;
              if (selectedCount > 0) {
                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Text(
                        '$selectedCount selected',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      ElevatedButton.icon(
                        onPressed: () => controller.acceptSelected(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        icon: const Icon(Icons.check_circle),
                        label: const Text('Accept All'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton.icon(
                        onPressed: () => controller.rejectSelected(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                        icon: const Icon(Icons.cancel),
                        label: const Text('Reject All'),
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: () => controller.selectedIds.clear(),
                        child: const Text('Clear'),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            }),

            const SizedBox(height: 16),
            const TeachersEnrollmentDataTable(),
          ],
        ),
      ),
    );
  }
}
