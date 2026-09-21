import 'package:flutter/material.dart';
import 'package:ui_temarlije/features/administrator/academic_year/screens/widgets/academic_year_view.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class AcademicYearDesktopTabletScreen extends StatelessWidget {
  const AcademicYearDesktopTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsetsGeometry.all(TemarLijeSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AcademicYearView(),

          ChoiceChip(
            label: Text("TEsting"),
            selected: true,
            selectedColor: Colors.blueGrey,
            backgroundColor: Colors.grey,
          ),
        ],
      ),
    );
  }
}
