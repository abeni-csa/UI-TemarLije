import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:navigation_rail_flutter/navigation_rail_flutter.dart';
import 'package:ui_temarlije/common/widgets/layouts/sidebar/sidebar_controller.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';
import 'package:get/get.dart';

class TemarLijeMenuItem extends StatelessWidget {
  const TemarLijeMenuItem({
    super.key,
    required this.route,
    required this.icon,
    required this.itemName,
  });
  final String route;
  final IconData icon;
  final String itemName;
  @override
  Widget build(BuildContext context) {
    final menuController = Get.put(SidebarController());
    return InkWell(
      onTap: () => menuController.menuOnTab(route),
      onHover: (hovering) => hovering
          ? menuController.changeHoverItems(route)
          : menuController.changeHoverItems(''),
      child: Obx(
        () => Padding(
          padding: const EdgeInsetsGeometry.symmetric(
            vertical: TemarLijeSizes.xs,
          ),
          child: Container(
            decoration: BoxDecoration(
              color:
                  menuController.isHovering(route) ||
                      menuController.isActive(route)
                  ? TemarLijeColors.primary
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(TemarLijeSizes.cardRadiusMd),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ICON
                Padding(
                  padding: EdgeInsets.only(
                    left: TemarLijeSizes.lg,
                    top: TemarLijeSizes.md,
                    right: TemarLijeSizes.md,
                    bottom: TemarLijeSizes.md,
                  ),
                  child: menuController.isActive(route)
                      ? Icon(icon, size: 22, color: TemarLijeColors.white)
                      : Icon(
                          icon,
                          color: menuController.isHovering(route)
                              ? TemarLijeColors.white
                              : TemarLijeColors.darkGrey,
                        ),
                ),
                // Text
                if (menuController.isHovering(route) ||
                    menuController.isActive(route))
                  Flexible(
                    child: Text(
                      itemName,
                      style: Theme.of(context).textTheme.bodySmall!.apply(
                        color: TemarLijeColors.white,
                      ),
                    ),
                  )
                else
                  Flexible(
                    child: Text(
                      itemName,
                      style: Theme.of(context).textTheme.bodySmall!.apply(
                        color: TemarLijeColors.darkGrey,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
