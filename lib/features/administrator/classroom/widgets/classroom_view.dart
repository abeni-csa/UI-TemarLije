import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/common/widgets/containers/rounded_container.dart';
import 'package:ui_temarlije/data/models/classroom.dart';
import 'package:ui_temarlije/features/administrator/classroom/classroom_controller.dart';
import 'package:ui_temarlije/features/administrator/classroom/widgets/grade_level_group.dart';
import 'package:ui_temarlije/features/administrator/classroom/widgets/section_view.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class ClassroomView extends StatelessWidget {
  const ClassroomView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ClassroomController>();

    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          _buildHeader(controller),

          const SizedBox(height: TemarLijeSizes.spaceBtwItems),

          // Error message
          if (controller.error.isNotEmpty) _buildErrorWidget(controller),

          // Loading indicator
          if (controller.isLoading.value) const LinearProgressIndicator(),

          // Content
          if (controller.schoolId == null)
            _buildNoSchoolWidget()
          else if (controller.currentAcademicYear == null)
            _buildNoAcademicYearWidget()
          else if (controller.classrooms.isEmpty && !controller.isLoading.value)
            // _buildEmptyState(controller),
            _buildGenerateAllButton(controller)
          else
            _buildClassroomList(controller),
        ],
      ),
    );
  }

  Widget _buildHeader(ClassroomController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Classrooms',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              '${controller.classrooms.length} classrooms total',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            ),
          ],
        ),
        if (controller.currentAcademicYear != null)
          TemarLijeRoundedContainer(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.calendar_today,
                  size: 14,
                  color: TemarLijeColors.primary,
                ),
                const SizedBox(width: 4),
                Text(
                  controller.currentAcademicYear!.yearRange,
                  style: const TextStyle(
                    color: TemarLijeColors.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                IconButton(
                  icon: Icon(
                    Icons.refresh,
                    color: TemarLijeColors.present,
                    size: 20,
                  ),
                  onPressed: controller.loadClassrooms,
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildErrorWidget(ClassroomController controller) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: TemarLijeSizes.spaceBtwItems),
      decoration: BoxDecoration(
        color: TemarLijeColors.error.withAlpha(10),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: TemarLijeColors.error.withAlpha(30)),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: TemarLijeColors.error, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              controller.error.value,
              style: TextStyle(color: TemarLijeColors.error, fontSize: 14),
            ),
          ),
          IconButton(
            icon: Icon(Icons.refresh, color: TemarLijeColors.error, size: 20),
            onPressed: controller.loadClassrooms,
          ),
        ],
      ),
    );
  }

  Widget _buildNoSchoolWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.business_outlined, size: 64, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            'No School Selected',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Please select a school to view classrooms',
            style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildNoAcademicYearWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.calendar_today_outlined,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'No Academic Year Selected',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Please create or select an academic year',
            style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(ClassroomController controller) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.class_outlined, size: 64, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            'No Classrooms Yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Generate classrooms for different grade levels',
            style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 8,
            children: GradeLevel.values.map((level) {
              final color =
                  controller.gradeColors[level] ?? TemarLijeColors.primary;
              return ElevatedButton(
                onPressed: () => controller.showGenerateDialog(level),
                style: ElevatedButton.styleFrom(
                  backgroundColor: color.withAlpha(100),
                  foregroundColor: color,
                ),
                child: Text(_getGradeLevelDisplay(level)),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // Replace the _buildClassroomList method in classroom_view.dart

  Widget _buildClassroomList(ClassroomController controller) {
    // Get all grade levels
    final allLevels = GradeLevel.values;

    // Get levels that have classrooms
    // final existingLevels = controller.groupedClassrooms.keys.toSet();

    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        // Show "Generate All" button at the top if no classrooms exist
        if (controller.classrooms.isEmpty && !controller.isLoading.value)
          _buildGenerateAllButton(controller),

        // Show all grade levels, even those without classrooms
        for (final level in allLevels)
          GradeLevelGroup(
            gradeLevel: level,
            classrooms: controller.groupedClassrooms[level] ?? [],
          ),

        // Show selected classroom sections if any
        if (controller.selectedClassroom.value != null)
          SectionView(classroom: controller.selectedClassroom.value!),
      ],
    );
  }

  // Add this method to classroom_view.dart
  Widget _buildGenerateAllButton(ClassroomController controller) {
    return Obx(
      () => Container(
        margin: const EdgeInsets.only(bottom: TemarLijeSizes.spaceBtwItems),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: TemarLijeColors.primary.withAlpha(30)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha(15),
              spreadRadius: 2,
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          children: [
            const Icon(
              Icons.school_outlined,
              size: 48,
              color: TemarLijeColors.primary,
            ),
            const SizedBox(height: 12),
            const Text(
              'No Classrooms Found',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Icon(Icons.class_outlined, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              'No Classrooms Yet',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Generate classrooms for all grade levels at once',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            ),
            const SizedBox(height: 16),
            // Generate All button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed:
                    controller.isGeneratingAll.value ||
                        controller.isLoading.value
                    ? null
                    : () => _showGenerateAllDialog(controller),
                style: OutlinedButton.styleFrom(
                  foregroundColor: TemarLijeColors.accent.withAlpha(2),
                  side: BorderSide(color: TemarLijeColors.accent),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                icon: controller.isGeneratingAll.value
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: TemarLijeColors.accent,
                        ),
                      )
                    : const Icon(Icons.add_circle_outline, color: Colors.white),
                label: controller.isGeneratingAll.value
                    ? const Text(
                        'Generating...',
                        style: TextStyle(color: TemarLijeColors.accent),
                      )
                    : const Text(
                        'Generate All Classrooms',
                        style: TextStyle(color: TemarLijeColors.accent),
                      ),
              ),
            ),
            const SizedBox(height: 8),
            // Individual level generation buttons
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: GradeLevel.values.map((level) {
                final color =
                    controller.gradeColors[level] ?? TemarLijeColors.primary;
                final hasClassrooms = controller.hasClassroomsForLevel(level);
                return OutlinedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : () => controller.showGenerateDialog(level),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: color,
                    side: BorderSide(color: color),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (hasClassrooms)
                        const Icon(Icons.check_circle, size: 14),
                      if (hasClassrooms) const SizedBox(width: 4),
                      Text(_getGradeLevelDisplay(level)),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  // Add this method to classroom_view.dart
  void _showGenerateAllDialog(ClassroomController controller) {
    Get.dialog(
      AlertDialog(
        backgroundColor: TemarLijeColors.cardBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Generate All Classrooms'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'This will create classrooms for all grade levels:',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: GradeLevel.values.map((level) {
                final color =
                    controller.gradeColors[level] ?? TemarLijeColors.primary;
                return Chip(
                  label: Text(_getGradeLevelDisplay(level)),
                  backgroundColor: color.withAlpha(35),
                  labelStyle: TextStyle(color: color),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: TemarLijeColors.warning.withAlpha(20),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: TemarLijeColors.warning.withAlpha(30),
                ),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: TemarLijeColors.warning,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Each classroom will have a capacity of 45 students. This may take a few moments.',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(Get.context!),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(Get.context!);
              controller.generateAllClassrooms();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: TemarLijeColors.primary,
            ),
            child: const Text('Generate All'),
          ),
        ],
      ),
    );
  }
  // Widget _buildClassroomList(ClassroomController controller) {
  //   return ListView(
  //     shrinkWrap: true,
  //     physics: const NeverScrollableScrollPhysics(),

  //     children: [
  //       for (final entry in controller.groupedClassrooms.entries)
  //         GradeLevelGroup(gradeLevel: entry.key, classrooms: entry.value),
  //       if (controller.selectedClassroom.value != null)
  //         SectionView(classroom: controller.selectedClassroom.value!),
  //     ],
  //   );
  // }

  String _getGradeLevelDisplay(GradeLevel level) {
    switch (level) {
      case GradeLevel.kindergarten:
        return 'Kindergarten';
      case GradeLevel.primary:
        return 'Primary';
      case GradeLevel.secondary:
        return 'Secondary';
      case GradeLevel.highSchool:
        return 'High School';
      case GradeLevel.preparatory:
        return 'Preparatory';
    }
  }
}
