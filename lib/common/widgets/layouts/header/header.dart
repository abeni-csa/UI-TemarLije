import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ui_temarlije/common/widgets/images/t_rounded_image.dart';
import 'package:ui_temarlije/common/widgets/layouts/header/school_selector.dart';
import 'package:ui_temarlije/features/authentication/controllers/login_controller.dart';
import 'package:ui_temarlije/features/authentication/controllers/principal_controller.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';
import 'package:ui_temarlije/utils/constants/enums.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';
import 'package:ui_temarlije/utils/constants/image_strings.dart';
import 'package:ui_temarlije/utils/constants/text_string.dart';
import 'package:ui_temarlije/utils/device/device_utility.dart';

class TemarLijeHeader extends StatelessWidget implements PreferredSizeWidget {
  const TemarLijeHeader({super.key, this.scaffoldKey});

  /// GlobalKey To Access the Scaffold state
  final GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<PrincipalController>()
        ? Get.find<PrincipalController>()
        : Get.put(PrincipalController());
    final logoutController = Get.isRegistered<LoginController>()
        ? Get.find<LoginController>()
        : Get.put(LoginController());
    return Container(
      decoration: const BoxDecoration(
        color: TemarLijeColors.textWhite,
        border: Border(
          bottom: BorderSide(color: TemarLijeColors.grey, width: 1),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: TemarLijeSizes.md,
        vertical: TemarLijeSizes.sm,
      ),
      child: AppBar(
        backgroundColor: TemarLijeColors.lightContainer,
        // Mobile Menu
        leading: !TemarLijeDeviceUtils.isDesktopScreen(context)
            ? IconButton(
                onPressed: () => scaffoldKey?.currentState?.openDrawer(),
                icon: Icon(Iconsax.menu),
              )
            : null,

        title: TemarLijeDeviceUtils.isDesktopScreen(context)
            ? const SchoolSelector()
            : null,
        // Actions
        actions: [
          if (!TemarLijeDeviceUtils.isDesktopScreen(context))
            IconButton(
              icon: const Icon(Iconsax.search_normal),
              onPressed: () {},
            ),
          IconButton(icon: const Icon(Iconsax.notification), onPressed: () {}),
          const SizedBox(width: TemarLijeSizes.spaceBtwItems / 2),
          // User Profile Section with Dropdown
          Obx(() {
            final p = controller.currentPrincipal.value;
            final title = p != null && p.fullName.isNotEmpty
                ? p.fullName
                : TemarLijeTexts.firstName;
            final subtitle = p != null && p.staffId.isNotEmpty
                ? p.staffId
                : TemarLijeTexts.adminEmail;

            return PopupMenuButton<String>(
              color: TemarLijeColors.lightBackground,
              offset: const Offset(0, 10),
              position: PopupMenuPosition.under,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Image
                  const TemarLijeRoundedImage(
                    width: 40,
                    padding: 2,
                    height: 40,
                    imageType: ImageType.asset,
                    image: TemarLijeImagesStrings.user,
                  ),
                  const SizedBox(width: TemarLijeSizes.spaceBtwItems / 2),
                  // Name And Email (dynamic)
                  if (!TemarLijeDeviceUtils.isMobileScreen(context))
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: TemarLijeColors.textPrimary,
                          ),
                        ),
                        Text(
                          subtitle,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            color: TemarLijeColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  const Icon(Icons.keyboard_arrow_down, size: 20),
                ],
              ),
              onSelected: (value) async {
                if (value == 'logout') {
                  // Handle logout
                  logoutController.logout();
                } else if (value == 'profile') {
                  // Navigate to profile
                  Get.toNamed('/profile');
                } else if (value == 'settings') {
                  // Navigate to settings
                  Get.toNamed('/settings');
                }
              },
              itemBuilder: (BuildContext context) {
                // Fetch user data from endpoint
                controller.fetchCurrentPrincipal();

                return [
                  // User Info Header (non-clickable)
                  PopupMenuItem<String>(
                    enabled: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            const TemarLijeRoundedImage(
                              width: 50,
                              padding: 2,
                              height: 50,
                              imageType: ImageType.asset,
                              image: TemarLijeImagesStrings.user,
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  overflow: TextOverflow.fade,
                                  controller.currentPrincipal.value?.fullName ??
                                      'User',

                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: TemarLijeColors.textPrimary,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  controller.currentPrincipal.value?.staffId ??
                                      'Staff ID',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Divider(height: 20),
                      ],
                    ),
                  ),
                  // Menu Items
                  const PopupMenuItem<String>(
                    value: 'profile',
                    child: Row(
                      children: [
                        Icon(Icons.person_outline, size: 20),
                        SizedBox(width: 10),
                        Text(
                          'My Profile',
                          style: TextStyle(color: TemarLijeColors.textPrimary),
                        ),
                      ],
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'settings',
                    child: Row(
                      children: [
                        Icon(Icons.settings_outlined, size: 20),
                        SizedBox(width: 10),
                        Text(
                          'Settings',
                          style: TextStyle(color: TemarLijeColors.textPrimary),
                        ),
                      ],
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'help',
                    child: Row(
                      children: [
                        Icon(Icons.help_outline, size: 20),
                        SizedBox(width: 10),
                        Text(
                          'Help Center',
                          style: TextStyle(color: TemarLijeColors.textPrimary),
                        ),
                      ],
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'logout',
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout,
                          size: 20,
                          color: TemarLijeColors.error,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Logout',
                          style: TextStyle(color: TemarLijeColors.error),
                        ),
                      ],
                    ),
                  ),
                ];
              },
            );
          }),
        ],
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(TemarLijeDeviceUtils.getAppBarHeight() + 15);
}
