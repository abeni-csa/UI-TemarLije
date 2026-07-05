import 'package:flutter/material.dart';
import 'package:ui_temarlije/common/widgets/layouts/template/loging_template.dart';
import 'package:ui_temarlije/common/widgets/form/form_header.dart';
import 'package:ui_temarlije/features/authentication/screens/teacher_registration/widgets/teacher_registration_form.dart';

class TeacherScreenDesktopTablet extends StatelessWidget {
  const TeacherScreenDesktopTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return const TemarLijeLoginScreenTemplate(
      child: Column(
        children: [
          TemarLijeFormHeader(
            title: "TemarLije Teacehrs Profle",
            subTitle: "It is good to have TemarLije's verfied account",
          ),
          // Login IN Form
          TeacherRegistrationForm(),
        ],
      ),
    );
  }
}
