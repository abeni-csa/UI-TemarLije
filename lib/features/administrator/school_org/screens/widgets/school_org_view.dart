import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/features/administrator/school_org/school_org_controller.dart';
import 'package:ui_temarlije/features/administrator/school_org/screens/widgets/school_org_list.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

/// View model for school organization management
/// Handles UI presentation and delegates business logic to controller
class SchoolOrgView extends StatelessWidget {
  const SchoolOrgView({super.key});

  @override
  Widget build(BuildContext context) {
    final SchoolOrgController controller = Get.find<SchoolOrgController>();

    return Obx(
      () => Column(
        children: [
          if (controller.isLoading.value) const LinearProgressIndicator(),
          SchoolOrgList(
            schoolOrg: controller.schools,
            isLoading: controller.isLoading.value,
            onRefresh: controller.refreshSchools,
            onDelete: (school) => controller.handleDelete(school),
            onEdit: controller.showEditForm,
          ),
          const SizedBox(height: TemarLijeSizes.spaceBtwItems),
          Align(
            alignment: Alignment.centerRight,
            child: FloatingActionButton(
              backgroundColor: TemarLijeColors.facebookBackgroundColor,
              onPressed: controller.showCreateForm,
              mini: true,
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
