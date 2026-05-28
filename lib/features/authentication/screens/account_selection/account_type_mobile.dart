import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ui_temarlije/common/widgets/card/account_type_card.dart';
import 'package:ui_temarlije/common/widgets/form/form_header.dart';
import 'package:ui_temarlije/routes/routes.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class AccountTypeScreenMobile extends StatelessWidget {
  const AccountTypeScreenMobile({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.all(TemarLijeSizes.defaultSpace),
          child: Column(
            children: [
              TemarLijeFormHeader(
                title: "Select Your Accont Type",
                subTitle: "Get Pesonlaized Acc.",
              ),
              const SizedBox(height: TemarLijeSizes.defaultSpace),
              AccountTypeCard(
                title: "Staff",
                action: () => {debugPrint("Pressed GOto Staff Rgeistration")},
                icon: Iconsax.people,
              ),
              const SizedBox(height: TemarLijeSizes.defaultSpace),
              AccountTypeCard(
                title: "Studnet",
                action: () => {Get.offNamed(TemarLijeRoutes.profStudnet)},
                icon: Iconsax.people,
              ),
              const SizedBox(height: TemarLijeSizes.defaultSpace),
              AccountTypeCard(
                title: "Teacher",
                action: () => {debugPrint("Pressed GOto TEacer")},
                icon: Iconsax.activity1,
              ),
              const SizedBox(height: TemarLijeSizes.defaultSpace),

              AccountTypeCard(
                title: "School Adminstrator",
                action: () => {debugPrint("Pressed GOto School Adminstrator")},
                icon: Iconsax.activity,
              ),
              const SizedBox(height: TemarLijeSizes.defaultSpace),

              AccountTypeCard(
                title: "Paretn",
                action: () => {debugPrint("Pressed GOto School Adminstrator")},
                icon: Iconsax.activity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
