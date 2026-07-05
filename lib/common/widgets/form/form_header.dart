import 'package:flutter/material.dart';
import 'package:ui_temarlije/utils/constants/image_strings.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class TemarLijeFormHeader extends StatelessWidget {
  const TemarLijeFormHeader({
    super.key,
    required this.title,
    required this.subTitle,
    this.showImage = true,
  });
  final String title;
  final String subTitle;
  final bool showImage;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          showImage
              ? const Image(
                  width: 100,
                  height: 100,
                  image: AssetImage(TemarLijeImagesStrings.darkAppLogo),
                )
              : const SizedBox.shrink(),
          const SizedBox(height: TemarLijeSizes.spaceBtwSections),
          Text(title, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: TemarLijeSizes.sm),
          Text(subTitle, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
