import 'package:flutter/material.dart';
import 'package:ui_temarlije/features/authentication/screens/forget_password/widgets/header_and_form.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class ForgetPasswordScreenMobile extends StatelessWidget {
  const ForgetPasswordScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.all(TemarLijeSizes.defaultSpace),
          child: HeaderAndForm(),
        ),
      ),
    );
  }
}
