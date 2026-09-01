import 'package:flutter/material.dart';
import 'package:ui_temarlije/features/administrator/student_management/kg/screens/widgets/kg_students_view.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class KGStudentsMobileScreen extends StatelessWidget {
  const KGStudentsMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(TemarLijeSizes.mobileSpace),
        child: const KGStudentsView(),
      ),
    );
  }
}
