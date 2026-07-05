import 'package:get/get.dart';
import 'package:ui_temarlije/routes/routes.dart';
import 'package:ui_temarlije/utils/device/device_utility.dart';

class SidebarController extends GetxController {
  final activeItem = TemarLijeRoutes.dashbord.obs;
  final hoverItem = ''.obs;
  final expandedMenus = <String>{}.obs; // Track expanded submenus

  void changeActiveItems(String route) => activeItem.value = route;

  void changeHoverItems(String route) {
    if (!isActive(route)) hoverItem.value = route;
  }

  bool isActive(String route) => activeItem.value == route;
  bool isHovering(String route) => activeItem.value == route;

  void menuOnTab(String route) {
    if (!isActive(route)) {
      changeActiveItems(route);
      if (TemarLijeDeviceUtils.isMobileScreen(Get.context!)) Get.back();
      Get.toNamed(route);
    }
  }

  // Updated toggleExpanded to auto-close other dropdowns
  void toggleExpanded(String parentRoute) {
    // If the clicked menu is already expanded, collapse it
    if (expandedMenus.contains(parentRoute)) {
      expandedMenus.remove(parentRoute);
    } else {
      // Close all other expanded menus and open only the clicked one
      expandedMenus.clear();
      expandedMenus.add(parentRoute);
    }
  }

  bool isExpanded(String parentRoute) => expandedMenus.contains(parentRoute);
}
