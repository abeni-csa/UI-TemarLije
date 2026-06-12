import 'package:flutter/material.dart';
import 'package:ui_temarlije/common/widgets/layouts/template/site_layout.dart';
import 'package:ui_temarlije/features/membership/screens/responsive_screens/membership_desktop_tablet.dart';
import 'package:ui_temarlije/features/membership/screens/responsive_screens/membership_mobile.dart';

class SchoolMembershipScreen extends StatelessWidget {
  const SchoolMembershipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TemarLijeSiteTemplate(
      mobile: SchoolMembershipMobile(),
      desktop: SchoolMembershipDesktopTablet(),
      tablet: SchoolMembershipDesktopTablet(),
    );
  }
}
