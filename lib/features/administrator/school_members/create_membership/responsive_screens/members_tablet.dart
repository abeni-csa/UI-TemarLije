import 'package:flutter/material.dart';
import 'package:ui_temarlije/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:ui_temarlije/common/widgets/containers/rounded_container.dart';
import 'package:ui_temarlije/features/administrator/school_members/create_membership/widgets/create_membership_form.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class CreateMembersTabletScreen extends StatelessWidget {
  const CreateMembersTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(TemarLijeSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Breadcurbs
            const TemarLijeBreadcrumbsWithHeading(
              heading: "All Members",
              breadcrumbsItems: [],
              returnToPreviousScreen: true,
            ),

            const SizedBox(height: TemarLijeSizes.spaceBtwSections),
            // Table Body
            TemarLijeRoundedContainer(
              child: Column(
                children: [
                  SizedBox(height: TemarLijeSizes.spaceBtwItems),
                  CreateMembershipForm(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
