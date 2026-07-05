import 'package:flutter/material.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';

class TemarLijePageHeading extends StatelessWidget {
  const TemarLijePageHeading({
    super.key,
    required this.heading,
    this.rightSideWidget,
  });

  final String heading;
  final Widget? rightSideWidget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          heading,
          style: Theme.of(context).textTheme.headlineSmall!.apply(
            color: TemarLijeColors.darkBackground,
          ),
        ),
        rightSideWidget ?? const SizedBox(),
      ],
    );
  }
}

//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
