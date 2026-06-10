import 'package:flutter/material.dart';
import 'package:ui_temarlije/common/widgets/layouts/template/site_layout.dart';

class JoinSchoolScreen extends StatelessWidget {
  const JoinSchoolScreen({super.key});
  @override
  Widget build(BuildContext context) => TemarLijeSiteTemplate(
    tablet: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text("School Join")],
      ),
    ),
    desktop: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text("School Join")],
      ),
    ),
    mobile: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text("School Join")],
      ),
    ),
  );
}
