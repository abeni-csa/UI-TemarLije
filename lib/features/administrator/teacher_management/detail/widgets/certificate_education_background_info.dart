import 'package:flutter/material.dart';
import 'package:ui_temarlije/common/widgets/containers/rounded_container.dart';
import 'package:ui_temarlije/data/models/teacher.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class TeacherCertificateEducationBackgroundInfo extends StatelessWidget {
  const TeacherCertificateEducationBackgroundInfo({
    super.key,
    required this.teacher,
  });
  final Teacher teacher;

  @override
  Widget build(BuildContext context) {
    // final totalSpecilaizationAndCert = teacher.specialization.fold(
    //   0,
    //   (previousValue, elemet) => previousValue + elemet.length,
    // );
    return TemarLijeRoundedContainer(
      padding: const EdgeInsets.all(TemarLijeSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Certificate And Specilaziation",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: TemarLijeSizes.spaceBtwSections),

          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (_, _) =>
                const SizedBox(height: TemarLijeSizes.spaceBtwItems),
            itemCount: teacher.specialization.length,

            itemBuilder: (BuildContext context, int index) {
              // final sp = teacher.specialization[index];
              return Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        //  TemarLijeRoundedImage(imageType: imageType, backgroundColor: TemarLijeColors.primaryBackground,)
                        const SizedBox(height: TemarLijeSizes.spaceBtwItems),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                teacher.specialization[index],
                                style: Theme.of(context).textTheme.bodyMedium,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
