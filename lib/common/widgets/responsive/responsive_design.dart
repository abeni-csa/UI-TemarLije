import 'package:flutter/material.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class TemarLijeResponsiveWidget extends StatelessWidget {
  const TemarLijeResponsiveWidget({
    super.key,
    required this.desktop,
    required this.tablet,
    required this.mobile,
  });
  final Widget desktop;
  final Widget tablet;
  final Widget mobile;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        Widget selectedWidget;

        if (constraints.maxWidth >= TemarLijeSizes.desktopScreenSize) {
          selectedWidget = desktop;
        } else if (constraints.maxWidth <= TemarLijeSizes.desktopScreenSize &&
            constraints.maxWidth >= TemarLijeSizes.mobileScreenSize) {
          selectedWidget = tablet;
        } else {
          selectedWidget = mobile;
        }

        return Padding(padding: const EdgeInsets.all(1), child: selectedWidget);
      },
    );
  }
}
