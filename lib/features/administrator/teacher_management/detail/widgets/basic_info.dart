import 'package:flutter/material.dart';
import 'package:ui_temarlije/common/widgets/containers/rounded_container.dart';
import 'package:ui_temarlije/data/models/teacher.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';
import 'package:ui_temarlije/utils/constants/enums.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';
import 'package:ui_temarlije/utils/device/device_utility.dart';
import 'package:ui_temarlije/utils/helpers/helper_functions.dart';

class BasicTeacherInfo extends StatelessWidget {
  const BasicTeacherInfo({super.key, required this.teacher});
  final Teacher teacher;

  @override
  Widget build(BuildContext context) {
    return TemarLijeRoundedContainer(
      padding: const EdgeInsets.all(TemarLijeSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Basic Info", style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: TemarLijeSizes.spaceBtwSections),

          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Date"),
                    Text(
                      teacher.dateOfBirth.toString(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Specilaizations"),
                    Text(
                      '${teacher.specialization.length} Specilaizations ',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: TemarLijeDeviceUtils.isMobileScreen(context) ? 2 : 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Employmet Type"),
                    TemarLijeRoundedContainer(
                      radius: TemarLijeSizes.cardRadiusSm,
                      padding: const EdgeInsets.symmetric(
                        horizontal: TemarLijeSizes.sm,
                        vertical: 0,
                      ),
                      backgroundColor:
                          TemarLijeHelperFunctions.getEmploymentTypeColor(
                            teacher.employmentType,
                          ).withOpacity(0.1),
                      child: DropdownButton<EmploymentType>(
                        borderRadius: BorderRadius.all(Radius.elliptical(2, 2)),
                        dropdownColor: TemarLijeColors.lightBackground,
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        value: teacher.employmentType,
                        onChanged: (value) => value,
                        items: EmploymentType.values.map((EmploymentType type) {
                          return DropdownMenuItem<EmploymentType>(
                            value: type,
                            child: Text(
                              type.name.toUpperCase().toString(),

                              style: TextStyle(
                                color:
                                    TemarLijeHelperFunctions.getEmploymentTypeColor(
                                      type,
                                    ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
