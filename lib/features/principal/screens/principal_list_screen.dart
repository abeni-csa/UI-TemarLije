import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ui_temarlije/features/principal/screens/principal_form_screen.dart';
import 'package:ui_temarlije/features/principal/widgets/principal_card.dart';
import 'package:ui_temarlije/features/users/controllers/principal_controller.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class PrincipalListScreen extends StatelessWidget {
  const PrincipalListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PrincipalController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Principals'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Get.to(() => const PrincipalFormScreen()),
            icon: const Icon(Iconsax.add),
            tooltip: 'Add Principal',
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(TemarLijeSizes.defaultSpace),
            child: TextField(
              controller: controller.searchController,
              onChanged: (value) {
                controller.updateSearchQuery(value);
                controller.searchPrincipals();
              },
              decoration: InputDecoration(
                hintText: 'Search by name or staff ID...',
                prefixIcon: const Icon(Iconsax.search_normal),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    TemarLijeSizes.borderRadiusLg,
                  ),
                ),
              ),
            ),
          ),

          // List of Principals
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value && controller.principals.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.principals.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Iconsax.profile_2user,
                        size: 64,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No principals found',
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 8),
                      if (controller.searchQuery.value.isNotEmpty)
                        TextButton(
                          onPressed: () {
                            controller.searchController.clear();
                            controller.updateSearchQuery('');
                            controller.searchPrincipals();
                          },
                          child: const Text('Clear search'),
                        ),
                    ],
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () => controller.fetchAllPrincipals(),
                child: NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (!controller.isLoading.value &&
                        controller.hasMoreData.value &&
                        scrollInfo.metrics.pixels ==
                            scrollInfo.metrics.maxScrollExtent) {
                      controller.fetchAllPrincipals();
                    }
                    return true;
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: TemarLijeSizes.defaultSpace,
                    ),
                    itemCount:
                        controller.principals.length +
                        (controller.hasMoreData.value ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == controller.principals.length) {
                        return const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      final principal = controller.principals[index];
                      return PrincipalCard(principal: principal);
                    },
                  ),
                ),
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const PrincipalFormScreen()),
        child: const Icon(Iconsax.add),
      ),
    );
  }
}
