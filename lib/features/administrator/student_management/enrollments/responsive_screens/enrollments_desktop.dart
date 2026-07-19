import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:ui_temarlije/common/widgets/containers/rounded_container.dart';
import 'package:ui_temarlije/common/widgets/data_table/table_header.dart';
import 'package:ui_temarlije/data/models/student_enrollment.dart';
import 'package:ui_temarlije/features/administrator/student_management/enrollments/enrollments_controller.dart';
import 'package:ui_temarlije/features/administrator/student_management/enrollments/table/enrollments_data_table.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class EnrollmentsDesktopScreen extends StatelessWidget {
  const EnrollmentsDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StudentEnrollmentsController>();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(TemarLijeSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TemarLijeBreadcrumbsWithHeading(
              heading: 'Student Enrollments',
              breadcrumbsItems: ['/enrollments'],
              returnToPreviousScreen: false,
            ),
            const SizedBox(height: TemarLijeSizes.spaceBtwSections),

            // Summary Cards
            Obx(() {
              final stats = controller.getStatistics();
              return Row(
                children: [
                  _buildSummaryCard(
                    context,
                    title: 'Total',
                    value: stats['total'].toString(),
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 16),
                  _buildSummaryCard(
                    context,
                    title: 'Active',
                    value: stats['active'].toString(),
                    color: Colors.green,
                  ),
                  const SizedBox(width: 16),
                  _buildSummaryCard(
                    context,
                    title: 'Withdrawn',
                    value: stats['withdrawn'].toString(),
                    color: Colors.red,
                  ),
                  const SizedBox(width: 16),
                  _buildSummaryCard(
                    context,
                    title: 'Transferred',
                    value: stats['transferred'].toString(),
                    color: Colors.orange,
                  ),
                ],
              );
            }),
            const SizedBox(height: TemarLijeSizes.spaceBtwSections),

            // Table Body
            TemarLijeRoundedContainer(
              child: Column(
                children: [
                  // Filter Header
                  Padding(
                    padding: const EdgeInsets.all(TemarLijeSizes.sm),
                    child: Row(
                      children: [
                        // Status filter dropdown
                        Obx(
                          () => DropdownButton<EnrollmentStatus>(
                            value: controller.filterStatus.value,
                            hint: const Text('All Status'),
                            items: [
                              const DropdownMenuItem(
                                value: null,
                                child: Text('All Status'),
                              ),
                              ...EnrollmentStatus.values.map((status) {
                                return DropdownMenuItem(
                                  value: status,
                                  child: Text(status.displayName),
                                );
                              }),
                            ],
                            onChanged: (value) {
                              controller.filterStatus.value = value;
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Search field
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search by name, section...',
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              isDense: true,
                            ),
                            onChanged: (value) {
                              controller.searchQuery.value = value;
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Refresh button
                        IconButton(
                          onPressed: controller.fetchEnrollments,
                          icon: const Icon(Icons.refresh),
                          tooltip: 'Refresh',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Data Table
                  const EnrollmentsDataTable(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(
    BuildContext context, {
    required String title,
    required String value,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.labelSmall),
            const SizedBox(height: 4),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
