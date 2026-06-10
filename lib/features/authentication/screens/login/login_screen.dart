import 'package:flutter/material.dart';
import 'package:ui_temarlije/common/widgets/layouts/template/site_layout.dart';
import 'package:ui_temarlije/features/authentication/screens/login/responsive_screens/login_desktop_tablet.dart';
import 'package:ui_temarlije/features/authentication/screens/login/responsive_screens/login_mobile.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TemarLijeSiteTemplate(
      useLayout: false,
      mobile: LoginScreenMobile(),
      desktop: LoginScreenDesktopTablet(),
    );
  }
}
