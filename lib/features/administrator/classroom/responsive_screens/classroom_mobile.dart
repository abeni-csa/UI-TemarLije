import 'package:flutter/material.dart';
import 'package:ui_temarlije/features/administrator/classroom/widgets/classroom_view.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class ClassroomMobileScreen extends StatelessWidget {
  const ClassroomMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(TemarLijeSizes.mobileSpace),
      child: Column(children: [ClassroomView()]),
    );
  }
}
