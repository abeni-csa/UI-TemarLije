// import 'package:flutter/material.dart';
// import 'package:ui_temarlije/common/widgets/containers/rounded_container.dart';
// import 'package:ui_temarlije/data/models/teacher.dart';
// import 'package:ui_temarlije/utils/constants/sizes.dart';

// class TeacherCertificateEducationBackgroundInfo extends StatelessWidget {
//   const TeacherCertificateEducationBackgroundInfo({
//     super.key,
//     required this.teacher,
//   });
//   final Teacher teacher;

//   @override
//   Widget build(BuildContext context) {
//     // final totalSpecilaizationAndCert = teacher.specialization.fold(
//     //   0,
//     //   (previousValue, elemet) => previousValue + elemet.length,
//     // );
//     return TemarLijeRoundedContainer(
//       padding: const EdgeInsets.all(TemarLijeSizes.defaultSpace),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Certificate And Specilaziation",
//             style: Theme.of(context).textTheme.headlineMedium,
//           ),
//           const SizedBox(height: TemarLijeSizes.spaceBtwSections),

//           ListView.separated(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             separatorBuilder: (_, _) =>
//                 const SizedBox(height: TemarLijeSizes.spaceBtwItems),
//             itemCount: teacher.specialization.length,

//             itemBuilder: (BuildContext context, int index) {
//               // final sp = teacher.specialization[index];
//               return Row(
//                 children: [
//                   Expanded(
//                     child: Row(
//                       children: [
//                         //  TemarLijeRoundedImage(imageType: imageType, backgroundColor: TemarLijeColors.primaryBackground,)
//                         const SizedBox(height: TemarLijeSizes.spaceBtwItems),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 teacher.specialization[index],
//                                 style: Theme.of(context).textTheme.bodyMedium,
//                                 overflow: TextOverflow.ellipsis,
//                                 maxLines: 1,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
// features/administrator/teacher_management/detail/widgets/certificate_education_background_info.dart
import 'package:flutter/material.dart';
import 'package:ui_temarlije/common/widgets/containers/rounded_container.dart';
import 'package:ui_temarlije/data/models/teacher.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class TeacherCertificateEducationBackgroundInfo extends StatelessWidget {
  const TeacherCertificateEducationBackgroundInfo({
    super.key,
    required this.teacher,
  });
  final Teacher teacher;

  @override
  Widget build(BuildContext context) {
    final specializations = teacher.specialization ?? [];
    final certificates = teacher.specialization ?? [];
    final hasData = specializations.isNotEmpty || certificates.isNotEmpty;

    return TemarLijeRoundedContainer(
      padding: const EdgeInsets.all(TemarLijeSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Certificates & Specializations",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: TemarLijeSizes.spaceBtwSections),

          if (!hasData)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'No certificates or specializations recorded',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                ),
              ),
            )
          else ...[
            // Specializations
            if (specializations.isNotEmpty) ...[
              Text(
                'Specializations (${specializations.length})',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: TemarLijeSizes.spaceBtwItems),
              ...specializations.map((spec) => _buildTag(context, spec)),
              const SizedBox(height: TemarLijeSizes.spaceBtwSections),
            ],

            // Certificates
            if (certificates.isNotEmpty) ...[
              Text(
                'Certificates (${certificates.length})',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: TemarLijeSizes.spaceBtwItems),
              ...certificates.map(
                (cert) => _buildCertificateCard(context, cert),
              ),
            ],
          ],
        ],
      ),
    );
  }

  Widget _buildTag(BuildContext context, String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: TemarLijeColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: TemarLijeColors.primary.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star, size: 16, color: TemarLijeColors.primary),
          const SizedBox(width: 8),
          Text(
            text,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildCertificateCard(BuildContext context, dynamic certificate) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: TemarLijeColors.primaryBackground.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: TemarLijeColors.primary.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(Icons.verified, color: Colors.green.shade700),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  certificate ?? 'Certificate',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
                if (certificate.issuer != null)
                  Text(
                    'Issued by: ${certificate.issuer}',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                if (certificate.year != null)
                  Text(
                    'Year: ${certificate.year}',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
