import 'package:flutter/material.dart';
import 'package:ui_temarlije/common/widgets/containers/rounded_container.dart';
import 'package:ui_temarlije/data/models/teacher.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class TeacherPersonalInformaton extends StatelessWidget {
  const TeacherPersonalInformaton({super.key, required this.teacher});
  final Teacher teacher;
  @override
  Widget build(BuildContext context) {
    return TemarLijeRoundedContainer(
      padding: const EdgeInsets.all(TemarLijeSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Personal Information",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: TemarLijeSizes.spaceBtwSections),
        ],
      ),
    );
  }
}
