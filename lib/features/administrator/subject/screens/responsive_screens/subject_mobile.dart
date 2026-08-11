import 'package:flutter/material.dart';
import 'package:ui_temarlije/features/administrator/subject/screens/widgets/subject_view.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class SubjectMobile extends StatelessWidget {
  const SubjectMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsetsGeometry.all(TemarLijeSizes.mobileSpace),
        child: SubjectView(),
      ),
    );
  }
}
