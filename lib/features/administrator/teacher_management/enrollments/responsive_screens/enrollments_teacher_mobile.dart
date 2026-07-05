import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/features/administrator/teacher_management/enrollments/enrollments_controller.dart';
import 'package:ui_temarlije/features/administrator/teacher_management/enrollments/table/data_table.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class EnrollmentsTeacherMobile extends StatelessWidget {
  const EnrollmentsTeacherMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EnrollmentsController>();

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(TemarLijeSizes.mobileSpace),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Enrollment Requests',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  onPressed: controller.fetchPendingRequests,
                  icon: const Icon(Icons.refresh),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Batch actions for mobile (simplified)
            Obx(() {
              final selectedCount = controller.selectedIds.length;
              if (selectedCount > 0) {
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => controller.acceptSelected(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
                          icon: const Icon(Icons.check_circle),
                          label: Text('Accept ($selectedCount)'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => controller.rejectSelected(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                          ),
                          icon: const Icon(Icons.cancel),
                          label: Text('Reject ($selectedCount)'),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            }),

            const SizedBox(height: 8),
            const TeachersEnrollmentDataTable(),
          ],
        ),
      ),
    );
  }
}
