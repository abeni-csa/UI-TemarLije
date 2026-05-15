import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/features/users/controllers/principal_controller.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class DashboardDesktopScreen extends StatelessWidget {
  const DashboardDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PrincipalController controller =
        Get.isRegistered<PrincipalController>()
        ? Get.find<PrincipalController>()
        : Get.put(PrincipalController());

    return Obx(() {
      final p = controller.currentPrincipal.value;
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (p == null) return const Center(child: Text('No principal data'));

      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            p.fullNameformated,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text('${p.position} • ${p.department}'),
                          const SizedBox(height: 12),
                          Text('Staff ID: ${p.staffId}'),
                          Text('Employment: ${p.employmentType}'),
                          const SizedBox(height: 12),
                          Text('Address: ${p.addressInfo.fullAddress}'),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        child: Text(
                          p.firstName.isNotEmpty ? p.firstName[0] : '?',
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        children: [
                          if (p.canManageUsers)
                            Chip(label: const Text('Users')),
                          if (p.canManageFinances)
                            Chip(label: const Text('Finances')),
                          if (p.canManageAcademics)
                            Chip(label: const Text('Academics')),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Text(
            "Data Table 2",
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      );
    });
  }
}
