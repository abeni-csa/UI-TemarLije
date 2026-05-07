import 'package:flutter/material.dart';
import 'package:ui_temarlije/features/authentication/screens/reset_password/widget/reset_password_widget.dart';

import 'package:ui_temarlije/utils/constants/sizes.dart';

class ResetPasswordMobile extends StatelessWidget {
  const ResetPasswordMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.all(TemarLijeSizes.defaultSpace),
          child: ResetPasswordWidget(),
        ),
      ),
    );
  }
}
