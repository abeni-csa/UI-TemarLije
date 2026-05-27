import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ui_temarlije/common/widgets/containers/rounded_container.dart';
import 'package:ui_temarlije/common/widgets/texts/section_heading.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class AccountTypeCard extends StatelessWidget {
  const AccountTypeCard({
    super.key,
    required this.title,
    required this.icon,
    required this.action,
  });
  final String title;
  final VoidCallback action;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280, // Fixed width for desktop cards
      child: TemarLijeRoundedContainer(
        showBorder: true,
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
                  child: ElevatedButton(
                    onPressed: action,

                    child: Text(
                      "Create Profile",
                      style: Theme.of(context).textTheme.headlineMedium!.apply(
                        color: TemarLijeColors.white,
                      ),

                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
