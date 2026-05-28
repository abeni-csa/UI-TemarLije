// lib/features/authentication/screens/signup/responsive_screens/signup_mobile.dart
import 'package:flutter/material.dart';
import 'package:ui_temarlije/common/widgets/form/form_header.dart';
import 'package:ui_temarlije/features/authentication/screens/signup/widgets/signup_form.dart';
import 'package:ui_temarlije/utils/constants/text_string.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class SignupScreenMobile extends StatelessWidget {
  const SignupScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.all(TemarLijeSizes.defaultSpace),
          child: Column(
            children: [
              TemarLijeFormHeader(
                title: TemarLijeTexts.signIn,
                subTitle: TemarLijeTexts.signInSubTitle,
              ),
              TemarLijeSignupForm(),
            ],
          ),
        ),
      ),
    );
  }
}
