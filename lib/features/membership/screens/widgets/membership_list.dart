import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/features/membership/membership_controllers.dart';
import 'package:ui_temarlije/features/membership/screens/widgets/membership_card.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class SchoolMembershipList extends StatelessWidget {
  // final List<SchoolOrganzationModel> schoolOrg;
  final bool isLoading;
  final VoidCallback onRefresh;

  const SchoolMembershipList({
    super.key,
    // required this.schoolOrg,
    required this.isLoading,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final membershipController = Get.find<MembershipControllers>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'List of School\'s to Join',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              overflow: TextOverflow.fade,
            ),
            IconButton(
              icon: const Icon(Icons.refresh, color: Colors.black),
              onPressed: () => membershipController.loadSchools(),
              tooltip: 'Refresh',
            ),
          ],
        ),
        const SizedBox(height: TemarLijeSizes.spaceBtwItems),
        if (isLoading)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: CircularProgressIndicator(color: Colors.black),
            ),
          )
        else if (membershipController.schools.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: [
                  Icon(
                    Icons.menu_book_outlined,
                    size: 64,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No School Available',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'No schools are available to join at the moment',
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
                  ),
                ],
              ),
            ),
          )
        else
          Obx(
            () => ListView.builder(
              shrinkWrap: true,
              itemCount: membershipController.schools.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final school = membershipController.schools[index];
                return SchoolMembershipCard(schoolOrganzation: school);
              },
            ),
          ),
      ],
    );
  }
}
