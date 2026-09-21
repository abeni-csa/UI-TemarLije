import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/common/widgets/layouts/template/site_layout.dart';
import 'package:ui_temarlije/features/administrator/teacher_management/enrollments/enrollments_controller.dart';
import 'package:ui_temarlije/features/administrator/teacher_management/enrollments/responsive_screens/enrollments_teacher_desktop.dart';
import 'package:ui_temarlije/features/administrator/teacher_management/enrollments/responsive_screens/enrollments_teacher_mobile.dart';
import 'package:ui_temarlije/features/administrator/teacher_management/enrollments/responsive_screens/enrollments_teacher_tablet.dart';

class TeachersEnrollmentsList extends StatelessWidget {
  const TeachersEnrollmentsList({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller if not already initialized
    if (!Get.isRegistered<EnrollmentsController>()) {
      Get.put(EnrollmentsController());
    }

    return const TemarLijeSiteTemplate(
      mobile: EnrollmentsTeacherMobile(),
      tablet: EnrollmentsTeacherTablet(),
      desktop: EnrollmentsTeacherDesktop(),
    );
  }
}
