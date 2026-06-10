import 'package:flutter/material.dart';
import 'package:ui_temarlije/common/widgets/layouts/template/site_layout.dart';
import 'package:ui_temarlije/features/authentication/screens/forget_password/responsive_screens/forget_password_desktop_tablet.dart';
import 'package:ui_temarlije/features/authentication/screens/forget_password/responsive_screens/forget_password_mobile.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TemarLijeSiteTemplate(
      useLayout: false,
      mobile: ForgetPasswordScreenMobile(),
      desktop: ForgetPasswordScreenDesktopTablet(),
    );
  }
}
