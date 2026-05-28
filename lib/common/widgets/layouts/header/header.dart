import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ui_temarlije/common/widgets/images/t_rounded_image.dart';
import 'package:ui_temarlije/features/users/controllers/principal_controller.dart';
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
        // Search Field
        title: TemarLijeDeviceUtils.isDesktopScreen(context)
            ? SizedBox(
                width: double.infinity,
                child: TextFormField(
                  // maxLength: 300,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.search_normal),
                    hintText: "Search Anything...",
                  ),
                ),
              )
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
          Row(
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
                Obx(() {
                  final p = controller.currentPrincipal.value;
                  final title = p != null && p.firstName.isNotEmpty
                      ? p.fullNameformated
                      : TemarLijeTexts.firstName;
                  final subtitle = p != null && p.staffId.isNotEmpty
                      ? p.staffId
                      : TemarLijeTexts.adminEmail;

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  );
                }),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(TemarLijeDeviceUtils.getAppBarHeight() + 15);
}
