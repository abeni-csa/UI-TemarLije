import 'package:flutter/material.dart';
import 'package:ui_temarlije/common/widgets/layouts/template/site_layout.dart';
import 'package:ui_temarlije/features/teachers/screens/lesson_planning/widgets/lesson_planer_list.dart';

class LessonPlanningScreen extends StatelessWidget {
  const LessonPlanningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TemarLijeSiteTemplate(
      mobile: Placeholder(color: Colors.black, fallbackHeight: 1000),
      desktop: LessoPlanerList(),
      tablet: Placeholder(color: Colors.blue),
    );
  }
}
