import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/features/administrator/subject/subject_controller.dart';
import 'package:ui_temarlije/features/administrator/subject/screens/widgets/subject_list.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';
import 'package:ui_temarlije/utils/constants/enums.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';
import 'package:uuid/uuid.dart';

class SubjectView extends StatelessWidget {
  const SubjectView({super.key});

  @override
  Widget build(BuildContext context) {
    final SubjectController controller = Get.put(SubjectController());

    return Obx(
      () => Column(
        children: [
          // Filters
          _buildFilters(controller),
          const SizedBox(height: TemarLijeSizes.spaceBtwItems),
          if (controller.isLoading.value) const LinearProgressIndicator(),

          SubjectList(
            subjects: controller.subjects,
            isLoading: controller.isLoading.value,
            onRefresh: controller.refreshSubjects,
            onDelete: (subject) => controller.handleDelete(subject),
            onEdit: controller.showEditForm,
          ),
          const SizedBox(height: TemarLijeSizes.spaceBtwItems),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              backgroundColor: TemarLijeColors.facebookBackgroundColor,
              onPressed: controller.showCreateForm,
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters(SubjectController controller) {
    return Card(
      elevation: 2,
      color: TemarLijeColors.cardBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Academic Year Filter
            Row(
              children: [
                const Text(
                  'Academic Year:',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Obx(
                    () => DropdownButtonFormField<UuidValue>(
                      initialValue: controller.selectedAcademicYearId.value,
                      hint: const Text('Select Academic Year'),
                      items: controller.availableAcademicYears.map((year) {
                        return DropdownMenuItem(
                          value: year.id,
                          child: Text(year.yearRange),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          controller.setAcademicYearFilter(value);
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Education Level Filter
            Row(
              children: [
                const Text(
                  'Education Level:',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Obx(
                    () => DropdownButtonFormField<EducationLevel?>(
                      initialValue: controller.selectedEducationLevel.value,
                      hint: const Text('All Levels'),
                      items: [
                        const DropdownMenuItem<EducationLevel?>(
                          value: null,
                          child: Text('All Levels'),
                        ),
                        ...EducationLevel.values.map((level) {
                          return DropdownMenuItem(
                            value: level,
                            child: Text(level.toString().split('.').last),
                          );
                        }),
                      ],
                      onChanged: (value) {
                        controller.setEducationLevelFilter(value);
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: controller.clearFilters,
                  tooltip: 'Clear Filters',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
