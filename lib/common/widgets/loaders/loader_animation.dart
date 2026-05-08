import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ui_temarlije/utils/constants/image_strings.dart';

/// A circular loader widget with customizable foreground and background colors.
class TemarLijeLoaderAnimation extends StatelessWidget {
  const TemarLijeLoaderAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        TemarLijeImagesStrings.defaultLoaderAnimation,
        height: 200,
        width: 200,
      ),
    );
  }
}
