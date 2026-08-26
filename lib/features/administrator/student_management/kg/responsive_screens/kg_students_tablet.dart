import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/features/administrator/teacher_management/all/all_teacher_controller.dart';
import 'package:ui_temarlije/features/administrator/teacher_management/all/table/data_table.dart';
import 'package:ui_temarlije/common/widgets/containers/rounded_container.dart';
import 'package:ui_temarlije/common/widgets/data_table/table_header.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';
import 'package:ui_temarlije/routes/routes.dart';

class KgStudentsTabletScreen extends StatelessWidget {
  const KgStudentsTabletScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final AllTeacherController controller = Get.find<AllTeacherController>();

    return Obx(
      () => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TemarLijeSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Table Body
              TemarLijeRoundedContainer(
                child: Column(
                  children: [
                    TemarLijeDataTableHeader(
                      showLeftWidget: false,
                      buttonText: 'Add Teacher',
                      onPress: () {
                        // Navigate to create teacher screen
                        Get.toNamed(TemarLijeRoutes.teacherDetails);
                      },
                    ),
                    const SizedBox(height: TemarLijeSizes.sm),

                    // Show loading indicator or error message
                    if (controller.isLoading.value &&
                        controller.teachers.isEmpty)
                      const Padding(
                        padding: EdgeInsets.all(32.0),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    else if (controller.errorMessage.value.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Center(
                          child: Text(
                            'Error: ${controller.errorMessage.value}',
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      )
                    else if (controller.teachers.isEmpty)
                      const Padding(
                        padding: EdgeInsets.all(32.0),
                        child: Center(child: Text('No teachers found')),
                      )
                    else
                      const AllTeachersDataTable(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// jburak
