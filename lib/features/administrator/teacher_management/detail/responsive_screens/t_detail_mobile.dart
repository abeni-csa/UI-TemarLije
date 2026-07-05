import 'package:flutter/material.dart';
import 'package:ui_temarlije/data/models/teacher.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class TeachersDetailMobileScreen extends StatelessWidget {
  const TeachersDetailMobileScreen({super.key, required this.teacher});
  final Teacher teacher;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(TemarLijeSizes.gridViewSpacing),

        child: Column(children: [Placeholder()]),
      ),
    );
  }
}
