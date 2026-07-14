import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/common/widgets/data_table/table_action.dart';
import 'package:ui_temarlije/data/models/teacher.dart';
import 'package:ui_temarlije/features/administrator/teacher_management/all/all_teacher_controller.dart';
import 'package:ui_temarlije/routes/routes.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';
import 'package:ui_temarlije/utils/helpers/helper_functions.dart';

class AllTeachersDataSource extends DataTableSource {
  final AllTeacherController _controller = Get.find<AllTeacherController>();

  @override
  DataRow? getRow(int index) {
    if (index >= _controller.teachers.length) return null;
    final teacher = _controller.teachers[index];

    return DataRow2(
      onTap: () =>
          Get.toNamed(TemarLijeRoutes.teacherDetails, arguments: teacher),
      selected: false,
      onSelectChanged: (selected) {
        // Handle selection if needed
      },
      cells: [
        // 2. Full Name
        DataCell(
          Row(
            children: [
              const SizedBox(width: TemarLijeSizes.spaceBtwItems),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      teacher.fullName,
                      style: Theme.of(Get.context!).textTheme.bodyLarge!.apply(
                        color: TemarLijeColors.primary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (teacher.isHomeroomTeacher)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Homeroom',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.blue.shade800,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // 6. Experience
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: TemarLijeHelperFunctions.getExperienceColor(
                teacher.yearsOfExperience,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '${teacher.yearsOfExperience} ${teacher.yearsOfExperience == 1 ? 'year' : 'years'}',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),

        // 7. Employment Type
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: TemarLijeHelperFunctions.getEmploymentTypeColor(
                teacher.employmentType,
              ).withAlpha(30),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              teacher.employmentType.name.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: TemarLijeHelperFunctions.getEmploymentTypeColor(
                  teacher.employmentType,
                ),
              ),
            ),
          ),
        ),

        // 8. Phone Number
        DataCell(Text(teacher.phoneNumber)),

        // 9. Gender
        DataCell(
          Row(
            children: [
              Icon(
                teacher.gender.toLowerCase() == 'male'
                    ? Icons.male
                    : Icons.female,
                size: 16,
                color: teacher.gender.toLowerCase() == 'male'
                    ? Colors.blue
                    : const Color.fromARGB(255, 230, 66, 120),
              ),
              const SizedBox(width: 4),
              Text(teacher.gender, overflow: TextOverflow.ellipsis),
            ],
          ),
        ),

        // 10. Homeroom
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: teacher.isHomeroomTeacher ? Colors.green : Colors.grey,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              teacher.isHomeroomTeacher ? 'Yes' : 'No',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),

        // 11. Actions
        DataCell(
          TemarLijeTableActionButtons(
            edit: false,
            view: true,
            onDeletePressed: () => _showDeleteConfirmation(teacher),
            onViewPressed: () =>
                Get.toNamed(TemarLijeRoutes.teacherDetails, arguments: teacher),
          ),
        ),
      ],
    );
  }

  @override
  int get rowCount => _controller.teachers.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;

  void _showDeleteConfirmation(Teacher teacher) {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete Teacher'),
        backgroundColor: TemarLijeColors.cardBackgroundColor,
        content: Text('Are you sure you want to delete ${teacher.fullName}?'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Get.back();
              Get.snackbar(
                colorText: TemarLijeColors.textWhite,
                backgroundColor: TemarLijeColors.success,
                'Success',
                '${teacher.fullName} has been deleted',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
