import 'package:flutter/material.dart';
import 'package:ui_temarlije/common/widgets/form/form_header.dart';
import 'package:ui_temarlije/features/authentication/screens/teacher_registration/widgets/teacher_registration_form.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';
import 'package:ui_temarlije/utils/constants/text_string.dart';

class TeacherScreenMobile extends StatelessWidget {
  const TeacherScreenMobile({super.key});

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
                title: "TemarLije Teacehrs Profle",
                subTitle: "It is good to have TemarLije's verfied account",
                showImage: false,
              ),
              //
              // Login Form
              TeacherRegistrationForm(),
            ],
          ),
        ),
      ),
    );
  }
}
