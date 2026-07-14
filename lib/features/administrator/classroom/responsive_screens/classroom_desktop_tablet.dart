// lib/features/administrator/classroom/screens/responsive_screens/classroom_desktop_tablet.dart
import 'package:flutter/material.dart';
import 'package:ui_temarlije/features/administrator/classroom/widgets/classroom_view.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class ClassroomDesktopTabletScreen extends StatelessWidget {
  const ClassroomDesktopTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsetsGeometry.all(TemarLijeSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [ClassroomView()],
      ),
    );
  }
}
