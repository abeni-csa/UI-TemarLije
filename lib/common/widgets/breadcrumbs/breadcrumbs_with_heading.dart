import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ui_temarlije/common/widgets/texts/page_heading.dart';
import 'package:ui_temarlije/routes/routes.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

/// A widget that displays breadcrumbs navigation with a page heading
///
/// Example usage:
/// ```dart
/// TemarLijeBreadcrumbsWithHeading(
///   heading: 'Product Details',
///   breadcrumbsItems: ['/products', '/electronics', '/laptops'],
///   returnToPreviousScreen: true,
/// )
/// ```
class TemarLijeBreadcrumbsWithHeading extends StatelessWidget {
  const TemarLijeBreadcrumbsWithHeading({
    super.key,
    required this.heading,
    required this.breadcrumbsItems,
    this.returnToPreviousScreen = false,
    this.onDashboardTap,
    this.onBreadcrumbTap,
    this.customSeparator = '/',
    this.showDashboard = true,
    this.dashboardLabel = 'Dashboard',
    this.currentPageColor,
    this.breadcrumbTextStyle,
  });

  /// The main heading/title of the page
  final String heading;

  /// List of breadcrumb items (route names or display names)
  /// Example: ['/products', '/electronics', '/laptops']
  final List<String> breadcrumbsItems;

  /// Whether to show a back button to return to previous screen
  final bool returnToPreviousScreen;

  /// Optional callback when dashboard is tapped
  final VoidCallback? onDashboardTap;

  /// Optional callback when a breadcrumb is tapped
  /// Provides the index and the item tapped
  final void Function(int index, String item)? onBreadcrumbTap;

  /// Custom separator between breadcrumb items (default: '/')
  final String customSeparator;

  /// Whether to show the dashboard link (default: true)
  final bool showDashboard;

  /// Custom label for dashboard (default: 'Dashboard')
  final String dashboardLabel;

  /// Color for the current page (last breadcrumb item)
  final Color? currentPageColor;

  /// Custom text style for breadcrumb items
  final TextStyle? breadcrumbTextStyle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultTextStyle =
        theme.textTheme.bodySmall?.apply(
          fontWeightDelta: -1,
          color: TemarLijeColors.darkBackground,
        ) ??
        const TextStyle();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Breadcrumbs Row
        _buildBreadcrumbs(context, defaultTextStyle),

        const SizedBox(height: TemarLijeSizes.sm),

        // Page Heading with Back Button
        _buildPageHeader(context),
      ],
    );
  }

  /// Builds the breadcrumbs navigation
  Widget _buildBreadcrumbs(BuildContext context, TextStyle defaultStyle) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Dashboard Link
          if (showDashboard) ...[
            _buildBreadcrumbItem(
              label: dashboardLabel,
              isClickable: true,
              onTap:
                  onDashboardTap ??
                  () => Get.offNamed(TemarLijeRoutes.dashbord),
              textStyle: defaultStyle,
            ),
          ],

          // Breadcrumb Items
          for (int idx = 0; idx < breadcrumbsItems.length; idx++) ...[
            // Separator
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(customSeparator, style: defaultStyle),
            ),

            // Breadcrumb Item
            _buildBreadcrumbItem(
              label: _formatBreadcrumbLabel(breadcrumbsItems[idx]),
              isClickable: idx < breadcrumbsItems.length - 1,
              isCurrent: idx == breadcrumbsItems.length - 1,
              onTap: () => _handleBreadcrumbTap(idx, breadcrumbsItems[idx]),
              textStyle: defaultStyle,
              currentPageColor: currentPageColor ?? TemarLijeColors.primary,
            ),
          ],
        ],
      ),
    );
  }

  /// Builds an individual breadcrumb item
  Widget _buildBreadcrumbItem({
    required String label,
    required bool isClickable,
    bool isCurrent = false,
    required VoidCallback onTap,
    required TextStyle textStyle,
    Color? currentPageColor,
  }) {
    return InkWell(
      onTap: isClickable ? onTap : null,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: TemarLijeSizes.xs,
          vertical: TemarLijeSizes.xs,
        ),
        child: Text(
          label,
          style: isCurrent
              ? textStyle.copyWith(
                  color: currentPageColor ?? TemarLijeColors.primary,
                  fontWeight: FontWeight.w600,
                )
              : isClickable
              ? textStyle.copyWith(
                  decoration: TextDecoration.underline,
                  decorationColor: TemarLijeColors.darkBackground.withOpacity(
                    0.3,
                  ),
                )
              : textStyle,
        ),
      ),
    );
  }

  /// Builds the page header with optional back button
  Widget _buildPageHeader(BuildContext context) {
    return Row(
      children: [
        if (returnToPreviousScreen) ...[
          IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Iconsax.arrow_left),
            tooltip: 'Go Back',
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: TemarLijeSizes.spaceBtwItems),
        ],
        Expanded(child: TemarLijePageHeading(heading: heading)),
      ],
    );
  }

  /// Handles breadcrumb tap
  void _handleBreadcrumbTap(int index, String item) {
    // Call custom callback if provided
    if (onBreadcrumbTap != null) {
      onBreadcrumbTap!(index, item);
      return;
    }

    // Default navigation logic
    if (index < breadcrumbsItems.length - 1) {
      String routeName = _extractRouteName(item);
      if (routeName.isNotEmpty) {
        Get.toNamed(routeName);
      }
    }
  }

  /// Formats the breadcrumb label for display
  String _formatBreadcrumbLabel(String label) {
    // Remove leading slash if present
    String cleanLabel = label.startsWith('/') ? label.substring(1) : label;

    // Remove trailing slash if present
    if (cleanLabel.endsWith('/')) {
      cleanLabel = cleanLabel.substring(0, cleanLabel.length - 1);
    }

    // Replace underscores and hyphens with spaces
    cleanLabel = cleanLabel.replaceAll(RegExp(r'[_-]'), ' ');

    // Capitalize each word
    return _capitalizeWords(cleanLabel);
  }

  /// Extracts route name from breadcrumb item
  String _extractRouteName(String item) {
    // If item starts with '/', it's already a route path
    if (item.startsWith('/')) {
      return item;
    }
    // Otherwise, try to convert to route path
    return '/${item.toLowerCase().replaceAll(' ', '_')}';
  }

  /// Capitalizes each word in a string
  String _capitalizeWords(String str) {
    if (str.isEmpty) return '';
    return str
        .split(' ')
        .map((word) {
          if (word.isEmpty) return '';
          return word[0].toUpperCase() + word.substring(1).toLowerCase();
        })
        .join(' ');
  }

  /// Capitalizes first letter of a string (legacy method for compatibility)
  String capitalize(String str) {
    if (str.isEmpty) return '';
    String cleanStr = str.startsWith('/') ? str.substring(1) : str;
    if (cleanStr.isEmpty) return '';
    return cleanStr[0].toUpperCase() + cleanStr.substring(1);
  }
}

/// Extension methods for additional functionality
extension BreadcrumbsExtensions on List<String> {
  /// Checks if breadcrumbs list is valid
  bool get isValid => isNotEmpty && every((item) => item.isNotEmpty);

  /// Returns the last item as current page
  String? get currentPage => isNotEmpty ? last : null;

  /// Returns parent breadcrumbs (all except last)
  List<String> get parents => length > 1 ? sublist(0, length - 1) : [];
}
