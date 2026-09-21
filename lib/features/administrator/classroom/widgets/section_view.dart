import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/common/widgets/data_table/table_action.dart';
import 'package:ui_temarlije/data/models/classroom.dart';
import 'package:ui_temarlije/data/models/section.dart';
import 'package:ui_temarlije/features/administrator/classroom/classroom_controller.dart';
import 'package:ui_temarlije/features/administrator/section_management/section_management.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';
import 'package:ui_temarlije/utils/validators/validation.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

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
              OutlinedButton(
                onPressed: () => {_showCreateSectionDialog()},
                style: OutlinedButton.styleFrom(
                  foregroundColor: TemarLijeColors.googleForegroundColor,
                  side: BorderSide(
                    color: TemarLijeColors.facebookBackgroundColor,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Add Section'),
              ),
              IconButton(
                icon: Icon(
                  Icons.refresh,
                  color: TemarLijeColors.present,
                  size: 20,
                ),
                // onPressed: () =>
                //     classroomController.loadSectionsForClassroom(classroom.id),
                onPressed: classroomController.loadClassrooms,
              ),
              IconButton(
                icon: const Icon(Icons.close, size: 20),
                onPressed: () => {
                  classroomController.selectedClassroom.value = null,
                  // _showCreateSectionDialog(),
                },
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
                // _showCreateSectionDialog();
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
        const SizedBox(height: TemarLijeSizes.spaceBtwItems),
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
                  Get.to(() => SectionManagement(section: section)),
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

  void _showCreateSectionDialog() {
    final controller = Get.find<ClassroomController>();
    // Reset the form
    controller.sectionNameController.clear();
    controller.capacityController.text = '45';
    controller.roomTeacherIdController.clear();

    Get.dialog(
      AlertDialog(
        backgroundColor: TemarLijeColors.cardBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Create Section'),
        content: SizedBox(
          width: 400,
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: controller.sectionNameController,
                  decoration: const InputDecoration(
                    labelText: 'Section Name *',
                    hintText: 'e.g., Section A, Class 1A',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                  validator: (value) {
                    TemarLijeValidator.validateEmptyText("Section name", value);
                    if (value == null || value.trim().length < 2) {
                      return 'Section name must be at least 2 characters';
                    }
                    if (value.trim().length > 50) {
                      return 'Section name must be less than 50 characters';
                    }
                    // Only allow letters, numbers, and spaces
                    if (!RegExp(r'^[a-zA-Z0-9\s]+$').hasMatch(value.trim())) {
                      return 'Only letters, numbers, and spaces allowed';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: controller.capacityController,
                  decoration: const InputDecoration(
                    labelText: 'Capacity *',
                    hintText: 'Maximum students (1-80)',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Capacity is required';
                    }
                    final capacity = int.tryParse(value.trim());
                    if (capacity == null) {
                      return 'Please enter a valid number';
                    }
                    if (capacity < 1 || capacity > 80) {
                      return 'Capacity must be between 1 and 80';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: controller.roomTeacherIdController,
                  decoration: const InputDecoration(
                    labelText: 'Room Teacher ID (Optional)',
                    hintText: 'Enter teacher ID or leave empty',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(Get.context!),
            child: const Text('Cancel'),
          ),
          Obx(
            () => ElevatedButton(
              onPressed: controller.isGenerating.value
                  ? null
                  : () {
                      if (controller.formKey.currentState?.validate() ??
                          false) {
                        controller.createSingleSection();
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: TemarLijeColors.primary,
              ),
              child: controller.isGenerating.value
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text('Create Section'),
            ),
          ),
        ],
      ),
    );
  }
}
