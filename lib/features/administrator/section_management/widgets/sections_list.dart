import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/features/administrator/student_management/kg/kg_students_controller.dart';
import 'package:ui_temarlije/features/administrator/student_management/kg/widgets/kg_student_card.dart';

class KGStudentList extends StatelessWidget {
  const KGStudentList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<KGStudentsController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with title and refresh
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Registered KG Students',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: controller.refreshKGStudents,
              tooltip: 'Refresh',
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Student count
        Obx(
          () => Text(
            '${controller.kgStudents.length} students registered',
            style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
          ),
        ),
        const SizedBox(height: 12),

        // Student list
        Obx(() {
          if (controller.isLoading.value && controller.kgStudents.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (controller.errorMessage.isNotEmpty &&
              controller.kgStudents.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 48,
                      color: Colors.red.shade300,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Error loading students',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      controller.errorMessage.value,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }

          if (controller.kgStudents.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: [
                    Icon(
                      Icons.person_outline,
                      size: 64,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No KG Students Registered',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tap the + button to register a new student',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount:
                controller.kgStudents.length +
                (controller.hasMoreData.value ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == controller.kgStudents.length) {
                // Load more indicator
                if (controller.isLoading.value) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                return const SizedBox.shrink();
              }

              final student = controller.kgStudents[index];
              return KGStudentCard(
                student: student,
                onDelete: () => controller.showDeleteConfirmation(student),
                onTap: () {
                  // Navigate to student details if needed
                },
              );
            },
          );
        }),
      ],
    );
  }
}
