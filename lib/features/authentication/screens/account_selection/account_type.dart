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
      mobile: AccountTypeScreenMobile(),
      tablet: AccountTypeScreenTabletdesktop(),
      desktop: AccountTypeScreenTabletdesktop(),
    );
  }
}
