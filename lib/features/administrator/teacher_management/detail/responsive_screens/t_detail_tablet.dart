import 'package:flutter/material.dart';
import 'package:ui_temarlije/data/models/teacher.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class TeachersDetailTabletScreen extends StatelessWidget {
  const TeachersDetailTabletScreen({super.key, required this.teacher});
  final Teacher teacher;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(TemarLijeSizes.defaultSpace),
        child: Container(),
      ),
    );
  }
}
