import 'package:flutter/material.dart';
import 'package:ui_temarlije/features/authentication/screens/login/widgets/login_form.dart';
import 'package:ui_temarlije/features/authentication/screens/login/widgets/login_header.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

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
              TemarLijeLoginHeader(),
              // Login Form
              TemarLijeLoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}
