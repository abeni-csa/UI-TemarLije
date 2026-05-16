import 'package:flutter/material.dart';
import 'package:ui_temarlije/common/widgets/layouts/template/loging_template.dart';
import 'package:ui_temarlije/features/authentication/screens/login/widgets/login_form.dart';
import 'package:ui_temarlije/features/authentication/screens/login/widgets/login_header.dart';
import 'package:ui_temarlije/features/authentication/screens/signup/widgets/signup_form.dart';

class SignupDesktopTablet extends StatelessWidget {
  const SignupDesktopTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return const TemarLijeLoginScreenTemplate(
      child: Column(
        children: [
          // singup Header
          TemarLijeLoginHeader(),
          // singup Form
          SignUpFormWidget(),
        ],
      ),
    );
  }
}
