import 'package:flutter/material.dart';
import 'package:ui_temarlije/features/teachers/screens/lesson_planning/widgets/lesson_planning_view.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class LessonPlanningDesktopTablet extends StatelessWidget {
  const LessonPlanningDesktopTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsetsGeometry.all(TemarLijeSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [LessonPlanningView()],
      ),
    );
  }
}
