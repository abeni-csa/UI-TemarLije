import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/data/models/section.dart';
import 'package:ui_temarlije/features/administrator/section_management/section_management_controller.dart';
import 'package:ui_temarlije/features/administrator/section_management/widgets/sections_info_card.dart';
import 'package:ui_temarlije/features/administrator/section_management/widgets/section_student_card.dart';
import 'package:ui_temarlije/features/administrator/section_management/widgets/add_students_dialog.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class SectionStudentsView extends StatelessWidget {
  const SectionStudentsView({super.key, required this.section});

  final Section section;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SectionStudentsController());

    // Load section details on first build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.currentSection.value?.id != section.id) {
        controller.loadSectionDetails(section);
      }
    });

    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Info Card
          SectionInfoCard(section: controller.currentSection.value ?? section),
          const SizedBox(height: TemarLijeSizes.spaceBtwItems),

          // Action Buttons
          _buildActionButtons(context, controller),
          const SizedBox(height: TemarLijeSizes.spaceBtwItems),

          // Students List
          _buildStudentsList(controller),
        ],
      ),
    );
  }

  Widget _buildActionButtons(
    BuildContext context,
    SectionStudentsController controller,
  ) {
    final section = controller.currentSection.value;
    final availableCapacity = section!.capacity - section.currentEnrollment;

    return Wrap(
      spacing: 12,
      runSpacing: 8,
      children: [
        ElevatedButton.icon(
          onPressed: availableCapacity > 0
              ? () => _showAddStudentsDialog(context, controller)
              : null,
          icon: const Icon(Icons.person_add, size: 18),
          label: Text(
            availableCapacity > 0
                ? 'Add Students ($availableCapacity spots)'
                : 'Section Full',
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: availableCapacity > 0 ? Colors.blue : Colors.grey,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        OutlinedButton.icon(
          onPressed: () => controller.loadEnrolledStudents(section.id),
          icon: const Icon(Icons.refresh, size: 18),
          label: const Text('Refresh'),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStudentsList(SectionStudentsController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Enrolled Students',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Obx(
              () => Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${controller.enrolledStudents.length} students',
                  style: TextStyle(
                    color: Colors.blue.shade700,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        Obx(() {
          if (controller.isLoadingStudents.value &&
              controller.enrolledStudents.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(40.0),
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (controller.enrolledStudents.isEmpty) {
            return _buildEmptyState(controller);
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.enrolledStudents.length,
            itemBuilder: (context, index) {
              final student = controller.enrolledStudents[index];
              return SectionStudentCard(
                student: student,
                onRemove: () => controller.removeStudentFromSection(student),
              );
            },
          );
        }),
      ],
    );
  }

  Widget _buildEmptyState(SectionStudentsController controller) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Icon(Icons.people_outline, size: 64, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            'No Students Enrolled',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Click "Add Students" to enroll students in this section',
            style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () => _showAddStudentsDialog(Get.context!, controller),
            icon: const Icon(Icons.person_add, size: 18),
            label: const Text('Add Students'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddStudentsDialog(
    BuildContext context,
    SectionStudentsController controller,
  ) {
    controller.clearSelection();
    controller.loadAvailableStudents();

    Get.dialog(
      AddStudentsDialog(controller: controller),
      barrierDismissible: false,
    );
  }
}
