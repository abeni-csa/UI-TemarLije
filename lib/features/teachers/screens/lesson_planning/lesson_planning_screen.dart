import 'package:flutter/material.dart';
import 'package:ui_temarlije/common/widgets/layouts/template/site_layout.dart';
import 'package:ui_temarlije/features/teachers/screens/lesson_planning/responsive_screens/lesson_planning_desktop_tablet.dart';
import 'package:ui_temarlije/features/teachers/screens/lesson_planning/responsive_screens/lesson_planning_mobile.dart';

class LessonPlanningScreen extends StatelessWidget {
  const LessonPlanningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TemarLijeSiteTemplate(
      mobile: LessonPlanningMobile(),
      desktop: LessonPlanningDesktopTablet(),
      tablet: LessonPlanningDesktopTablet(),
    );
  }
}
