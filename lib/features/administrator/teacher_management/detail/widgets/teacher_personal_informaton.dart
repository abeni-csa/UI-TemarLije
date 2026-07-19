// import 'package:flutter/material.dart';
// import 'package:ui_temarlije/common/widgets/containers/rounded_container.dart';
// import 'package:ui_temarlije/data/models/teacher.dart';
// import 'package:ui_temarlije/utils/constants/sizes.dart';

// class TeacherPersonalInformaton extends StatelessWidget {
//   const TeacherPersonalInformaton({super.key, required this.teacher});
//   final Teacher teacher;
//   @override
//   Widget build(BuildContext context) {
//     return TemarLijeRoundedContainer(
//       padding: const EdgeInsets.all(TemarLijeSizes.defaultSpace),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Personal Information",
//             style: Theme.of(context).textTheme.headlineMedium,
//           ),
//           const SizedBox(height: TemarLijeSizes.spaceBtwSections),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:ui_temarlije/common/widgets/containers/rounded_container.dart';
import 'package:ui_temarlije/data/models/teacher.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class TeacherPersonalInformation extends StatelessWidget {
  const TeacherPersonalInformation({super.key, required this.teacher});
  final Teacher teacher;

  @override
  Widget build(BuildContext context) {
    return TemarLijeRoundedContainer(
      padding: const EdgeInsets.all(TemarLijeSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Personal Information",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: TemarLijeSizes.spaceBtwSections),

          // Personal info items
          _buildPersonalInfoItem(
            context,
            label: 'Full Name',
            value: teacher.fullName ?? 'N/A',
            icon: Icons.person,
          ),
          const SizedBox(height: TemarLijeSizes.spaceBtwItems),

          _buildPersonalInfoItem(
            context,
            label: 'Email',
            value: teacher.middleName ?? 'N/A',
            icon: Icons.email,
          ),
          const SizedBox(height: TemarLijeSizes.spaceBtwItems),

          _buildPersonalInfoItem(
            context,
            label: 'Address',
            value: teacher.createdAt ?? 'N/A',
            icon: Icons.location_on,
            multiline: true,
          ),
          const SizedBox(height: TemarLijeSizes.spaceBtwItems),

          _buildPersonalInfoItem(
            context,
            label: 'Nationality',
            value: teacher.phoneNumber ?? 'N/A',
            icon: Icons.flag,
          ),
          const SizedBox(height: TemarLijeSizes.spaceBtwItems),

          _buildPersonalInfoItem(
            context,
            label: 'Religion',
            value: teacher.updatedAt ?? 'N/A',
            icon: Icons.church,
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfoItem(
    BuildContext context, {
    required String label,
    required String value,
    required IconData icon,
    bool multiline = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: TemarLijeColors.primaryBackground.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: multiline
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 20, color: TemarLijeColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: Theme.of(context).textTheme.labelSmall),
                Text(
                  value,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
                  maxLines: multiline ? 3 : 1,
                  overflow: multiline
                      ? TextOverflow.ellipsis
                      : TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
