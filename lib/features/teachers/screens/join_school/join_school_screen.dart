import 'package:flutter/material.dart';
import 'package:ui_temarlije/common/widgets/layouts/template/site_layout.dart';
import 'package:ui_temarlije/features/membership/screens/join_school/widget/serch_school.dart';

class JoinSchoolScreen extends StatelessWidget {
  const JoinSchoolScreen({super.key});
  @override
  Widget build(BuildContext context) => TemarLijeSiteTemplate(
    tablet: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [SerchSchoolBarApp()],
      ),
    ),
    desktop: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [SerchSchoolBarApp()],
      ),
    ),
    mobile: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [SerchSchoolBarApp()],
      ),
    ),
  );
}
