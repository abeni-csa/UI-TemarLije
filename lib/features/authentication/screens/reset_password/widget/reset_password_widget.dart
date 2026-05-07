import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';
import 'package:ui_temarlije/utils/constants/image_strings.dart';
import 'package:ui_temarlije/routes/routes.dart';
import 'package:ui_temarlije/utils/constants/text_string.dart';

class ResetPasswordWidget extends StatelessWidget {
  const ResetPasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final email = Get.parameters['email'] ?? '';
    return Column(
      children: [
        // Header
        Row(
          children: [
            IconButton(
              onPressed: () => Get.offAllNamed(TemarLijeRoutes.logIn),
              icon: const Icon(CupertinoIcons.clear),
            ),
          ],
        ),
        const SizedBox(height: TemarLijeSizes.spaceBtwItems),
        // Image
        const Image(
          image: AssetImage(TemarLijeImagesStrings.deliveredEmailIllustration),
          width: 300,
          height: 300,
        ),
        const SizedBox(height: TemarLijeSizes.spaceBtwItems),
        // Tiele And Subtitle
        Text(
          TemarLijeTexts.changeYourPasswordTitle,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: TemarLijeSizes.spaceBtwItems),
        Text(
          TemarLijeTexts.adminEmail,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: TemarLijeSizes.spaceBtwItems),
        Text(
          TemarLijeTexts.changeYourPasswordSubTitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        const SizedBox(height: TemarLijeSizes.spaceBtwItems),
        // Sized Box
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => Get.offAllNamed(TemarLijeRoutes.logIn),
            child: const Text(TemarLijeTexts.done),
          ),
        ),
        const SizedBox(height: TemarLijeSizes.spaceBtwItems),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => Get.offAllNamed(TemarLijeRoutes.resetPassword),
            child: const Text(TemarLijeTexts.resendEmail),
          ),
        ),
      ],
    );
  }
}
