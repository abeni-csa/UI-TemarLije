// lib/features/authentication/screens/signup/signup_screen.dart
import 'package:flutter/material.dart';
import 'package:ui_temarlije/common/widgets/layouts/template/site_layout.dart';
import 'package:ui_temarlije/features/authentication/screens/signup/responsive_screens/signup_desktop_tablet.dart';
import 'package:ui_temarlije/features/authentication/screens/signup/responsive_screens/signup_mobile.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TemarLijeSiteTemplate(
      useLayout: false,
      mobile: SignupScreenMobile(),
      desktop: SignupScreenDesktopTablet(),
    );
  }
}