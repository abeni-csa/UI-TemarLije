import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:ui_temarlije/data/models/teacher.dart';
import 'package:ui_temarlije/features/administrator/teacher_management/detail/widgets/basic_info.dart';
import 'package:ui_temarlije/features/administrator/teacher_management/detail/widgets/certificate_education_background_info.dart';
import 'package:ui_temarlije/features/administrator/teacher_management/detail/widgets/teacher_personal_informaton.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class TeacherDetailDesktopScreen extends StatelessWidget {
  const TeacherDetailDesktopScreen({super.key, required this.teacher});
  final Teacher teacher;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(TemarLijeSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TemarLijeBreadcrumbsWithHeading(
              heading: 'Teacher Details [${teacher.teacherId}]',
              breadcrumbsItems: ['/teachers', '/details'],
              returnToPreviousScreen: true,
            ),
            const SizedBox(height: TemarLijeSizes.spaceBtwSections),

            // Body - Row layout for desktop
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Column - Basic Info & Certifications
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      BasicTeacherInfo(teacher: teacher),
                      const SizedBox(height: TemarLijeSizes.spaceBtwSections),
                      TeacherCertificateEducationBackgroundInfo(
                        teacher: teacher,
                      ),
                      const SizedBox(height: TemarLijeSizes.spaceBtwSections),
                      // TeacherPastSchoolsInfo(teacher: teacher),
                    ],
                  ),
                ),
                const SizedBox(width: TemarLijeSizes.spaceBtwSections),
                // Right Column - Personal Information
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      TeacherPersonalInformation(teacher: teacher),
                      const SizedBox(height: TemarLijeSizes.spaceBtwSections),
                      // TeacherContactInfo(teacher: teacher),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
