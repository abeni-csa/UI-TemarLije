import 'package:flutter/material.dart';
import 'package:ui_temarlije/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:ui_temarlije/common/widgets/containers/rounded_container.dart';
import 'package:ui_temarlije/data/models/section.dart';
import 'package:ui_temarlije/features/administrator/section_management/screens/widgets/sections_view.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class SectionMngDesktopScreen extends StatelessWidget {
  const SectionMngDesktopScreen({super.key, required this.section});
  final Section section;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(TemarLijeSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TemarLijeBreadcrumbsWithHeading(
              heading: section.sectionName,
              breadcrumbsItems: ['Sections', section.sectionCode],
              returnToPreviousScreen: true,
            ),
            const SizedBox(height: TemarLijeSizes.spaceBtwSections),

            // Main Content
            TemarLijeRoundedContainer(
              padding: const EdgeInsets.all(24),
              child: SectionStudentsView(section: section),
            ),
          ],
        ),
      ),
    );
  }
}
