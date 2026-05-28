import 'package:flutter/material.dart';
import 'package:ui_temarlije/features/teachers/screens/attendance_tracking/widgets/attendance_list.dart';
import 'package:ui_temarlije/features/teachers/screens/attendance_tracking/widgets/attendance_tracking_view.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class AttendanceTrackingDesktopTablet extends StatelessWidget {
  const AttendanceTrackingDesktopTablet({super.key});
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsetsGeometry.all(3),
      child: AttendanceList(),
    );
  }
}
