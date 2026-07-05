import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';

class TemarLijeTableActionButtons extends StatelessWidget {
  const TemarLijeTableActionButtons({
    super.key,
    this.edit = true,
    this.view = false,
    this.delete = true,
    this.onViewPressed,
    this.onEditPressed,
    this.onDeletePressed,
  });

  final bool edit;
  final bool view;
  final bool delete;

  final VoidCallback? onViewPressed;
  final VoidCallback? onEditPressed;
  final VoidCallback? onDeletePressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (view)
          IconButton(
            icon: Icon(Iconsax.eye, color: TemarLijeColors.darkGrey),
            onPressed: onViewPressed,
          ),
        if (edit)
          IconButton(
            icon: Icon(
              Iconsax.edit,
              color: TemarLijeColors.googleForegroundColor,
            ),
            onPressed: onEditPressed,
          ),
        if (delete)
          IconButton(
            icon: Icon(Iconsax.trash, color: TemarLijeColors.error),
            onPressed: onDeletePressed,
          ),
      ],
    );
  }
}
