// lib/common/widgets/school/school_selector.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/data/models/school_organzation.dart';
import 'package:ui_temarlije/features/administrator/school_org/global_school_controller.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';

class SchoolSelector extends StatelessWidget {
  const SchoolSelector({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GlobalSchoolController>();

    return Obx(() {
      if (controller.isLoading.value) {
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        );
      }

      if (controller.schools.isEmpty) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: TemarLijeColors.error.withAlpha(76),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: TemarLijeColors.error,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                'No School',
                style: TextStyle(color: TemarLijeColors.error, fontSize: 12),
              ),
              IconButton(
                icon: const Icon(Icons.refresh, color: Colors.white),
                onPressed: controller.loadUserSchools,
                tooltip: 'Refresh',
              ),
            ],
          ),
        );
      }

      if (controller.schools.length == 1) {
        // Single school - show as label
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: TemarLijeColors.primary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.school, color: TemarLijeColors.primary, size: 18),
              const SizedBox(width: 8),
              Text(
                controller.schools.first.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      }

      // Multiple schools - show dropdown
      return Container(
        padding: compact ? const EdgeInsets.symmetric(horizontal: 8) : null,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<SchoolOrganzationModel>(
            value: controller.selectedSchool.value,
            isExpanded: true,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
            dropdownColor: Colors.white,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            hint: const Text(
              'Select School',
              style: TextStyle(color: Colors.grey),
            ),
            items: controller.schools.map((school) {
              return DropdownMenuItem<SchoolOrganzationModel>(
                value: school,

                child: Row(
                  children: [
                    Icon(
                      Icons.school,
                      color: TemarLijeColors.primary,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            school.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (!compact) ...[
                            Text(
                              'Code: ${school.tenantCode}',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    if (controller.selectedSchool.value?.id == school.id)
                      Icon(
                        Icons.check,
                        color: TemarLijeColors.success,
                        size: 16,
                      ),
                  ],
                ),
              );
            }).toList(),
            onChanged: (school) {
              if (school != null) {
                controller.selectSchool(school);
              }
            },
          ),
        ),
      );
    });
  }
}
