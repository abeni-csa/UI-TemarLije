import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ui_temarlije/data/models/principal_user.dart';
import 'package:ui_temarlije/features/principal/screens/principal_form_screen.dart';
import 'package:ui_temarlije/features/users/controllers/principal_controller.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class PrincipalCard extends StatelessWidget {
  final PrincipalUser principal;
  const PrincipalCard({super.key, required this.principal});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PrincipalController>();

    return Card(
      margin: const EdgeInsets.only(bottom: TemarLijeSizes.spaceBtwItems),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(TemarLijeSizes.borderRadiusLg),
      ),
      child: InkWell(
        onTap: () => Get.to(() => ()),
        borderRadius: BorderRadius.circular(TemarLijeSizes.borderRadiusLg),
        child: Padding(
          padding: const EdgeInsets.all(TemarLijeSizes.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: TemarLijeColors.primary,
                    child: Text(
                      principal.firstName[0].toUpperCase(),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: TemarLijeColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: TemarLijeSizes.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          principal.firstName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Staff ID: ${principal.staffId}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          principal.employmentType,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') {
                        Get.to(() => PrincipalFormScreen(principal: principal));
                      } else if (value == 'delete') {
                        controller.deletePrincipal(principal.id);
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(Iconsax.edit, size: 18),
                            SizedBox(width: 8),
                            Text('Edit'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Iconsax.trash, size: 18, color: Colors.red),
                            SizedBox(width: 8),
                            Text('Delete', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: TemarLijeSizes.sm),
              const Divider(),
              const SizedBox(height: TemarLijeSizes.sm),
              Row(
                children: [
                  Expanded(
                    child: _buildInfoChip(
                      Iconsax.building,
                      principal.department.substring(0, 8),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildInfoChip(
                      Iconsax.briefcase,
                      principal.position.substring(0, 8),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildInfoChip(
                      Iconsax.location,
                      principal.addressInfo.city,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(TemarLijeSizes.borderRadiusMd),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.grey[600]),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              label,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
