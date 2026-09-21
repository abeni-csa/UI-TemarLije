import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/common/widgets/layouts/template/site_layout.dart';
import 'package:ui_temarlije/features/administrator/student_management/enrollments/enrollments_controller.dart';
import 'package:ui_temarlije/features/administrator/student_management/enrollments/responsive_screens/enrollments_desktop.dart';
// import 'package:ui_temarlije/features/administrator/student_management/enrollments/responsive_screens/enrollments_mobile.dart';
// import 'package:ui_temarlije/features/administrator/student_management/enrollments/responsive_screens/enrollments_tablet.dart';

class StudentEnrollmentsScreen extends StatelessWidget {
  const StudentEnrollmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<StudentEnrollmentsController>()) {
      Get.put(StudentEnrollmentsController());
    }

    return const TemarLijeSiteTemplate(
      mobile: EnrollmentsDesktopScreen(), // EnrollmentsMobileScreen(),
      tablet: EnrollmentsDesktopScreen(), // EnrollmentsTabletScreen(),
      desktop: EnrollmentsDesktopScreen(),
    );
  }
}
