import 'package:flutter/material.dart';
import 'package:ui_temarlije/common/widgets/layouts/template/site_layout.dart';
import 'package:ui_temarlije/features/administrator/classroom/responsive_screens/classroom_desktop_tablet.dart';
import 'package:ui_temarlije/features/administrator/classroom/responsive_screens/classroom_mobile.dart';

class ClassroomScreens extends StatelessWidget {
  const ClassroomScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return const TemarLijeSiteTemplate(
      mobile: ClassroomMobileScreen(),
      desktop: ClassroomDesktopTabletScreen(),
      tablet: ClassroomDesktopTabletScreen(),
    );
  }
}
