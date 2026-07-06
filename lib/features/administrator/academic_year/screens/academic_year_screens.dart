import 'package:flutter/material.dart';
import 'package:ui_temarlije/common/widgets/layouts/template/site_layout.dart';
import 'package:ui_temarlije/features/administrator/academic_year/screens/responsive_screens/academic_year_desktop_tablet.dart';
import 'package:ui_temarlije/features/administrator/academic_year/screens/responsive_screens/academic_year_mobile.dart';

class AcademicYearScreens extends StatelessWidget {
  const AcademicYearScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return const TemarLijeSiteTemplate(
      mobile: AcademicYearMobileScreen(),
      desktop: AcademicYearDesktopTabletScreen(),
      tablet: AcademicYearDesktopTabletScreen(),
    );
  }
}
