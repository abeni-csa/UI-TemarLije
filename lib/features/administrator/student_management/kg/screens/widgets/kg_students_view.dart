import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/features/administrator/academic_year/academic_year_controller.dart';
import 'package:ui_temarlije/features/administrator/student_management/kg/kg_students_controller.dart';
import 'package:ui_temarlije/features/administrator/student_management/kg/widgets/kg_student_list.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class KGStudentsView extends StatelessWidget {
  const KGStudentsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<KGStudentsController>();
    final academicController = Get.find<AcademicYearController>();

    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Academic year status
          if (academicController.currentAcademicYear.value != null) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.calendar_month, color: Colors.blue.shade700),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Academic Year: ${academicController.currentAcademicYear.value!.yearRange}',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Active',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: TemarLijeSizes.spaceBtwItems),
          ],

          // Error message if no academic year
          if (academicController.currentAcademicYear.value == null)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.orange.shade700,
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'No active academic year. Please set a current academic year to register students.',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),

          const SizedBox(height: TemarLijeSizes.spaceBtwSections),

          // Add Student Button
          if (academicController.currentAcademicYear.value != null) ...[
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: controller.showCreateForm,
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text(
                  'Register New KG Student',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(height: TemarLijeSizes.spaceBtwSections),

            // Student List
            const KGStudentList(),
          ],
        ],
      ),
    );
  }
}
