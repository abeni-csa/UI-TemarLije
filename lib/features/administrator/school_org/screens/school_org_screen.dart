import 'package:flutter/material.dart';
import 'package:ui_temarlije/common/widgets/layouts/template/site_layout.dart';
import 'package:ui_temarlije/features/administrator/school_org/screens/responsive_screens/school_org_desktop_tablet.dart';
import 'package:ui_temarlije/features/administrator/school_org/screens/responsive_screens/school_org_mobile.dart';

class SchoolOrgScreen extends StatelessWidget {
  const SchoolOrgScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TemarLijeSiteTemplate(
      mobile: SchoolOrgMobile(),
      desktop: SchoolOrgDesktopTablet(),
      tablet: SchoolOrgDesktopTablet(),
    );
  }
}
