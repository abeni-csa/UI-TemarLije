import 'package:flutter/material.dart';
import 'package:ui_temarlije/common/widgets/containers/rounded_container.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class AccountTypeCard extends StatelessWidget {
  const AccountTypeCard({
    super.key,
    required this.title,
    required this.icon,
    required this.action,
    required this.imagePath,
    required this.description,
  });

  final String title;
  final VoidCallback action;
  final IconData icon;
  final String imagePath;
  final String description;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return TemarLijeRoundedContainer(
      showBorder: true,
      padding: const EdgeInsets.all(TemarLijeSizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image and Title Row
          Row(
            children: [
              // Image Container
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: TemarLijeColors.primary,
                  borderRadius: BorderRadius.circular(
                    TemarLijeSizes.borderRadiusLg,
                  ),
                ),
                child: imagePath.isNotEmpty
                    ? Image.asset(
                        imagePath,
                        width: 40,
                        height: 40,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            icon,
                            size: 32,
                            color: TemarLijeColors.primary,
                          );
                        },
                      )
                    : Icon(icon, size: 32, color: TemarLijeColors.primary),
              ),
              const SizedBox(width: TemarLijeSizes.md),
              // Title
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: TemarLijeColors.primary,
                      ),
                    ),
                    const SizedBox(height: TemarLijeSizes.xs),
                    // Description
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: isDarkMode
                            ? TemarLijeColors.white
                            : TemarLijeColors.darkGrey,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: TemarLijeSizes.md),
          // Action Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: action,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                backgroundColor: TemarLijeColors.primary,
                foregroundColor: TemarLijeColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    TemarLijeSizes.borderRadiusMd,
                  ),
                ),
              ),
              child: const Text(
                "Create Profile",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
