import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ui_temarlije/common/widgets/card/account_type_card.dart';
import 'package:ui_temarlije/common/widgets/form/form_header.dart';
import 'package:ui_temarlije/routes/routes.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';
import 'package:ui_temarlije/utils/constants/image_strings.dart';

import 'account_type.dart';

class AccountTypeScreenMobile extends StatelessWidget {
  const AccountTypeScreenMobile({super.key});

  final List<AccountTypeModel> accountTypes = const [
    AccountTypeModel(
      title: "Student",
      route: TemarLijeRoutes.profStudnet,
      icon: Iconsax.people,
      imagePath: TemarLijeImagesStrings.creatingProductIllustration,
      description:
          "Access courses, submit assignments, and track your academic progress",
    ),
    AccountTypeModel(
      title: "Staff",
      route: null,
      icon: Iconsax.briefcase,
      imagePath: TemarLijeImagesStrings.banner1,
      description: "Manage administrative tasks and support school operations",
    ),
    AccountTypeModel(
      title: "Teacher",
      route: null,
      icon: Iconsax.teacher,
      imagePath: TemarLijeImagesStrings.banner1,
      description: "Create courses, grade assignments, and manage your classes",
    ),
    AccountTypeModel(
      title: "School Administrator",
      route: TemarLijeRoutes.profPricpial,
      icon: Iconsax.shield_tick,
      imagePath: TemarLijeImagesStrings.banner1,
      description:
          "Oversee school operations, manage users, and generate reports",
    ),
    AccountTypeModel(
      title: "Parent",
      route: null,
      icon: Iconsax.heart,
      imagePath: TemarLijeImagesStrings.banner1,
      description:
          "Monitor your child's progress and communicate with teachers",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TemarLijeSizes.defaultSpace),
          child: Column(
            children: [
              const TemarLijeFormHeader(
                title: "Select Your Account Type",
                subTitle: "Choose the account that best describes you",
              ),
              const SizedBox(height: TemarLijeSizes.spaceBtwSections),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 1.4,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: accountTypes.length,
                itemBuilder: (context, index) {
                  final type = accountTypes[index];
                  return AccountTypeCard(
                    title: type.title,
                    action: () {
                      if (type.route != null) {
                        Get.offNamed(type.route!);
                      } else {
                        debugPrint("Navigate to ${type.title} Registration");
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "${type.title} registration coming soon!",
                            ),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    icon: type.icon,
                    imagePath: type.imagePath,
                    description: type.description,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
