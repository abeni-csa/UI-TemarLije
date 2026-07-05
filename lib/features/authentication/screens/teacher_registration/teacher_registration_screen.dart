import 'package:flutter/material.dart';
import 'package:ui_temarlije/common/widgets/layouts/template/site_layout.dart';
import 'package:ui_temarlije/features/authentication/screens/teacher_registration/responsive_screens/teacher_desktop_tablet.dart';
import 'package:ui_temarlije/features/authentication/screens/teacher_registration/responsive_screens/teacher_mobile.dart';

class TeacherRegistrationScreen extends StatelessWidget {
  const TeacherRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TemarLijeSiteTemplate(
      useLayout: false,
      mobile: TeacherScreenMobile(),
      desktop: TeacherScreenDesktopTablet(),
    );
  }
}
