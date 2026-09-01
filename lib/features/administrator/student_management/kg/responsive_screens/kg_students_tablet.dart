import 'package:flutter/material.dart';
import 'package:ui_temarlije/common/widgets/containers/rounded_container.dart';
import 'package:ui_temarlije/features/administrator/student_management/kg/screens/widgets/kg_students_view.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class KGStudentsTabletScreen extends StatelessWidget {
  const KGStudentsTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(TemarLijeSizes.defaultSpace),
        child: TemarLijeRoundedContainer(
          padding: const EdgeInsets.all(20),
          child: const KGStudentsView(),
        ),
      ),
    );
  }
}

/// jburak
