import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/data/models/classroom.dart';
import 'package:ui_temarlije/features/administrator/classroom/classroom_controller.dart';
import 'package:ui_temarlije/features/administrator/classroom/widgets/classroom_card.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class GradeLevelGroup extends StatelessWidget {
  final GradeLevel gradeLevel;
  final List<Classroom> classrooms;

  const GradeLevelGroup({
    super.key,
    required this.gradeLevel,
    required this.classrooms,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ClassroomController>();
    final color = controller.gradeColors[gradeLevel] ?? TemarLijeColors.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: 24,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              _getGradeLevelDisplay(gradeLevel),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: color.withAlpha(10),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                '${classrooms.length}',
                style: TextStyle(
                  fontSize: 12,
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Spacer(),
            if (!controller.hasClassroomsForLevel(gradeLevel))
              _buildGenerateButton(context, color),
            Obx(
              () => ElevatedButton(
                onPressed: controller.isLoading.value
                    ? null
                    : () => Get.dialog(
                        AlertDialog(
                          content: _buildEmptyStateListScoolType(controller),
                        ),
                      ),

                style: ElevatedButton.styleFrom(
                  backgroundColor: TemarLijeColors.accent,
                  padding: const EdgeInsets.symmetric(
                    vertical: TemarLijeSizes.borderRadiusLg,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: controller.isLoading.value
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text('Create Grades'),
              ),
            ),
            const SizedBox(width: 8),

            Obx(
              () => ElevatedButton(
                onPressed: controller.isLoading.value
                    ? null
                    : () {
                        _showBulkSections();
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: TemarLijeColors.present,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: controller.isLoading.value
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text('Create Sections'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (classrooms.isEmpty)
          _buildEmptyState(context, color)
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: classrooms.length,
            itemBuilder: (context, index) {
              final classroom = classrooms[index];
              return ClassroomCard(
                classroom: classroom,
                onTap: () => controller.selectClassroom(classroom),
                onDelete: () => _showDeleteConfirmation(context, classroom),
              );
            },
          ),
        const SizedBox(height: TemarLijeSizes.spaceBtwItems),
      ],
    );
  }

  Widget _buildGenerateButton(BuildContext context, Color color) {
    return InkWell(
      onTap: () {
        final controller = Get.find<ClassroomController>();
        controller.showGenerateDialog(gradeLevel);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add, color: Colors.white, size: 16),
            SizedBox(width: 4),
            Text(
              'Generate',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyStateListScoolType(ClassroomController controller) {
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

  Widget _buildEmptyState(BuildContext context, Color color) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: color.withAlpha(500),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withAlpha(20)),
      ),
      child: Column(
        children: [
          Icon(
            Icons.add_comment_outlined,
            size: 40,
            color: color.withAlpha(50),
          ),
          const SizedBox(height: 8),
          Text(
            'No classrooms created yet',
            style: TextStyle(
              color: color.withAlpha(70),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Tap Generate to create classrooms for this level',
            style: TextStyle(fontSize: 12, color: color.withAlpha(50)),
          ),
          const SizedBox(height: 12),
          _buildGenerateButton(context, color),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, Classroom classroom) {
    Get.dialog(
      AlertDialog(
        backgroundColor: TemarLijeColors.cardBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Delete ${classroom.gradeDisplay}?'),
        content: Text(
          'This will permanently delete this classroom and all its sections. This action cannot be undone.',
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Get.back();
              _deleteClassroom(classroom);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: TemarLijeColors.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showBulkSections() {
    final controller = Get.put(ClassroomController());

    Get.dialog(
      AlertDialog(
        backgroundColor: TemarLijeColors.cardBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Create Sections'),
        content: Obx(
          () => Container(
            width: 400,
            constraints: const BoxConstraints(maxHeight: 500),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Classroom info
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox.shrink(),
                        Text(
                          'Classroom: ${controller.schoolId}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        // const SizedBox(height: 4),
                        // Text(
                        //   'Grade Level: ${controller.selectedClassroom.value?.gradeLevel.toString().split('.').last ?? ''}',
                        //   style: TextStyle(
                        //     fontSize: 12,
                        //     color: Colors.grey.shade600,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Number of sections
                  const Text(
                    'Number of Sections',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          int current =
                              int.tryParse(
                                controller.sectionsPerClassroomController.text,
                              ) ??
                              1;
                          if (current > 1) {
                            controller.sectionsPerClassroomController.text =
                                (current - 1).toString();
                            controller.sectionsPerClassroom.value = current - 1;
                          }
                        },
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: controller.sectionsPerClassroomController,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(horizontal: 8),
                          ),
                          onChanged: (value) {
                            int val = int.tryParse(value) ?? 1;
                            if (val < 1) {
                              controller.sectionsPerClassroomController.text =
                                  '1';
                              val = 1;
                            }
                            controller.sectionsPerClassroom.value = val;
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          int current =
                              int.tryParse(
                                controller.sectionsPerClassroomController.text,
                              ) ??
                              1;
                          if (current < 20) {
                            controller.sectionsPerClassroomController.text =
                                (current + 1).toString();
                            controller.sectionsPerClassroom.value = current + 1;
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Naming Pattern
                  const Text(
                    'Naming Pattern',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller.namingPrefixController,
                          decoration: const InputDecoration(
                            labelText: 'Prefix',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                          onChanged: (value) =>
                              controller.namingPrefix.value = value,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextFormField(
                          controller: controller.startIndexController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Start Index',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                          onChanged: (value) {
                            int val = int.tryParse(value) ?? 1;
                            controller.startIndex.value = val;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: controller.namingSuffixController,
                    decoration: const InputDecoration(
                      labelText: 'Suffix (optional)',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    onChanged: (value) => controller.namingSuffix.value = value,
                  ),
                  const SizedBox(height: 16),

                  // Example preview
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Preview:',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _getSectionNamePreview(controller),
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Default Capacity
                  const Text(
                    'Default Capacity',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: controller.defaultCapacityController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    onChanged: (value) {
                      int val = int.tryParse(value) ?? 45;
                      if (val < 1) {
                        controller.defaultCapacityController.text = '1';
                        val = 1;
                      }
                      controller.defaultCapacity.value = val;
                    },
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          Obx(
            () => ElevatedButton(
              onPressed: controller.isLoading.value
                  ? null
                  : () async {
                      if (controller.selectedClassroom.value != null) {
                        await controller.createBulkSections();
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: TemarLijeColors.primary,
              ),
              child: controller.isLoading.value
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text('Create'),
            ),
          ),
        ],
      ),
    );
  }

  String _getSectionNamePreview(ClassroomController controller) {
    final prefix = controller.namingPrefixController.text;
    final start = int.tryParse(controller.startIndexController.text) ?? 1;
    final suffix = controller.namingSuffixController.text;
    final count =
        int.tryParse(controller.sectionsPerClassroomController.text) ?? 1;

    List<String> examples = [];
    for (int i = 0; i < count && i < 3; i++) {
      String name = '$prefix${start + i}';
      if (suffix.isNotEmpty) {
        name += ' $suffix';
      }
      examples.add(name);
    }

    return examples.join(', ') + (count > 3 ? ', ...' : '');
  }

  void _deleteClassroom(Classroom classroom) async {
    final controller = Get.find<ClassroomController>();
    try {
      // Add deletion logic here
      // await controller.deleteClassroom(classroom.id);
      Get.snackbar(
        'Deleted',
        '${classroom.gradeDisplay} deleted successfully',
        backgroundColor: TemarLijeColors.success,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to delete classroom',
        backgroundColor: TemarLijeColors.error,
        colorText: Colors.white,
      );
    }
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
