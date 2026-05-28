// lib/features/authentication/screens/signup/responsive_screens/signup_desktop_tablet.dart
import 'package:flutter/material.dart';
import 'package:ui_temarlije/common/widgets/form/form_header.dart';
import 'package:ui_temarlije/common/widgets/layouts/template/loging_template.dart';
import 'package:ui_temarlije/features/authentication/screens/signup/widgets/signup_form.dart';
import 'package:ui_temarlije/utils/constants/text_string.dart';

class SignupScreenDesktopTablet extends StatelessWidget {
  const SignupScreenDesktopTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return const TemarLijeLoginScreenTemplate(
      child: Column(
        children: [
          TemarLijeFormHeader(
            title: TemarLijeTexts.signIn,
            subTitle: TemarLijeTexts.signInSubTitle,
          ),
          TemarLijeSignupForm(),
        ],
      ),
    );
  }
}
