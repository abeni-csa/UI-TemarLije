import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ui_temarlije/common/widgets/containers/rounded_container.dart';
import 'package:ui_temarlije/common/widgets/texts/section_heading.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class DashboardDesktopScreen extends StatelessWidget {
  const DashboardDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Remove Scaffold - DesktopLayout already provides the structure
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Dashboard",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: TemarLijeSizes.spaceBtwItems),
            // Use Expanded or flexible layouts for responsive cards
            LayoutBuilder(
              builder: (context, constraints) {
                return Wrap(
                  spacing: TemarLijeSizes.spaceBtwItems,
                  runSpacing: TemarLijeSizes.spaceBtwItems,
                  children: [
                    // Sales Card
                    _buildMetricCard(
                      context,
                      title: "Sales",
                      value: "ETB 232,500",
                      percentage: "+25%",
                      isPositive: true,
                      icon: Iconsax.shopping_cart,
                    ),
                    // You can add more cards here
                    _buildMetricCard(
                      context,
                      title: "Sales",
                      value: "ETB 232,500",
                      percentage: "+25%",
                      isPositive: true,
                      icon: Iconsax.shopping_cart,
                    ),
                    _buildMetricCard(
                      context,
                      title: "Sales",
                      value: "ETB 232,500",
                      percentage: "-10%",
                      isPositive: false,
                      icon: Iconsax.shopping_cart,
                    ),
                    _buildMetricCard(
                      context,
                      title: "Sales",
                      value: "ETB 232,500",
                      percentage: "+25%",
                      isPositive: true,
                      icon: Iconsax.shopping_cart,
                    ),
                    _buildMetricCard(
                      context,
                      title: "Sales",
                      value: "ETB 232,500",
                      percentage: "+25%",
                      isPositive: true,
                      icon: Iconsax.shopping_cart,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(
    BuildContext context, {
    required String title,
    required String value,
    required String percentage,
    required bool isPositive,
    required IconData icon,
  }) {
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
