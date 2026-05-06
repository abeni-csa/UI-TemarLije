import 'package:flutter/material.dart';
import 'package:ui_temarlije/common/styles/spacing_styles.dart';
import 'package:ui_temarlije/common/widgets/layouts/template/loging_template.dart';
import 'package:ui_temarlije/features/authentication/screens/login/widgets/login_form.dart';
import 'package:ui_temarlije/features/authentication/screens/login/widgets/login_header.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class LoginScreenDesktopTablet extends StatelessWidget {
  const LoginScreenDesktopTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return const TemarLijeLoginScreenTemplate(
      child: Column(
        children: [
          // Login Header
          TemarLijeLoginHeader(),
          // Login IN Form
          TemarLijeLoginForm(),
        ],
      ),
    );
  }
}
