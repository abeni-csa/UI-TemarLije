import 'package:flutter/material.dart';
import 'package:ui_temarlije/features/administrator/academic_year/screens/widgets/academic_year_view.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class AcademicYearMobileScreen extends StatelessWidget {
  const AcademicYearMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsetsGeometry.all(TemarLijeSizes.defaultSpace),
        child: Column(children: [AcademicYearView()]),
      ),
    );
  }
}
