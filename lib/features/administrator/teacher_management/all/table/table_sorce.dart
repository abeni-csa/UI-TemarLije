import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/common/widgets/data_table/table_action.dart';
import 'package:ui_temarlije/data/models/teacher.dart';
import 'package:ui_temarlije/features/administrator/school_members/all_members/widgets/edit_membership_form.dart';
import 'package:ui_temarlije/routes/routes.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';
import 'package:ui_temarlije/utils/constants/enums.dart';

import 'package:ui_temarlije/utils/constants/sizes.dart';
import 'package:ui_temarlije/utils/helpers/helper_functions.dart';
import 'package:uuid/uuid.dart';

class AllTeachersDataSource extends DataTableSource {
  final uuid = Uuid();
  List<Teacher> get _teachers => [
    Teacher(
      id: UuidValue.fromString(uuid.v4()),
      baseUserId: UuidValue.fromString(uuid.v4()),
      firstName: 'John',
      middleName: 'A.',
      lastName: 'Doe',
      dateOfBirth: DateTime.parse('1979-03-28'),
      teacherId: 'TCH-001',
      qualification: 'M.Ed in Mathematics',
      specialization: ['Mathematics', 'Physics'],
      yearsOfExperience: 8,
      hireDate: DateTime.parse('2016-08-01'),
      employmentType: EmploymentType.contract,
      isHomeroomTeacher: true,
      phoneNumber: '+1 (555) 123-4567',
      gender: 'Male',
      createdAt: '2023-01-15 10:30:00',
      updatedAt: '2024-01-15 14:20:00',
    ),
    Teacher(
      id: UuidValue.fromString(uuid.v4()),
      baseUserId: UuidValue.fromString(uuid.v4()),
      firstName: 'Sarah',
      middleName: 'M.',
      lastName: 'Johnson',
      dateOfBirth: DateTime.parse('1985-09-22'),
      teacherId: 'TCH-002',
      qualification: 'Ph.D in English Literature',
      specialization: ['English', 'Literature', 'Writing'],
      yearsOfExperience: 12,
      hireDate: DateTime.parse('2012-06-15'),
      employmentType: EmploymentType.internship,
      isHomeroomTeacher: false,
      phoneNumber: '+1 (555) 234-5678',
      gender: 'Female',
      createdAt: '2023-02-20 09:15:00',
      updatedAt: '2024-02-20 11:45:00',
    ),
    Teacher(
      id: UuidValue.fromString(uuid.v4()),
      baseUserId: UuidValue.fromString(uuid.v4()),
      firstName: 'Michael',
      middleName: 'R.',
      lastName: 'Smith',
      dateOfBirth: DateTime.parse('1992-11-03'),
      teacherId: 'TCH-003',
      qualification: 'B.Sc in Computer Science',
      specialization: ['Programming', 'Database', 'Web Development'],
      yearsOfExperience: 5,
      hireDate: DateTime.parse('2019-09-01'),
      employmentType: EmploymentType.partTime,
      isHomeroomTeacher: false,
      phoneNumber: '+1 (555) 345-6789',
      gender: 'Male',
      createdAt: '2023-03-10 13:45:00',
      updatedAt: '2024-03-10 16:30:00',
    ),
    Teacher(
      id: UuidValue.fromString(uuid.v4()),
      baseUserId: UuidValue.fromString(uuid.v4()),
      firstName: 'Emily',
      middleName: 'C.',
      lastName: 'Williams',
      dateOfBirth: DateTime.parse('1988-07-19'),
      teacherId: 'TCH-004',
      qualification: 'M.Sc in Chemistry',
      specialization: ['Chemistry', 'Biology', 'Science'],
      yearsOfExperience: 9,
      hireDate: DateTime.parse('2015-01-15'),
      employmentType: EmploymentType.permanent,
      isHomeroomTeacher: true,
      phoneNumber: '+1 (555) 456-7890',
      gender: 'Female',
      createdAt: '2023-04-05 08:00:00',
      updatedAt: '2024-04-05 10:15:00',
    ),
    Teacher(
      id: UuidValue.fromString(uuid.v4()),
      baseUserId: UuidValue.fromString(uuid.v4()),
      firstName: 'David',
      middleName: 'K.',
      lastName: 'Brown',
      dateOfBirth: DateTime.parse('1990-05-15'),
      teacherId: 'TCH-005',
      qualification: 'Ph.D in History',
      specialization: ['History', 'Geography', 'Social Studies'],
      yearsOfExperience: 15,
      hireDate: DateTime.parse('2009-08-20'),
      employmentType: EmploymentType.contract,
      isHomeroomTeacher: false,
      phoneNumber: '+1 (555) 567-8901',
      gender: 'Male',
      createdAt: '2023-05-12 11:20:00',
      updatedAt: '2024-05-12 13:40:00',
    ),
  ];

