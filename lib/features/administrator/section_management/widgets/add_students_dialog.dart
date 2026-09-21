import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/data/models/students.dart';
import 'package:ui_temarlije/features/administrator/section_management/section_management_controller.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';

class AddStudentsDialog extends StatelessWidget {
  const AddStudentsDialog({super.key, required this.controller});

  final SectionStudentsController controller;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: TemarLijeColors.googleBackgroundColor,
      child: Container(
        padding: const EdgeInsets.all(24),
        constraints: const BoxConstraints(maxWidth: 700, maxHeight: 700),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            _buildHeader(context),
            const SizedBox(height: 20),

            // Selection Info
            _buildSelectionInfo(),
            const SizedBox(height: 16),

            // Student List
            Expanded(child: _buildStudentList()),

            const SizedBox(height: 20),

            // Action Buttons
            _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.person_add_alt_1,
            color: Colors.white,
            size: 24,
          ),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Students to Section',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'Select students to enroll',
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  Widget _buildSelectionInfo() {
    return Obx(() {
      final selectedCount = controller.selectedStudents.length;
      final availableCount = controller.availableStudents.length;

      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selectedCount > 0 ? Colors.blue.shade50 : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selectedCount > 0
                ? Colors.blue.shade200
                : Colors.grey.shade200,
          ),
        ),
        child: Row(
          children: [
            Icon(
              selectedCount > 0 ? Icons.check_circle : Icons.info_outline,
              color: selectedCount > 0
                  ? Colors.blue.shade700
                  : Colors.grey.shade600,
              size: 20,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                selectedCount > 0
                    ? '$selectedCount of $availableCount students selected'
                    : '$availableCount students available for enrollment',
                style: TextStyle(
                  color: selectedCount > 0
                      ? Colors.blue.shade700
                      : Colors.grey.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (availableCount > 0)
              TextButton(
                onPressed: selectedCount == availableCount
                    ? controller.deselectAll
                    : controller.selectAllAvailable,
                child: Text(
                  selectedCount == availableCount
                      ? 'Deselect All'
                      : 'Select All',
                ),
              ),
          ],
        ),
      );
    });
  }

  Widget _buildStudentList() {
    return Obx(() {
      if (controller.isLoadingAvailable.value) {
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Loading available students...'),
            ],
          ),
        );
      }

      if (controller.availableStudents.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.people_outline, size: 64, color: Colors.grey.shade400),
              const SizedBox(height: 16),
              Text(
                'No Available Students',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'All students are already enrolled in sections',
                style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }

      return ListView.builder(
        shrinkWrap: true,
        itemCount: controller.availableStudents.length,
        itemBuilder: (context, index) {
          final student = controller.availableStudents[index];
          return _buildStudentTile(student);
        },
      );
    });
  }

  Widget _buildStudentTile(Students student) {
    final isMale = student.gender.toLowerCase() == 'male';

    return Obx(() {
      final isSelected = controller.isStudentSelected(student);

      return Card(
        margin: const EdgeInsets.symmetric(vertical: 4),
        elevation: isSelected ? 2 : 0,
        color: isSelected ? Colors.blue.shade50 : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: isSelected ? Colors.blue.shade200 : Colors.grey.shade200,
          ),
        ),
        child: InkWell(
          onTap: () => controller.toggleStudentSelection(student),
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // Checkbox
                Checkbox(
                  value: isSelected,
                  onChanged: (_) => controller.toggleStudentSelection(student),
                  activeColor: Colors.blue,
                ),

                // Avatar
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isMale ? Colors.blue.shade100 : Colors.pink.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      student.initials,
                      style: TextStyle(
                        color: isMale
                            ? Colors.blue.shade800
                            : Colors.pink.shade800,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Student Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        student.fullName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Text(
                            student.gender,
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (student.addressInfo.city.isNotEmpty)
                            Text(
                              student.addressInfo.city,
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey.shade600,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Selected Indicator
                if (isSelected)
                  Icon(
                    Icons.check_circle,
                    color: Colors.blue.shade700,
                    size: 24,
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildActionButtons(BuildContext context) {
    return Obx(() {
      final selectedCount = controller.selectedStudents.length;
      final isAdding = controller.isAddingStudents.value;

      return Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: isAdding ? null : () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Cancel'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              // onPressed: selectedCount > 0 && !isAdding
              //     ? () async {
              //         await controller.addStudentsToSection();
              //         // Guard the BuildContext with a mounted check
              //         if (!context.mounted) return;

              //         if (controller.selectedStudents.isEmpty) {
              //           Navigator.pop<Object?>(
              //             context,
              //           ); // Note: context goes inside the parentheses, not as a named parameter
              //         }
              //       }
              //     : null,
              onPressed: selectedCount > 0 && !isAdding
                  ? () async {
                      await controller.addStudentsToSection();
                      // Guard the BuildContext with a mounted check

                      Navigator.pop<Object?>(
                        context,
                      ); // Note: context goes inside the parentheses, not as a named parameter
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: isAdding
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      selectedCount > 0
                          ? 'Enroll $selectedCount Student${selectedCount > 1 ? 's' : ''}'
                          : 'Select Students',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ],
      );
    });
  }
}
