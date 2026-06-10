import 'package:flutter/material.dart';
import 'package:ui_temarlije/features/teachers/screens/lesson_planning/widgets/lesson_planning_view.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class LessonPlanningMobile extends StatelessWidget {
  const LessonPlanningMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsetsGeometry.all(TemarLijeSizes.defaultSpace),
        child: Column(children: [LessonPlanningView()]),
      ),
    );
  }
}
