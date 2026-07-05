import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/features/membership/membership_controllers.dart';
import 'package:ui_temarlije/features/membership/screens/widgets/membership_list.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';

class SchoolMembershipView extends StatelessWidget {
  const SchoolMembershipView({super.key});
  @override
  Widget build(BuildContext context) {
    final membershipController = Get.find<MembershipControllers>();

    return Obx(
      () => Column(
        children: [
          if (membershipController.isLoading.value)
            const LinearProgressIndicator(
              backgroundColor: TemarLijeColors.accent,
            ),
          SchoolMembershipList(
            // schoolOrg: membershipController.schools,
            isLoading: membershipController.isLoading.value,
            onRefresh: membershipController.loadSchools,
          ),
        ],
      ),
    );
  }
}
