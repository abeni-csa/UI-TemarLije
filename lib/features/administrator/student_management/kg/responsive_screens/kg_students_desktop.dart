import 'package:flutter/material.dart';
import 'package:ui_temarlije/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:ui_temarlije/common/widgets/containers/rounded_container.dart';
import 'package:ui_temarlije/features/administrator/student_management/kg/screens/widgets/kg_students_view.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class KGStudentsDesktopScreen extends StatelessWidget {
  const KGStudentsDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final controller = Get.find<KGStudentsController>();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(TemarLijeSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TemarLijeBreadcrumbsWithHeading(
              heading: 'KG Students Management',
              breadcrumbsItems: ['KG Students'],
              returnToPreviousScreen: true,
            ),
            const SizedBox(height: TemarLijeSizes.spaceBtwSections),

            // Main Content
            TemarLijeRoundedContainer(
              padding: const EdgeInsets.all(24),
              child: const KGStudentsView(),
            ),
          ],
        ),
      ),
    );
  }
}
