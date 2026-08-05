import 'package:flutter/material.dart';
import 'package:ui_temarlije/common/widgets/layouts/template/site_layout.dart';
import 'package:ui_temarlije/features/administrator/student_management/list/responsive_screens/list_desktop.dart';
import 'package:ui_temarlije/features/administrator/student_management/list/responsive_screens/list_mobile.dart';
import 'package:ui_temarlije/features/administrator/student_management/list/responsive_screens/list_tablet.dart';

class StudentListScreen extends StatelessWidget {
  const StudentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TemarLijeSiteTemplate(
      tablet: EnrollmentsTabletScreen(),
      mobile: EnrollmentsMobileScreen(),
      desktop: EnrollmentsDesktopScreen(),
    );
  }
}
