import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:ui_temarlije/utils/constants/colors.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

/// A widget for displaying an animated loading indicator with optional text and action button.
class TemarLijeAnimationLoaderWidget extends StatelessWidget {
  /// Default constructor for the TAnimationLoaderWidget.
  ///
  /// Parameters:
  ///   - text: The text to be displayed below the animation.
  ///   - animation: The path to the Lottie animation file.
  ///   - showAction: Whether to show an action button below the text.
  ///   - actionText: The text to be displayed on the action button.
  ///   - onActionPressed: Callback function to be executed when the action button is pressed.
  const TemarLijeAnimationLoaderWidget({
    super.key,
    required this.text,
    required this.animation,
    this.showAction = false,
    this.actionText,
    this.onActionPressed,
  });

  final String text;
  final String animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate animation size - use a percentage of screen width but cap it
    // Also ensure it doesn't take more than 50% of screen height
    final animationSize = (screenWidth * 0.4).clamp(100.0, 400.0);
    final maxAnimationHeight = screenHeight * 0.4;
    final finalAnimationSize = animationSize > maxAnimationHeight
        ? maxAnimationHeight
        : animationSize;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Constrained Lottie animation with reasonable size
          SizedBox(
            width: finalAnimationSize,
            height: finalAnimationSize,
            child: Lottie.asset(animation, fit: BoxFit.contain),
          ),
          const SizedBox(height: TemarLijeSizes.spaceBtwItems),
          // Text with proper constraints
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              text,
              style: Theme.of(context).textTheme.displaySmall,
              textAlign: TextAlign.center,
              softWrap: true,
            ),
          ),
          if (showAction) ...[
            const SizedBox(height: TemarLijeSizes.spaceBtwItems),
            SizedBox(
              width: 250,
              child: OutlinedButton(
                onPressed: onActionPressed,
                style: OutlinedButton.styleFrom(
                  backgroundColor: TemarLijeColors.darkContainer,
                ),
                child: Text(
                  actionText!,
                  style: Theme.of(context).textTheme.bodyMedium!.apply(
                    color: TemarLijeColors.lightContainer,
                  ),
                ),
              ),
            ),
          ],
          // Add some bottom padding for safety
          const SizedBox(height: TemarLijeSizes.defaultSpace),
        ],
      ),
    );
  }
}
