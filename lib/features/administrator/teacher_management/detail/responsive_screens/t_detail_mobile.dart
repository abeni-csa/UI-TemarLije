import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/data/models/teacher.dart';
import 'package:ui_temarlije/features/administrator/teacher_management/detail/widgets/basic_info.dart';
import 'package:ui_temarlije/features/administrator/teacher_management/detail/widgets/certificate_education_background_info.dart';
import 'package:ui_temarlije/features/administrator/teacher_management/detail/widgets/teacher_personal_informaton.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class TeachersDetailMobileScreen extends StatelessWidget {
  const TeachersDetailMobileScreen({super.key, required this.teacher});
  final Teacher teacher;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(TemarLijeSizes.mobileSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back button and title
            Row(
              children: [
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.arrow_back),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Teacher Details',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ],
            ),
            const SizedBox(height: TemarLijeSizes.spaceBtwItems),

            // Teacher ID badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'ID: ${teacher.teacherId}',
                style: TextStyle(
                  color: Colors.blue.shade800,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: TemarLijeSizes.spaceBtwSections),

            // All sections in vertical layout for mobile
            BasicTeacherInfo(teacher: teacher),
            const SizedBox(height: TemarLijeSizes.spaceBtwSections),

            TeacherPersonalInformation(teacher: teacher),
            const SizedBox(height: TemarLijeSizes.spaceBtwSections),

            TeacherCertificateEducationBackgroundInfo(teacher: teacher),
            const SizedBox(height: TemarLijeSizes.spaceBtwSections),
          ],
        ),
      ),
    );
  }
}
