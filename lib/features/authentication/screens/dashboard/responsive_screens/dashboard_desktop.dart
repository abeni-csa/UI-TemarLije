import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ui_temarlije/common/widgets/card/dashboard_card.dart';
import 'package:ui_temarlije/common/widgets/containers/rounded_container.dart';
import 'package:ui_temarlije/common/widgets/texts/section_heading.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class DashboardDesktopScreen extends StatelessWidget {
  const DashboardDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    TemarLijeDashboardCard(
                      title: "Sales",
                      value: "ETB 232,500",
                      percentage: "+25%",
                      isPositive: true,
                      icon: Iconsax.shopping_cart,
                    ),
                    // You can add more cards here
                    TemarLijeDashboardCard(
                      title: "Sales",
                      value: "ETB 232,500",
                      percentage: "+25%",
                      isPositive: true,
                      icon: Iconsax.shopping_cart,
                    ),
                    TemarLijeDashboardCard(
                      title: "Sales",
                      value: "ETB 232,500",
                      percentage: "-10%",
                      isPositive: false,
                      icon: Iconsax.shopping_cart,
                    ),
                    TemarLijeDashboardCard(
                      title: "Sales",
                      value: "ETB 232,500",
                      percentage: "+25%",
                      isPositive: true,
                      icon: Iconsax.shopping_cart,
                    ),
                    TemarLijeDashboardCard(
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
}
