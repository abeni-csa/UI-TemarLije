import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/features/administrator/academic_year/academic_year_controller.dart';
import 'package:ui_temarlije/features/administrator/academic_year/screens/widgets/academic_year_list.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class AcademicYearView extends StatelessWidget {
  const AcademicYearView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AcademicYearController>();

    return Obx(
      () => Column(
        children: [
          // School Selector

          // Error message if any
          if (controller.error.isNotEmpty && controller.schoolId == null)
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(
                bottom: TemarLijeSizes.gridViewSpacing,
              ),
              decoration: BoxDecoration(
                color: TemarLijeColors.error.withAlpha(100),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: TemarLijeColors.error.withAlpha(300)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.error_outline,
                    color: TemarLijeColors.error,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      controller.error.value,
                      style: TextStyle(
                        color: TemarLijeColors.error,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // Show academic years only if a school is selected
          if (controller.schoolId != null) ...[
            if (controller.isLoading.value) const LinearProgressIndicator(),
            AcademicYearList(
              academicYears: controller.academicYears,
              currentAcademicYear: controller.currentAcademicYear.value,
              isLoading: controller.isLoading.value,
              onRefresh: controller.refreshAcademicYears,
              onDelete: (academicYear) => controller.handleDelete(academicYear),
              onEdit: (academicYear) => controller.showEditForm(academicYear),
            ),
            const SizedBox(height: TemarLijeSizes.spaceBtwItems),
            Align(
              alignment: Alignment.centerRight,
              child: FloatingActionButton(
                backgroundColor: TemarLijeColors.primary,
                onPressed: controller.showCreateForm,
                mini: true,
                child: const Icon(Icons.add, color: Colors.white),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
