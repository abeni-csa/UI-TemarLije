import 'package:flutter/material.dart';
import 'package:ui_temarlije/utils/constants/image_strings.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';
import 'package:ui_temarlije/utils/constants/text_string.dart';

class TemarLijeLoginHeader extends StatelessWidget {
  const TemarLijeLoginHeader({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Image(
            width: 100,
            height: 100,
            image: AssetImage(TemarLijeImagesStrings.darkAppLogo),
          ),
          const SizedBox(height: TemarLijeSizes.spaceBtwSections),
          Text(
            TemarLijeTexts.signupTitle,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: TemarLijeSizes.sm),
          Text(
            TemarLijeTexts.tSignUpSubTitle,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
