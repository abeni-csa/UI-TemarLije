import 'package:flutter/material.dart';
import 'package:ui_temarlije/features/administrator/subject/screens/widgets/subject_view.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class SubjectDesktopTablet extends StatelessWidget {
  const SubjectDesktopTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsetsGeometry.all(TemarLijeSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [SubjectView()],
      ),
    );
  }
}
