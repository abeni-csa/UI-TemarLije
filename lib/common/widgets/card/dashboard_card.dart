import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ui_temarlije/common/widgets/containers/rounded_container.dart';
import 'package:ui_temarlije/common/widgets/texts/section_heading.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class TemarLijeDashboardCard extends StatelessWidget {
  const TemarLijeDashboardCard({
    super.key,

    required this.title,
    required this.value,
    required this.percentage,
    required this.isPositive,
    required this.icon,
  });
  final String title;
  final String value;
  final String percentage;
  final bool isPositive;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280, // Fixed width for desktop cards
      child: TemarLijeRoundedContainer(
        padding: const EdgeInsets.all(TemarLijeSizes.spaceBtwSections),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TemarLijeSectionHeading(
                  title: title,
                  textColor: TemarLijeColors.textSecondary,
                ),
                Icon(icon, size: 24, color: TemarLijeColors.primary),
              ],
            ),
            const SizedBox(height: TemarLijeSizes.spaceBtwSections),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    value,
                    style: Theme.of(context).textTheme.headlineMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isPositive ? Iconsax.arrow_up_3 : Iconsax.arrow_down,
                      size: 16,
                      color: isPositive
                          ? TemarLijeColors.success
                          : TemarLijeColors.error,
                    ),
                    Text(
                      percentage,
                      style: Theme.of(context).textTheme.titleSmall!.apply(
                        color: isPositive
                            ? TemarLijeColors.success
                            : TemarLijeColors.error,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
