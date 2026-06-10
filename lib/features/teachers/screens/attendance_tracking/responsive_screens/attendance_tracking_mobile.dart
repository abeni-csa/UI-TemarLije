import 'package:flutter/material.dart';
import 'package:ui_temarlije/features/teachers/screens/attendance_tracking/widgets/attendance_tracking_view.dart';

class AttendanceTrackingMobile extends StatelessWidget {
  const AttendanceTrackingMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsetsGeometry.all(3),
        child: Column(children: [AttendanceScreen()]),
      ),
    );
  }
}
