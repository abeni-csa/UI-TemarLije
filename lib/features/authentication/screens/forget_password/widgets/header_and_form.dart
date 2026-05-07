import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ui_temarlije/routes/routes.dart';
import 'package:ui_temarlije/utils/constants/text_string.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class HeaderAndForm extends StatelessWidget {
  const HeaderAndForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Iconsax.arrow_left),
        ),
        const SizedBox(height: TemarLijeSizes.spaceBtwItems),
        Text(
          TemarLijeTexts.forgetPasswordTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: TemarLijeSizes.spaceBtwItems),
        Text(
          TemarLijeTexts.forgetPasswordSubTitle,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        const SizedBox(height: TemarLijeSizes.spaceBtwItems),
        // Form
        Form(
          child: TextFormField(
            decoration: const InputDecoration(
              labelText: TemarLijeTexts.email,
              prefixIcon: Icon(Iconsax.direct_right),
            ),
          ),
        ),
        const SizedBox(height: TemarLijeSizes.spaceBtwItems),
        // Submit Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => Get.offAllNamed(TemarLijeRoutes.resetPassword),
            child: const Text(TemarLijeTexts.submit),
          ),
        ),
        const SizedBox(height: TemarLijeSizes.spaceBtwItems),
      ],
    );
  }
}
