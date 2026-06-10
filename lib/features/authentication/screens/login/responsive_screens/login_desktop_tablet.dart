import 'package:flutter/material.dart';
import 'package:ui_temarlije/common/widgets/layouts/template/loging_template.dart';
import 'package:ui_temarlije/features/authentication/screens/login/widgets/login_form.dart';
import 'package:ui_temarlije/common/widgets/form/form_header.dart';
import 'package:ui_temarlije/utils/constants/text_string.dart';

class LoginScreenDesktopTablet extends StatelessWidget {
  const LoginScreenDesktopTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return const TemarLijeLoginScreenTemplate(
      child: Column(
        children: [
          TemarLijeFormHeader(
            title: TemarLijeTexts.signIn,
            subTitle: TemarLijeTexts.signInSubTitle,
          ),
          // Login IN Form
          TemarLijeLoginForm(),
        ],
      ),
    );
  }
}
