import 'package:flutter/material.dart';
import 'package:ui_temarlije/common/widgets/layouts/template/site_layout.dart';
import 'package:ui_temarlije/features/teachers/screens/attendance_tracking/responsive_screens/attendance_tracking_desktop_tablet.dart';
import 'package:ui_temarlije/features/teachers/screens/attendance_tracking/responsive_screens/attendance_tracking_mobile.dart';

class AttendanceTrackingScreen extends StatelessWidget {
  const AttendanceTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TemarLijeSiteTemplate(
      mobile: AttendanceTrackingMobile(),
      desktop: AttendanceTrackingDesktopTablet(),
      tablet: AttendanceTrackingDesktopTablet(),
    );
  }
}
