import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ui_temarlije/common/widgets/buttons/primary_button.dart';
import 'package:ui_temarlije/utils/device/device_utility.dart';

class TemarLijeDataTableHeader extends StatelessWidget {
  const TemarLijeDataTableHeader({
    super.key,
    required this.onPress,
    this.buttonText = "Add",
    this.searchController,
    this.searchOnChage,
    this.showLeftWidget = true,
  });

  final VoidCallback onPress;
  final String buttonText;
  final bool showLeftWidget;

  final TextEditingController? searchController;
  final Function(String)? searchOnChage;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: TemarLijeDeviceUtils.isDesktopScreen(context) ? 3 : 2,
          child: showLeftWidget
              ? Row(
                  children: [
                    SizedBox(
                      width: 200,
                      height: 45,
                      child: TemarLijePrimaryButton(
                        onPressed: onPress,
                        text: buttonText,
                      ),
                    ),
                  ],
                )
              : const SizedBox.shrink(),
        ),
        Expanded(
          flex: TemarLijeDeviceUtils.isDesktopScreen(context) ? 2 : 1,
          child: TextFormField(
            controller: searchController,
            onChanged: searchOnChage,
            decoration: InputDecoration(
              hintText: "Serch here...",
              prefixIcon: Icon(Iconsax.search_normal),
            ),
          ),
        ),
      ],
    );
  }
}
