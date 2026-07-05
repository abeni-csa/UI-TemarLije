import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ui_temarlije/common/widgets/card/account_type_card.dart';
import 'package:ui_temarlije/common/widgets/layouts/template/loging_template.dart';
import 'package:ui_temarlije/routes/routes.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';
import 'package:ui_temarlije/common/widgets/form/form_header.dart';
import 'account_type.dart';

class AccountTypeScreenTabletDesktop extends StatelessWidget {
  const AccountTypeScreenTabletDesktop({super.key});

  final List<AccountTypeModel> accountTypes = const [
    AccountTypeModel(
      title: "Student",
      route: TemarLijeRoutes.profStudnet,
      icon: Iconsax.people,
      imagePath: "assets/images/student.png",
      description:
          "Access courses, submit assignments, and track your academic progress",
    ),
    AccountTypeModel(
      title: "Staff",
      route: null,
      icon: Iconsax.briefcase,
      imagePath: "assets/images/staff.png",
      description: "Manage administrative tasks and support school operations",
    ),
    AccountTypeModel(
      title: "Teacher",
      route: TemarLijeRoutes.teacherProfile,
      icon: Iconsax.teacher,
      imagePath: "assets/images/teacher.png",
      description: "Create courses, grade assignments, and manage your classes",
    ),
    AccountTypeModel(
      title: "School Administrator",
      route: TemarLijeRoutes.profPricpial,
      icon: Iconsax.shield_tick,
      imagePath: "assets/images/admin.png",
      description:
          "Oversee school operations, manage users, and generate reports",
    ),
    AccountTypeModel(
      title: "Parent",
      route: null,
      icon: Iconsax.heart,
      imagePath: "assets/images/parent.png",
      description:
          "Monitor your child's progress and communicate with teachers",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return TemarLijeLoginScreenTemplate(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TemarLijeFormHeader(
            title: "Select Your Account Type",
            subTitle: "Choose the account that best describes you",
          ),
          const SizedBox(height: TemarLijeSizes.spaceBtwSections),
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = 2;
              if (constraints.maxWidth > 900) {
                crossAxisCount = 3;
              } else if (constraints.maxWidth > 600) {
                crossAxisCount = 2;
              } else {
                crossAxisCount = 1;
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: 1.2,
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
              );
            },
          ),
        ],
      ),
    );
  }
}
