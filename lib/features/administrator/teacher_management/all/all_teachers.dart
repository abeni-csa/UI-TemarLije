import 'package:flutter/material.dart';
import 'package:ui_temarlije/common/widgets/layouts/template/site_layout.dart';
import 'package:ui_temarlije/features/administrator/teacher_management/all/responsive_screens/teacher_desktop.dart';
import 'package:ui_temarlije/features/administrator/teacher_management/all/responsive_screens/teacher_mobile.dart';
import 'package:ui_temarlije/features/administrator/teacher_management/all/responsive_screens/teacher_tablet.dart';

class AllTeachers extends StatelessWidget {
  const AllTeachers({super.key});

  @override
  Widget build(BuildContext context) {
    return const TemarLijeSiteTemplate(
      mobile: TeacherMobileScreen(),
      tablet: TeacherTabletScreen(),
      desktop: TeacherDesktopScreen(),
    );
  }
}
