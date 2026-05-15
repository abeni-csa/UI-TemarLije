import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ui_temarlije/data/models/principal_user.dart';
import 'package:ui_temarlije/features/principal/screens/principal_form_screen.dart';
import 'package:ui_temarlije/features/users/controllers/principal_controller.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class PrincipalDetailScreen extends StatelessWidget {
  final PrincipalUser principal;
  const PrincipalDetailScreen({super.key, required this.principal});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PrincipalController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(principal.firstName),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Iconsax.edit),
            onPressed: () =>
                Get.to(() => PrincipalFormScreen(principal: principal)),
          ),
          IconButton(
            icon: const Icon(Iconsax.trash, color: Colors.red),
            onPressed: () => controller.deletePrincipal(principal.id),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TemarLijeSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: TemarLijeColors.primary,
                    child: Text(
                      principal.firstName[0].toUpperCase(),
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: TemarLijeColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: TemarLijeSizes.md),
                  Text(
                    principal.firstName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: TemarLijeColors.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      principal.staffType,
                      style: const TextStyle(
                        color: TemarLijeColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: TemarLijeSizes.spaceBtwSections),

            // Personal Information
            _buildSection('Personal Information', Iconsax.user, [
              _buildDetailRow('Staff ID', principal.staffId),
              _buildDetailRow('First Name', principal.firstName),
              if (principal.middleName != null)
                _buildDetailRow('Middle Name', principal.middleName!),
              _buildDetailRow('Last Name', principal.lastName),
              _buildDetailRow('Date of Birth', principal.dateOfBirth),
            ]),

            const SizedBox(height: TemarLijeSizes.spaceBtwSections),

            // Employment Information
            _buildSection('Employment Information', Iconsax.briefcase, [
              _buildDetailRow('Department ID', principal.department),
              _buildDetailRow('Position ID', principal.position),
              _buildDetailRow('Employment Type', principal.employmentType),
              _buildDetailRow('Hire Date', principal.hireDate),
            ]),

            const SizedBox(height: TemarLijeSizes.spaceBtwSections),

            // Address Information
            _buildSection('Address Information', Iconsax.location, [
              _buildDetailRow('Region', principal.addressInfo.region),
              _buildDetailRow('Zone', principal.addressInfo.zone),
              _buildDetailRow('City', principal.addressInfo.city),
              _buildDetailRow('Kebele No', principal.addressInfo.kebeleNo),
            ]),

            const SizedBox(height: TemarLijeSizes.spaceBtwSections),

            // Permissions
            _buildSection('Permissions', Iconsax.shield, [
              _buildPermissionRow('Manage Users', principal.canManageUsers),
              _buildPermissionRow(
                'Manage Finances',
                principal.canManageFinances,
              ),
              _buildPermissionRow(
                'Manage Academics',
                principal.canManageAcademics,
              ),
            ]),

            const SizedBox(height: TemarLijeSizes.spaceBtwSections),

            // Metadata
            _buildSection('System Information', Iconsax.information, [
              _buildDetailRow('Created At', _formatDate(principal.createdAt)),
              _buildDetailRow('Updated At', _formatDate(principal.updatedAt)),
            ]),

            const SizedBox(height: TemarLijeSizes.spaceBtwSections),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, IconData icon, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: TemarLijeColors.primary),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: TemarLijeSizes.spaceBtwItems),
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(TemarLijeSizes.borderRadiusLg),
            side: BorderSide(color: Colors.grey[200]!),
          ),
          child: Padding(
            padding: const EdgeInsets.all(TemarLijeSizes.md),
            child: Column(children: children),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionRow(String label, bool value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            value ? Iconsax.tick_circle : Iconsax.close_circle,
            color: value ? Colors.green : Colors.red,
            size: 20,
          ),
          const SizedBox(width: 12),
          Text(label),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}
