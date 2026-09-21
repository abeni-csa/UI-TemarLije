import 'package:flutter/material.dart';
import 'package:ui_temarlije/data/models/section.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';
import 'package:ui_temarlije/features/administrator/section_management/screens/widgets/sections_view.dart';

class SectionMngMobileScreen extends StatelessWidget {
  const SectionMngMobileScreen({super.key, required this.section});
  final Section section;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(TemarLijeSizes.mobileSpace),
        child: SectionStudentsView(section: section),
      ),
    );
  }
}
