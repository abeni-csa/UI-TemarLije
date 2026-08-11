import 'package:flutter/material.dart';
import 'package:ui_temarlije/common/widgets/layouts/template/site_layout.dart';
import 'package:ui_temarlije/features/administrator/subject/screens/responsive_screens/subject_desktop_tablet.dart';
import 'package:ui_temarlije/features/administrator/subject/screens/responsive_screens/subject_mobile.dart';

class SubjectScreen extends StatelessWidget {
  const SubjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TemarLijeSiteTemplate(
      mobile: SubjectMobile(),
      desktop: SubjectDesktopTablet(),
      tablet: SubjectDesktopTablet(),
    );
  }
}
