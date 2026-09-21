import 'package:flutter/material.dart';
import 'package:ui_temarlije/common/widgets/containers/rounded_container.dart';
import 'package:ui_temarlije/data/models/section.dart';
import 'package:ui_temarlije/features/administrator/section_management/screens/widgets/sections_view.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class SectionMngTabletScreen extends StatelessWidget {
  const SectionMngTabletScreen({super.key, required this.section});

  final Section section;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(TemarLijeSizes.defaultSpace),
        child: TemarLijeRoundedContainer(
          padding: const EdgeInsets.all(20),
          child: SectionStudentsView(section: section),
        ),
      ),
    );
  }
}
