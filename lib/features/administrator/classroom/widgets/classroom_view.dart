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
            _buildEmptyState(controller)
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

  Widget _buildClassroomList(ClassroomController controller) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),

      children: [
        for (final entry in controller.groupedClassrooms.entries)
          GradeLevelGroup(gradeLevel: entry.key, classrooms: entry.value),
        if (controller.selectedClassroom.value != null)
          SectionView(classroom: controller.selectedClassroom.value!),
      ],
    );
  }

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
