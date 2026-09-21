import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:ui_temarlije/common/widgets/containers/rounded_container.dart';
import 'package:ui_temarlije/data/models/student_enrollment.dart';
import 'package:ui_temarlije/features/administrator/student_management/enrollments/enrollments_controller.dart';
import 'package:ui_temarlije/features/administrator/student_management/enrollments/table/enrollments_data_table.dart';
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
                  // Enhanced Filter Header
                  Padding(
                    padding: const EdgeInsets.all(TemarLijeSizes.sm),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            // Academic Year Filter
                            Obx(
                              () => Expanded(
                                flex: 2,
                                child: DropdownButtonFormField<String>(
                                  initialValue:
                                      controller.selectedAcademicYearId.value,
                                  hint: const Text('Select Academic Year'),
                                  isExpanded: true,
                                  items: [
                                    const DropdownMenuItem(
                                      value: null,
                                      child: Text('All Years'),
                                    ),
                                    ...controller.availableAcademicYears.map((
                                      ay,
                                    ) {
                                      return DropdownMenuItem(
                                        value: ay.id.toString(),
                                        child: Text(ay.yearRange),
                                      );
                                    }),
                                  ],
                                  onChanged: (value) {
                                    controller.selectAcademicYear(value);
                                    controller.fetchEnrollments();
                                  },
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 4,
                                    ),
                                    isDense: true,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),

                            // Section Filter
                            Obx(
                              () => Expanded(
                                flex: 2,
                                child: DropdownButtonFormField<String>(
                                  initialValue:
                                      controller.selectedSectionId.value,
                                  hint: const Text('Select Section'),
                                  isExpanded: true,
                                  items: [
                                    const DropdownMenuItem(
                                      value: null,
                                      child: Text('All Sections'),
                                    ),
                                    ...controller.availableSections.map((
                                      section,
                                    ) {
                                      return DropdownMenuItem(
                                        value: section.id.toString(),
                                        child: Text(section.sectionName),
                                      );
                                    }),
                                  ],
                                  onChanged: (value) {
                                    controller.selectSection(value);
                                  },
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 4,
                                    ),
                                    isDense: true,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),

                            // Status Filter
                            Obx(
                              () => Expanded(
                                flex: 1,
                                child:
                                    DropdownButtonFormField<EnrollmentStatus>(
                                      initialValue:
                                          controller.filterStatus.value,
                                      hint: const Text('Status'),
                                      isExpanded: true,
                                      items: [
                                        const DropdownMenuItem(
                                          value: null,
                                          child: Text('All Status'),
                                        ),
                                        ...EnrollmentStatus.values.map((
                                          status,
                                        ) {
                                          return DropdownMenuItem(
                                            value: status,
                                            child: Text(status.displayName),
                                          );
                                        }),
                                      ],
                                      onChanged: (value) {
                                        controller.filterStatus.value = value;
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 4,
                                        ),
                                        isDense: true,
                                      ),
                                    ),
                              ),
                            ),
                            const SizedBox(width: 12),

                            // Clear Filters Button
                            IconButton(
                              onPressed: controller.clearFilters,
                              icon: const Icon(Icons.clear_all),
                              tooltip: 'Clear Filters',
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            // Search field
                            Expanded(
                              flex: 3,
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Search by name, ID, section...',
                                  prefixIcon: const Icon(Icons.search),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  isDense: true,
                                  suffixIcon: SizedBox(),
                                ),
                                onChanged: (value) {
                                  controller.searchQuery.value = value;
                                },
                              ),
                            ),
                            const SizedBox(width: 8),

                            // Refresh button
                            Obx(
                              () => IconButton(
                                onPressed: controller.isLoading.value
                                    ? null
                                    : controller.fetchEnrollments,
                                icon: controller.isLoading.value
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Icon(Icons.refresh),
                                tooltip: 'Refresh',
                              ),
                            ),
                          ],
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
          color: color.withAlpha(120),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withAlpha(30)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
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
