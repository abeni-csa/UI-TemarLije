import 'package:flutter/material.dart';
import 'package:ui_temarlije/common/widgets/layouts/template/site_layout.dart';
import 'package:ui_temarlije/features/authentication/screens/student_registration/responsive_screens/student_registration_desktop_tablet.dart';
import 'package:ui_temarlije/features/authentication/screens/student_registration/responsive_screens/student_registration_mobile.dart';

class StudentRegistrationScreen extends StatelessWidget {
  const StudentRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TemarLijeSiteTemplate(
      useLayout: false,
      desktop: StudentRegistrationDesktopTablet(),
      tablet: StudentRegistrationDesktopTablet(),
      mobile: StudentRegistrationMobile(),
    );
  }
}
