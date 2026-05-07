import 'package:flutter/material.dart';
import 'package:ui_temarlije/common/widgets/layouts/template/site_layout.dart';
import 'package:ui_temarlije/features/authentication/screens/reset_password/responsive_screens/reset_password_desktop_tablet.dart';
import 'package:ui_temarlije/features/authentication/screens/reset_password/responsive_screens/reset_password_mobile.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TemarLijeSiteTemplate(
      useLayout: false,
      mobile: ResetPasswordMobile(),
      desktop: ResetPasswordDesktopTablet(),
    );
  }
}
