import 'package:flutter/material.dart';
import 'package:ui_temarlije/common/widgets/layouts/template/site_layout.dart';
import 'package:ui_temarlije/features/administrator/student_management/kg/responsive_screens/kg_students_desktop.dart';
import 'package:ui_temarlije/features/administrator/student_management/kg/responsive_screens/kg_students_mobile.dart';
import 'package:ui_temarlije/features/administrator/student_management/kg/responsive_screens/kg_students_tablet.dart';

class KgStudentsScreen extends StatelessWidget {
  const KgStudentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TemarLijeSiteTemplate(
      mobile: KgStudentsMobileScreen(),
      tablet: KgStudentsTabletScreen(),
      desktop: KgStudentsDesktopScreen(),
    );
  }
}
