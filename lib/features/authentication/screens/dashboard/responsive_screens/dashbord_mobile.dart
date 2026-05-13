import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';
import 'package:ui_temarlije/features/users/controllers/principal_controller.dart';

class DashboardMobile extends StatelessWidget {
  const DashboardMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final PrincipalController controller = Get.isRegistered<PrincipalController>()
        ? Get.find<PrincipalController>()
        : Get.put(PrincipalController());

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(TemarLijeSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Dashboard", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Obx(() {
              final p = controller.currentPrincipal.value;
              if (controller.isLoading.value) return const Center(child: CircularProgressIndicator());
              if (p == null) return const Text('No principal data available');

              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(child: Text(p.firstName.isNotEmpty ? p.firstName[0] : '?')),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(p.fullNameformated, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                                const SizedBox(height: 4),
                                Text(p.position),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      Text('Staff ID: ${p.staffId}'),
                      Text('Department: ${p.department}'),
                      Text('Employment: ${p.employmentType}'),
                      Text('Hire date: ${p.hireDate}'),
                      const SizedBox(height: 8),
                      Text('Address: ${p.addressInfo.fullAddress}'),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: [
                          if (p.canManageUsers) Chip(label: const Text('Manage Users')),
                          if (p.canManageFinances) Chip(label: const Text('Manage Finances')),
                          if (p.canManageAcademics) Chip(label: const Text('Manage Academics')),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
