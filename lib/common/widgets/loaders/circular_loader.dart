import 'package:flutter/material.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

/// A circular loader widget with customizable foreground and background colors.
class TemarLijeCircularLoader extends StatelessWidget {
  /// Default constructor for the TCircularLoader.
  ///
  /// Parameters:
  ///   - foregroundColor: The color of the circular loader.
  ///   - backgroundColor: The background color of the circular loader.
  const TemarLijeCircularLoader({
    super.key,
    this.foregroundColor = TemarLijeColors.white,
    this.backgroundColor = TemarLijeColors.primary,
  });

  final Color? foregroundColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(TemarLijeSizes.lg),
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ), // Circular background
      child: Center(
        child: CircularProgressIndicator(
          color: foregroundColor,
          backgroundColor: Colors.transparent,
        ), // Circular loader
      ),
    );
  }
}
