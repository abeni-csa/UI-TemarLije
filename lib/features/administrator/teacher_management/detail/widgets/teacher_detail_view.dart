import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:ui_temarlije/common/widgets/containers/rounded_container.dart';
import 'package:ui_temarlije/common/widgets/data_table/table_header.dart';
import 'package:ui_temarlije/features/administrator/school_members/all_members/table/data_table.dart';
import 'package:ui_temarlije/routes/routes.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class AllMembersView extends StatelessWidget {
  const AllMembersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Breadcurbs
        const TemarLijeBreadcrumbsWithHeading(
          heading: "All Members",
          breadcrumbsItems: [
            TemarLijeRoutes.createMembers,
            TemarLijeRoutes.school,
            TemarLijeRoutes.schoolUserJoin,
          ],
        ),
        const SizedBox(height: TemarLijeSizes.spaceBtwSections),
        // Table Body
        TemarLijeRoundedContainer(
          child: Column(
            children: [
              TemarLijeDataTableHeader(
                buttonText: "Create Membership",
                onPress: () => Get.toNamed(TemarLijeRoutes.createMembers),
              ),
              SizedBox(height: TemarLijeSizes.spaceBtwItems),
              AllMembersDataTable(),
            ],
          ),
        ),
      ],
    );
  }
}
