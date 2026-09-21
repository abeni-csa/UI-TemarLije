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
    final specializations = teacher.specialization;
    final certificates = teacher.specialization;
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
        color: TemarLijeColors.primary.withAlpha(50),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: TemarLijeColors.primary.withAlpha(30)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star,
            size: 16,
            color: TemarLijeColors.primary.withAlpha(244),
          ),
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
        color: TemarLijeColors.primaryBackground.withAlpha(20),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: TemarLijeColors.primary.withAlpha(20)),
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
                if (certificate != null)
                  Text(
                    'Issued by: $certificate',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                if (certificate != null)
                  Text(
                    'Year: $certificate',
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
