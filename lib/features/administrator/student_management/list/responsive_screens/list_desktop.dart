// lib/features/administrator/enrollments/responsive_screens/enrollments_desktop.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:ui_temarlije/common/widgets/containers/rounded_container.dart';
import 'package:ui_temarlije/features/administrator/student_management/enrollments/enrollments_controller.dart';
import 'package:ui_temarlije/features/administrator/student_management/list/widgets/enrollment_card.dart';
import 'package:ui_temarlije/features/administrator/student_management/list/widgets/enrollment_stats.dart';
import 'package:ui_temarlije/routes/routes.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class EnrollmentsDesktopScreen extends StatelessWidget {
  const EnrollmentsDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StudentEnrollmentsController>();

    return SingleChildScrollView(
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

          // Stats Cards
          Obx(
            () => EnrollmentStats(
              stats: controller.getStatistics(),
              isLoading: controller.isLoading.value,
            ),
          ),
          const SizedBox(height: TemarLijeSizes.spaceBtwSections),

          // Filters
          // const EnrollmentFilters(),
          const SizedBox(height: TemarLijeSizes.spaceBtwSections),

          // Grid of enrollments
          TemarLijeRoundedContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with count
                Padding(
                  padding: const EdgeInsets.all(TemarLijeSizes.md),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => Text(
                          '${controller.filteredEnrollments.length} Enrollments',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      if (controller.isLoading.value)
                        const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                    ],
                  ),
                ),
                const Divider(height: 0),

                Obx(() {
                  if (controller.isLoading.value &&
                      controller.enrollments.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(32),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (controller.errorMessage.value.isNotEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(32),
                      child: Center(
                        child: Text(
                          'Error: ${controller.errorMessage.value}',
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    );
                  }

                  if (controller.enrollments.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(32),
                      child: Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.people_outline,
                              size: 48,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'No enrollments found',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1.1,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                    itemCount: controller.enrollments.length,
                    itemBuilder: (context, index) {
                      final enrollment = controller.enrollments[index];
                      return EnrollmentCard(
                        enrollment: enrollment,
                        onTap: () {
                          Get.toNamed(
                            TemarLijeRoutes.studentEnrollmentDetails,
                            arguments: enrollment,
                          );
                        },
                      );
                    },
                  );
                }),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
