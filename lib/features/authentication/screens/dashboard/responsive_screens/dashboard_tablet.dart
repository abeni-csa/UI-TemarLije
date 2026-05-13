import 'package:flutter/material.dart';
import 'package:ui_temarlije/common/widgets/layouts/template/loging_template.dart';
import 'package:ui_temarlije/common/widgets/layouts/template/site_layout.dart';

class DashboardTabletScreen extends StatelessWidget {
  const DashboardTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TemarLijeLoginScreenTemplate(
      child: Column(children: [Text("Dashbord View of Tablet")]),
    );
  }
}
