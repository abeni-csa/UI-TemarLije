import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ui_temarlije/common/widgets/images/t_circular_image.dart';
import 'package:ui_temarlije/common/widgets/layouts/sidebar/menu_items.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';
import 'package:ui_temarlije/routes/routes.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';
import 'package:ui_temarlije/utils/constants/image_strings.dart';

class TemarLijeSidebar extends StatelessWidget {
  const TemarLijeSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const BeveledRectangleBorder(),
      child: Container(
        decoration: const BoxDecoration(
          color: TemarLijeColors.white,
          border: Border(
            right: BorderSide(color: TemarLijeColors.grey, width: 1),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const TemarLijeCircularImage(
                width: 100,
                height: 100,
                image: TemarLijeImagesStrings.darkAppLogo,
                backgroundColor: Colors.transparent,
              ),
              const SizedBox(height: TemarLijeSizes.spaceBtwSections),
              Padding(
                padding: const EdgeInsetsGeometry.all(TemarLijeSizes.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Memu Items
                    TemarLijeMenuItem(
                      route: TemarLijeRoutes.siteRoot,
                      icon: Iconsax.music_dashboard,
                      itemName: "Desktop",
                    ),
                    TemarLijeMenuItem(
                      route: TemarLijeRoutes.siteRoot,
                      icon: Iconsax.cloud_connection,
                      itemName: "NetWorking",
                    ),
                    TemarLijeMenuItem(
                      route: TemarLijeRoutes.markListPage,
                      icon: Iconsax.data,
                      itemName: "Marklist",
                    ),

                    /// TODO add Lesson Planare If eelx to Show THis path based on User Type
                    TemarLijeMenuItem(
                      route: TemarLijeRoutes.toolLessonPlaner,
                      icon: Iconsax.add_circle,
                      itemName: "Lesson Planner",
                    ),
                    TemarLijeMenuItem(
                      route: TemarLijeRoutes.markListPage,
                      icon: Iconsax.menu_board,
                      itemName: "Fee",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
