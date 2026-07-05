import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/common/widgets/layouts/template/site_layout.dart';
import 'package:ui_temarlije/features/administrator/teacher_management/detail/responsive_screens/t_detail_desktop.dart';
import 'package:ui_temarlije/features/administrator/teacher_management/detail/responsive_screens/t_detail_mobile.dart';
import 'package:ui_temarlije/features/administrator/teacher_management/detail/responsive_screens/t_detail_tablet.dart';

class TeacherDetailScreen extends StatelessWidget {
  const TeacherDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final teacher = Get.arguments;
    return TemarLijeSiteTemplate(
      mobile: TeachersDetailMobileScreen(teacher: teacher),
      tablet: TeachersDetailTabletScreen(teacher: teacher),
      desktop: TeacherDetailDesktopScreen(teacher: teacher),
    );
  }
}
