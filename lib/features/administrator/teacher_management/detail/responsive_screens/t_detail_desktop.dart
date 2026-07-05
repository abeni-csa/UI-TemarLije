import 'package:flutter/material.dart';
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
        padding: EdgeInsets.all(TemarLijeSizes.mobileSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TemarLijeBreadcrumbsWithHeading(
              heading: 'Teachers Details',
              breadcrumbsItems: ['/products', '/electronics', '/laptops'],
              returnToPreviousScreen: true,
            ),
            SizedBox(height: TemarLijeSizes.spaceBtwSections),

            //Body
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Side Order Info
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
                      //PastSchoolsTeacherInfo(teacher: teacher),
                    ],
                  ),
                ),
                const SizedBox(height: TemarLijeSizes.spaceBtwSections),
                Expanded(
                  child: Column(
                    children: [
                      TeacherPersonalInformaton(teacher: teacher),
                      const SizedBox(height: TemarLijeSizes.spaceBtwSections),
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
