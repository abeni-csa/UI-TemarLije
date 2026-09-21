import 'package:flutter/material.dart';
import 'package:ui_temarlije/common/widgets/containers/rounded_container.dart';
import 'package:ui_temarlije/data/models/teacher.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';
import 'package:ui_temarlije/utils/device/device_utility.dart';
import 'package:ui_temarlije/utils/helpers/helper_functions.dart';

class BasicTeacherInfo extends StatelessWidget {
  const BasicTeacherInfo({super.key, required this.teacher});
  final Teacher teacher;

  @override
  Widget build(BuildContext context) {
    return TemarLijeRoundedContainer(
      padding: const EdgeInsets.all(TemarLijeSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Basic Info", style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: TemarLijeSizes.spaceBtwSections),

          // Responsive grid for basic info
          LayoutBuilder(
            builder: (context, constraints) {
              final bool isMobile = TemarLijeDeviceUtils.isMobileScreen(
                context,
              );

              if (isMobile) {
                return Column(children: _buildInfoItems(context));
              }

              return Wrap(
                // spacing: isMobile ? TemarLijeSizes.sm : TemarLijeSizes.lg,
                spacing: TemarLijeSizes.sm,
                runSpacing: TemarLijeSizes.spaceBtwItems,
                children: _buildInfoItems(context),
              );
            },
          ),
        ],
      ),
    );
  }

  List<Widget> _buildInfoItems(BuildContext context) {
    return [
      _buildInfoCard(
        context,
        label: 'Date of Birth',
        value: teacher.dateOfBirth.toString(),
        icon: Icons.cake,
      ),
      _buildInfoCard(
        context,
        label: 'Specializations',
        value: '${teacher.specialization.length} specializations',
        icon: Icons.school,
      ),
      _buildInfoCard(
        context,
        label: 'Employment Type',
        value: teacher.employmentType.name.toUpperCase(),
        icon: Icons.work,
        color: TemarLijeHelperFunctions.getEmploymentTypeColor(
          teacher.employmentType,
        ),
      ),
      _buildInfoCard(
        context,
        label: 'Years of Experience',
        value: '${teacher.yearsOfExperience} years',
        icon: Icons.timeline,
      ),
      _buildInfoCard(
        context,
        label: 'Gender',
        value: teacher.gender,
        icon: teacher.gender.toLowerCase() == 'male'
            ? Icons.male
            : Icons.female,
        color: teacher.gender.toLowerCase() == 'male'
            ? Colors.blue
            : Colors.pink,
      ),
      _buildInfoCard(
        context,
        label: 'Phone',
        value: teacher.phoneNumber,
        icon: Icons.phone,
      ),
    ];
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required String label,
    required String value,
    required IconData icon,
    Color? color,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: TemarLijeColors.primaryBackground.withAlpha(60),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: color ?? TemarLijeColors.primary),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: TemarLijeColors.darkContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  value,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
