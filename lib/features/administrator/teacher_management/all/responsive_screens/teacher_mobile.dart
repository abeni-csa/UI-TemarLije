import 'package:flutter/material.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class TeacherMobileScreen extends StatelessWidget {
  const TeacherMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(TemarLijeSizes.mobileSpace),
        child: Placeholder(),
      ),
    );
  }
}
