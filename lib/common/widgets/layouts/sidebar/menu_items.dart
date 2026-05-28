import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
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

    this.children = const [], // Submenu items
    this.isSubmenu = false, // Flag for submenu styling
  });
  final String route;
  final IconData icon;
  final String itemName;
  final List<TemarLijeMenuItem> children;
  final bool isSubmenu;

  @override
  Widget build(BuildContext context) {
    final menuController = Get.find<SidebarController>();

    // If there are children, return an expandable menu item
    if (children.isNotEmpty) {
      return Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Parent menu item with expand/collapse
            InkWell(
              onTap: () => menuController.toggleExpanded(route),
              onHover: (hovering) => hovering
                  ? menuController.changeHoverItems(route)
                  : menuController.changeHoverItems(''),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: TemarLijeSizes.xs - 2,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color:
                        menuController.isHovering(route) ||
                            menuController.isActive(route)
                        ? TemarLijeColors.primary
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(
                      TemarLijeSizes.cardRadiusMd,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // ICON
                      Padding(
                        padding: EdgeInsets.only(
                          left: isSubmenu
                              ? TemarLijeSizes.xs
                              : TemarLijeSizes.xs,
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
                      Expanded(
                        child: Text(
                          itemName,
                          style: Theme.of(context).textTheme.bodySmall!.apply(
                            color:
                                menuController.isHovering(route) ||
                                    menuController.isActive(route)
                                ? TemarLijeColors.white
                                : TemarLijeColors.darkGrey,
                          ),
                        ),
                      ),
                      // Expand/Collapse Icon
                      Padding(
                        padding: const EdgeInsets.only(
                          right: TemarLijeSizes.xs,
                        ),
                        child: Icon(
                          menuController.isExpanded(route)
                              ? Iconsax.arrow_up_2
                              : Iconsax.arrow_down_1,
                          size: 18,
                          color:
                              menuController.isHovering(route) ||
                                  menuController.isActive(route)
                              ? TemarLijeColors.white
                              : TemarLijeColors.darkGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Submenu items
            if (menuController.isExpanded(route))
              Padding(
                padding: const EdgeInsets.only(left: TemarLijeSizes.sm),
                child: Column(
                  children: children.map((child) => child).toList(),
                ),
              ),
          ],
        ),
      );
    }

    // Regular menu item (no children)
    return InkWell(
      onTap: () => menuController.menuOnTab(route),
      onHover: (hovering) => hovering
          ? menuController.changeHoverItems(route)
          : menuController.changeHoverItems(''),
      child: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(vertical: TemarLijeSizes.xs),
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
                    left: isSubmenu ? TemarLijeSizes.xl : TemarLijeSizes.lg,
                    top: TemarLijeSizes.xs,
                    right: TemarLijeSizes.xs,
                    bottom: TemarLijeSizes.xs,
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
                Flexible(
                  child: Text(
                    itemName,
                    style: Theme.of(context).textTheme.bodySmall!.apply(
                      color:
                          menuController.isHovering(route) ||
                              menuController.isActive(route)
                          ? TemarLijeColors.white
                          : TemarLijeColors.darkGrey,
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
