import 'package:flutter/material.dart';
import 'package:ui_temarlije/common/widgets/layouts/template/loging_template.dart';
import 'package:ui_temarlije/features/teachers/screens/lesson_planning/widgets/lesson_planning_view.dart';

class LessonPlanningDesktopTablet extends StatelessWidget {
  const LessonPlanningDesktopTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return const TemarLijeLoginScreenTemplate(child: LessonPlanningView());
  }
}
