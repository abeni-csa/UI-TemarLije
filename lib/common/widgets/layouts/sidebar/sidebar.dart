import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ui_temarlije/common/widgets/images/t_circular_image.dart';
import 'package:ui_temarlije/common/widgets/layouts/sidebar/menu_items.dart';
import 'package:ui_temarlije/common/widgets/layouts/sidebar/sidebar_controller.dart';
import 'package:ui_temarlije/routes/app_routes.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';
import 'package:ui_temarlije/routes/routes.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';
import 'package:ui_temarlije/utils/constants/image_strings.dart';
import 'package:get/get.dart';

class TemarLijeSidebar extends StatelessWidget {
  const TemarLijeSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller if not already initialized
    if (!Get.isRegistered<SidebarController>()) {
      Get.put(SidebarController());
    }

    return Drawer(
      shape: const BeveledRectangleBorder(),
      child: Container(
        decoration: const BoxDecoration(
          color: TemarLijeColors.white,
          border: Border(
            right: BorderSide(color: TemarLijeColors.grey, width: 1),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const TemarLijeCircularImage(
                width: 100,
                height: 100,
                image: TemarLijeImagesStrings.darkAppLogo,
                backgroundColor: Colors.transparent,
              ),
              const SizedBox(height: TemarLijeSizes.spaceBtwSections),
              Padding(
                padding: const EdgeInsets.all(TemarLijeSizes.xs - 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Desktop / Dashboard
                    const TemarLijeMenuItem(
                      route: TemarLijeRoutes.siteRoot,
                      icon: Iconsax.music_dashboard,
                      itemName: "Desktop",
                    ),

                    const SizedBox(height: TemarLijeSizes.spaceBtwItems),

                    // Networking with Submenu
                    TemarLijeMenuItem(
                      route: '/networking',
                      icon: Iconsax.cloud_connection,
                      itemName: "NetWorking",
                      children: [
                        TemarLijeMenuItem(
                          route: '/networking/overview',
                          icon: Iconsax.chart,
                          itemName: "Overview",
                          isSubmenu: true,
                        ),
                        TemarLijeMenuItem(
                          route: '/networking/devices',
                          icon: Iconsax.device_message,
                          itemName: "Devices",
                          isSubmenu: true,
                        ),
                        TemarLijeMenuItem(
                          route: '/networking/connections',
                          icon: Iconsax.wifi,
                          itemName: "Connections",
                          isSubmenu: true,
                        ),
                        TemarLijeMenuItem(
                          route: '/networking/security',
                          icon: Iconsax.shield_tick,
                          itemName: "Security",
                          isSubmenu: true,
                        ),
                      ],
                    ),

                    const SizedBox(height: TemarLijeSizes.spaceBtwItems),

                    // Marklist with Submenu
                    TemarLijeMenuItem(
                      route: '/marklist',
                      icon: Iconsax.data,
                      itemName: "Marklist",
                      children: [
                        TemarLijeMenuItem(
                          route: '/marklist/students',
                          icon: Iconsax.profile_circle,
                          itemName: "Student Marks",
                          isSubmenu: true,
                        ),
                        TemarLijeMenuItem(
                          route: '/marklist/subjects',
                          icon: Iconsax.book,
                          itemName: "Subject Marks",
                          isSubmenu: true,
                        ),
                        TemarLijeMenuItem(
                          route: '/marklist/semesters',
                          icon: Iconsax.calendar,
                          itemName: "Semester Results",
                          isSubmenu: true,
                        ),
                        TemarLijeMenuItem(
                          route: '/marklist/reports',
                          icon: Iconsax.document_text,
                          itemName: "Reports",
                          isSubmenu: true,
                        ),
                      ],
                    ),

                    const SizedBox(height: TemarLijeSizes.spaceBtwItems),

                    // Lesson Planner with Submenu
                    TemarLijeMenuItem(
                      route: '/lesson-planner',
                      icon: Iconsax.add_circle,
                      itemName: "Lesson Planner",
                      children: [
                        TemarLijeMenuItem(
                          route: TemarLijeRoutes.toolLessonPlaner,
                          icon: Iconsax.add,
                          itemName: "Create Lesson",
                          isSubmenu: true,
                        ),
                        TemarLijeMenuItem(
                          route: TemarLijeRoutes.toolAttendaceTrack,
                          icon: Iconsax.attach_circle,
                          itemName: "Attendace Track",
                          isSubmenu: true,
                        ),
                        TemarLijeMenuItem(
                          route: '/lesson-planner/view',
                          icon: Iconsax.eye,
                          itemName: "View Lessons",
                          isSubmenu: true,
                        ),
                        TemarLijeMenuItem(
                          route: '/lesson-planner/schedule',
                          icon: Iconsax.calendar_1,
                          itemName: "Schedule",
                          isSubmenu: true,
                        ),
                        TemarLijeMenuItem(
                          route: '/lesson-planner/resources',
                          icon: Iconsax.folder,
                          itemName: "Resources",
                          isSubmenu: true,
                        ),
                        // Nested submenu example
                        TemarLijeMenuItem(
                          route: '/lesson-planner/templates',
                          icon: Iconsax.document,
                          itemName: "Templates",
                          isSubmenu: true,
                          children: [
                            TemarLijeMenuItem(
                              route: '/lesson-planner/templates/daily',
                              icon: Iconsax.sun_1,
                              itemName: "Daily Templates",
                              isSubmenu: true,
                            ),
                            TemarLijeMenuItem(
                              route: '/lesson-planner/templates/weekly',
                              icon: Iconsax.calendar,
                              itemName: "Weekly Templates",
                              isSubmenu: true,
                            ),
                            TemarLijeMenuItem(
                              route: '/lesson-planner/templates/monthly',
                              icon: Iconsax.calendar_2,
                              itemName: "Monthly Templates",
                              isSubmenu: true,
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: TemarLijeSizes.spaceBtwItems),

                    // Fee Management with Submenu
                    TemarLijeMenuItem(
                      route: '/fee',
                      icon: Iconsax.menu_board,
                      itemName: "Fee Management",
                      children: [
                        TemarLijeMenuItem(
                          route: '/fee/collections',
                          icon: Iconsax.money,
                          itemName: "Fee Collections",
                          isSubmenu: true,
                        ),
                        TemarLijeMenuItem(
                          route: '/fee/structures',
                          icon: Iconsax.buildings,
                          itemName: "Fee Structures",
                          isSubmenu: true,
                        ),
                        TemarLijeMenuItem(
                          route: '/fee/reports',
                          icon: Iconsax.chart_square,
                          itemName: "Fee Reports",
                          isSubmenu: true,
                        ),
                        TemarLijeMenuItem(
                          route: '/fee/dues',
                          icon: Iconsax.warning_2,
                          itemName: "Pending Dues",
                          isSubmenu: true,
                        ),
                        TemarLijeMenuItem(
                          route: '/fee/scholarships',
                          icon: Iconsax.heart,
                          itemName: "Scholarships",
                          isSubmenu: true,
                        ),
                      ],
                    ),

                    const SizedBox(height: TemarLijeSizes.spaceBtwItems),

                    // Settings with Submenu
                    TemarLijeMenuItem(
                      route: '/settings',
                      icon: Iconsax.setting_2,
                      itemName: "Settings",
                      children: [
                        TemarLijeMenuItem(
                          route: '/settings/profile',
                          icon: Iconsax.profile_circle,
                          itemName: "Profile Settings",
                          isSubmenu: true,
                        ),
                        TemarLijeMenuItem(
                          route: TemarLijeRoutes.joinTeacher,
                          icon: Iconsax.add_circle,
                          itemName: "Join School",
                          isSubmenu: true,
                        ),
                        TemarLijeMenuItem(
                          route: '/settings/security',
                          icon: Iconsax.shield_tick,
                          itemName: "Security",
                          isSubmenu: true,
                        ),
                        TemarLijeMenuItem(
                          route: '/settings/notifications',
                          icon: Iconsax.notification,
                          itemName: "Notifications",
                          isSubmenu: true,
                          children: [
                            TemarLijeMenuItem(
                              route: '/settings/notifications/email',
                              icon: Iconsax.sms,
                              itemName: "Email Settings",
                              isSubmenu: true,
                            ),
                            TemarLijeMenuItem(
                              route: '/settings/notifications/push',
                              icon: Iconsax.mobile,
                              itemName: "Push Notifications",
                              isSubmenu: true,
                            ),
                          ],
                        ),
                        TemarLijeMenuItem(
                          route: '/settings/preferences',
                          icon: Iconsax.color_swatch,
                          itemName: "Preferences",
                          isSubmenu: true,
                        ),
                      ],
                    ),

                    const SizedBox(height: TemarLijeSizes.spaceBtwItems),

                    // Help & Support
                    const TemarLijeMenuItem(
                      route: '/help',
                      icon: Iconsax.message_question,
                      itemName: "Help & Support",
                    ),

                    const SizedBox(height: TemarLijeSizes.spaceBtwItems),

                    // Logout
                    const TemarLijeMenuItem(
                      route: '/logout',
                      icon: Iconsax.logout,
                      itemName: "Logout",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
