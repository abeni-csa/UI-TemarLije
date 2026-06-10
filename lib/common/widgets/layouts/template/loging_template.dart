import 'package:flutter/material.dart';
import 'package:ui_temarlije/common/styles/spacing_styles.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class TemarLijeLoginScreenTemplate extends StatelessWidget {
  const TemarLijeLoginScreenTemplate({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 550,
        child: SingleChildScrollView(
          child: Container(
            padding: TemarLijeSpacingStyle.paddingWithAppBarHeight,
            decoration: BoxDecoration(
              color: TemarLijeColors.grey,
              borderRadius: BorderRadiusGeometry.circular(
                TemarLijeSizes.cardRadiusLg,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