  @override
  DataRow? getRow(int index) {
    if (index >= _teachers.length) return null;
    final teacher = _teachers[index];

    return DataRow2(
      onTap: () =>
          Get.toNamed(TemarLijeRoutes.teacherDetails, arguments: teacher),
      selected: false,
      onSelectChanged: (teacher) => {},
      cells: [
        // 1. ID
        // DataCell(
        //   Text(
        //     teacher.id.toString(),
        //     style: const TextStyle(fontWeight: FontWeight.w500),
        //   ),
        // ),

        // 2. Teacher ID
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: TemarLijeColors.primary,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              teacher.teacherId,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: TemarLijeColors.primary,
              ),
            ),
          ),
        ),

        // 3. Full Name
        DataCell(
          Row(
            children: [
              // TemarLijeRoundedImage(
              //   imageType: ImageType.asset,
              //   padding: TemarLijeSizes.xs,
              //   width: 40,
              //   height: 40,
              //   image: teacher.gender.toLowerCase() == 'male'
              //       ? TemarLijeImagesStrings.userProfileImage1
              //       : TemarLijeImagesStrings.userProfileImage3,
              //   borderRadius: TemarLijeSizes.borderRadiusMd,
              //   backgroundColor: TemarLijeColors.primaryBackground,
              // ),
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

        // 4. Date of Birth
        DataCell(Text(_formatDate(teacher.dateOfBirth.toString()))),

        // 5. Qualification
        DataCell(
          Text(
            teacher.qualification,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),

        // 6. Specialization
        DataCell(
          Wrap(
            spacing: 4,
            runSpacing: 2,
            children: teacher.specialization.map((spec) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: TemarLijeColors.primaryBackground,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: TemarLijeColors.borderPrimary),
                ),
                child: Text(spec, style: const TextStyle(fontSize: 11)),
              );
            }).toList(),
          ),
        ),

        // 7. Experience
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
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
                backgroundColor: TemarLijeHelperFunctions.getExperienceColor(
                  teacher.yearsOfExperience,
                ),
              ),
            ),
          ),
        ),

        // 8. Employment Type
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              // color: _getEmploymentTypeColor(teacher.employmentType),
              color: Colors.white,

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

        // 9. Phone Number
        DataCell(Text(teacher.phoneNumber)),

        // 10. Gender
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

        // 11. Homeroom (redundant but keeping for consistency)
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: teacher.isHomeroomTeacher ? Colors.green : Colors.grey,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              teacher.isHomeroomTeacher ? 'Yes' : 'No',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                backgroundColor: teacher.isHomeroomTeacher
                    ? Colors.green
                    : Colors.grey,
              ),
            ),
          ),
        ),

        // 12. Created At
        // DataCell(
        //   Text(TemarLijeHelperFunctions.formatDateTime(teacher.createdAt)),
        // ),

        // // 13. Updated At
        // DataCell(
        //   Text(
        //     "${TemarLijeHelperFunctions.formatDateTime(teacher.updatedAt)}Ago",
        //   ),
        // ),

        // 14. Actions
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
  int get rowCount => _teachers.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;

  // Helper methods
  String _formatDate(String date) {
    try {
      final parts = date.split('-');
      if (parts.length == 3) {
        return '${parts[1]}/${parts[2]}/${parts[0]}';
      }
      return date;
    } catch (e) {
      return date;
    }
  }

  void _showEditDialog(Teacher teacher) {
    Get.bottomSheet(
      EditMembershipForm(),
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
  }

  void _showDeleteConfirmation(Teacher teacher) {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete Teacher'),
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
