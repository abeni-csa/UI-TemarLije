import 'package:flutter/material.dart';
import 'package:ui_temarlije/features/authentication/screens/login/widgets/login_form.dart';
import 'package:ui_temarlije/common/widgets/form/form_header.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';
import 'package:ui_temarlije/utils/constants/text_string.dart';

class LoginScreenMobile extends StatelessWidget {
  const LoginScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.all(TemarLijeSizes.defaultSpace),
          child: Column(
            children: [
              // Header
              TemarLijeFormHeader(
                title: TemarLijeTexts.loginTitle,
                subTitle: TemarLijeTexts.loginSubTitle,
              ),
              // Login Form
              TemarLijeLoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}
