import 'package:flutter/material.dart';
import 'package:ui_temarlije/common/widgets/layouts/template/site_layout.dart';
import 'package:ui_temarlije/features/authentication/screens/account_selection/account_type_mobile.dart';
import 'package:ui_temarlije/features/authentication/screens/account_selection/account_type_tablet_desktop.dart';

class AccountTypeScreen extends StatelessWidget {
  const AccountTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TemarLijeSiteTemplate(
      useLayout: false,
      mobile: const AccountTypeScreenMobile(),
      tablet: const AccountTypeScreenTabletDesktop(),
      desktop: const AccountTypeScreenTabletDesktop(),
    );
  }
}

// Model for account types
class AccountTypeModel {
  final String title;
  final String? route;
  final IconData icon;
  final String imagePath;
  final String description;
  final VoidCallback? customAction;

  const AccountTypeModel({
    required this.title,
    this.route,
    required this.icon,
    required this.imagePath,
    required this.description,
    this.customAction,
  });
}
