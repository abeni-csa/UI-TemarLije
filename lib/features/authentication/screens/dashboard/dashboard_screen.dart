import 'package:flutter/material.dart';
import 'package:ui_temarlije/common/widgets/layouts/template/site_layout.dart';
import 'package:ui_temarlije/features/authentication/screens/dashboard/responsive_screens/dashboard_desktop.dart';
import 'package:ui_temarlije/features/authentication/screens/dashboard/responsive_screens/dashboard_tablet.dart';
import 'package:ui_temarlije/features/authentication/screens/dashboard/responsive_screens/dashbord_mobile.dart.';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TemarLijeSiteTemplate(
      mobile: DashboardMobile(),
      desktop: DashboardDesktopScreen(),
      tablet: DashboardTabletScreen(),
    );
  }
}
