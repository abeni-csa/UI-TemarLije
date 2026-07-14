import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/common/widgets/data_table/table_action.dart';
import 'package:ui_temarlije/data/models/classroom.dart';
import 'package:ui_temarlije/data/models/section.dart';
import 'package:ui_temarlije/features/administrator/classroom/classroom_controller.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';

class SectionView extends StatelessWidget {
  final Classroom classroom;

  const SectionView({super.key, required this.classroom});

  @override
  Widget build(BuildContext context) {
    final classroomController = Get.find<ClassroomController>();

    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(15),
            spreadRadius: 2,
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.view_list, color: classroom.color, size: 20),
              const SizedBox(width: 8),
              Text(
                'Sections - ${classroom.gradeDisplay}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.close, size: 20),
                onPressed: () =>
                    classroomController.selectedClassroom.value = null,
              ),
            ],
          ),
          const SizedBox(height: 12),
          FutureBuilder<List<Section>>(
            future: classroomController.getSectionsForClassroom(classroom.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error loading sections',
                    style: TextStyle(color: TemarLijeColors.error),
                  ),
                );
              }

              final sections = snapshot.data ?? [];

              if (sections.isEmpty) {
                return _buildEmptySectionWidget();
              }

              return _buildSectionList(sections);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEmptySectionWidget() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Icon(Icons.school_outlined, size: 48, color: Colors.grey.shade400),
            const SizedBox(height: 8),
            Text(
              'No sections created yet',
              style: TextStyle(
                color: Colors.grey.shade500,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Create sections for this classroom',
              style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                // Show dialog to create sections
                _showCreateSectionDialog();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: TemarLijeColors.primary,
              ),
              child: const Text('Create Sections'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionList(List<Section> sections) {
    return Column(
      children: [
        // Section header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Row(
            children: [
              Expanded(flex: 2, child: Text('Section Name')),
              Expanded(flex: 1, child: Text('Code')),
              Expanded(flex: 1, child: Text('Capacity')),
              Expanded(flex: 1, child: Text('Enrolled')),
              Expanded(flex: 1, child: Text('Status')),
              Spacer(),

              Expanded(flex: 1, child: Text('Action')),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // Section items
        ...sections.map((section) => _buildSectionItem(section)),
      ],
    );
  }

  Widget _buildSectionItem(Section section) {
    final isFull = section.currentEnrollment >= section.capacity;
    final occupancy = section.occupancyRate;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              section.sectionName,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: TemarLijeColors.primary.withAlpha(10),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                section.sectionCode,
                style: TextStyle(
                  color: TemarLijeColors.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '${section.capacity}',
              style: const TextStyle(fontSize: 13),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '${section.currentEnrollment}',
              style: TextStyle(
                fontSize: 13,
                color: isFull ? TemarLijeColors.error : Colors.green,
              ),
            ),
          ),
          Expanded(flex: 1, child: _buildStatusChip(isFull, occupancy)),
          Spacer(),
          Expanded(
            flex: 1,
            child: TemarLijeTableActionButtons(
              edit: true,
              view: true,
              delete: false,
              onEditPressed: () => {},
              onViewPressed: () =>
                  {}, //Get.toNamed(TemarLijeRoutes.teacherDetails),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(bool isFull, double occupancy) {
    Color color;
    String label;
    if (isFull) {
      color = TemarLijeColors.error;
      label = 'Full';
    } else if (occupancy > 0.8) {
      color = TemarLijeColors.warning;
      label = 'Almost Full';
    } else if (occupancy > 0) {
      color = Colors.green;
      label = 'Active';
    } else {
      color = Colors.grey;
      label = 'Empty';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withAlpha(100),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  void _showCreateBulkSectionDialog() {
    // Implement section creation dialog
    final classroomController = Get.find<ClassroomController>();

    Get.dialog(
      AlertDialog(
        backgroundColor: TemarLijeColors.cardBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Create Sections'),
        content: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Number of sections to create:'),
              const SizedBox(height: 8),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () => classroomController.numberOfSection - 1,
                  ),
                  Text('${classroomController.numberOfSection.value}'),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => classroomController.numberOfSection + 1,
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () => Get.back(),
            style: ElevatedButton.styleFrom(
              backgroundColor: TemarLijeColors.primary,
            ),
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _showCreateSectionDialog() {
    // Implement section creation dialog
    final classroomController = Get.find<ClassroomController>();

    Get.dialog(
      AlertDialog(
        backgroundColor: TemarLijeColors.cardBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Create Sections'),
        content: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Number of sections to create:'),
              const SizedBox(height: 8),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () => classroomController.numberOfSection - 1,
                  ),
                  Text('${classroomController.numberOfSection.value}'),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => classroomController.numberOfSection + 1,
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () => Get.back(),
            style: ElevatedButton.styleFrom(
              backgroundColor: TemarLijeColors.primary,
            ),
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }
}
