import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ui_temarlije/common/widgets/images/t_circular_image.dart';
import 'package:ui_temarlije/common/widgets/layouts/sidebar/menu_items.dart';
import 'package:ui_temarlije/common/widgets/layouts/sidebar/sidebar_controller.dart';
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
                    // Dashboard
                    TemarLijeMenuItem(
                      route: "dashbord",
                      icon: Iconsax.activity,
                      itemName: "Dashboard",
                      children: [
                        TemarLijeMenuItem(
                          route: TemarLijeRoutes.dashbord,
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

                    // Student Management
                    TemarLijeMenuItem(
                      route: '/student-management',
                      icon: Iconsax.people,
                      itemName: "Student Management",
                      children: [
                        TemarLijeMenuItem(
                          route: '/student-management/all-students',
                          icon: Iconsax.profile_circle,
                          itemName: "All Students",
                          isSubmenu: true,
                        ),
                        TemarLijeMenuItem(
                          route: '/student-management/enrollments',
                          icon: Iconsax.add_circle,
                          itemName: "Enrollments",
                          isSubmenu: true,
                        ),
                        TemarLijeMenuItem(
                          route: '/student-management/classes',
                          icon: Iconsax.building,
                          itemName: "Classes",
                          isSubmenu: true,
                        ),
                      ],
                    ),
                    // Teachers  Management
                    TemarLijeMenuItem(
                      route: '/teachers-management',
                      icon: Iconsax.teacher,
                      itemName: "Teachers Management",
                      children: [
                        TemarLijeMenuItem(
                          route: TemarLijeRoutes.schoolTeachers,
                          icon: Iconsax.profile_circle,
                          itemName: "All Teachers",
                          isSubmenu: true,
                        ),
                        TemarLijeMenuItem(
                          route: TemarLijeRoutes.teachersEnrollments,
                          icon: Iconsax.add_circle,
                          itemName: "Join Request",
                          isSubmenu: true,
                        ),
                        TemarLijeMenuItem(
                          route: '/teacher-management/attendance',
                          icon: Iconsax.timer,
                          itemName: "Attendance",
                          isSubmenu: true,
                        ),
                      ],
                    ),
                    // Staff Management
                    TemarLijeMenuItem(
                      route: '/staff-management',
                      icon: Iconsax.user_cirlce_add,
                      itemName: "Staff Management",
                      children: [
                        TemarLijeMenuItem(
                          route: '/staff-management/all-staff',
                          icon: Iconsax.profile_circle,
                          itemName: "All Staff",
                          isSubmenu: true,
                        ),
                        TemarLijeMenuItem(
                          route: '/staff-management/departments',
                          icon: Iconsax.building_4,
                          itemName: "Departments",
                          isSubmenu: true,
                        ),
                        TemarLijeMenuItem(
                          route: '/staff-management/attendance',
                          icon: Iconsax.timer,
                          itemName: "Attendance",
                          isSubmenu: true,
                        ),
                        TemarLijeMenuItem(
                          route: '/staff-management/leave',
                          icon: Iconsax.calendar_edit,
                          itemName: "Leave Management",
                          isSubmenu: true,
                        ),
                      ],
                    ),

                    // Users
                    TemarLijeMenuItem(
                      route: '/users',
                      icon: Iconsax.user,
                      itemName: "Users",
                      children: [
                        TemarLijeMenuItem(
                          route: TemarLijeRoutes.schoolUserJoin,

                          icon: Iconsax.profile_circle,
                          itemName: "All Users",
                          isSubmenu: true,
                        ),
                        TemarLijeMenuItem(
                          route: TemarLijeRoutes.allMembers,

                          icon: Iconsax.box_add,
                          itemName: "Join Request's",
                          isSubmenu: true,
                        ),
                        TemarLijeMenuItem(
                          route: TemarLijeRoutes.schoolTeachers,
                          icon: Iconsax.security_user,
                          itemName: "Roles & Permissions",
                          isSubmenu: true,
                        ),
                      ],
                    ),

                    // Academics
                    TemarLijeMenuItem(
                      route: '',
                      icon: Iconsax.book,
                      itemName: "Academics",
                      children: [
                        TemarLijeMenuItem(
                          route: '/academics/subjects',
                          icon: Iconsax.book_1,
                          itemName: "Subjects",
                          isSubmenu: true,
                        ),
                        TemarLijeMenuItem(
                          route: '/academics/grades',
                          icon: Iconsax.chart,
                          itemName: "Grades",
                          isSubmenu: true,
                        ),
                        TemarLijeMenuItem(
                          route: '/academics/exams',
                          icon: Iconsax.document_text,
                          itemName: "Exams",
                          isSubmenu: true,
                        ),
                        TemarLijeMenuItem(
                          route: '/academics/timetable',
                          icon: Iconsax.calendar,
                          itemName: "Timetable",
                          isSubmenu: true,
                        ),
                      ],
                    ),

                    // Communication
                    TemarLijeMenuItem(
                      route: '/communication',
                      icon: Iconsax.message,
                      itemName: "Communication",
                      children: [
                        TemarLijeMenuItem(
                          route: '/communication/announcements',
                          icon: Iconsax.message,
                          itemName: "Announcements",
                          isSubmenu: true,
                        ),
                        TemarLijeMenuItem(
                          route: '/communication/messages',
                          icon: Iconsax.sms,
                          itemName: "Messages",
                          isSubmenu: true,
                        ),
                        TemarLijeMenuItem(
                          route: '/communication/notifications',
                          icon: Iconsax.notification,
                          itemName: "Notifications",
                          isSubmenu: true,
                        ),
                      ],
                    ),

                    // Finance
                    TemarLijeMenuItem(
                      route: '/finance',
                      icon: Iconsax.money,
                      itemName: "Finance",
                      children: [
                        TemarLijeMenuItem(
                          route: '/finance/fees',
                          icon: Iconsax.money_recive,
                          itemName: "Fees Management",
                          isSubmenu: true,
                        ),
                        TemarLijeMenuItem(
                          route: '/finance/expenses',
                          icon: Iconsax.money_send,
                          itemName: "Expenses",
                          isSubmenu: true,
                        ),
                        TemarLijeMenuItem(
                          route: '/finance/payroll',
                          icon: Iconsax.wallet,
                          itemName: "Payroll",
                          isSubmenu: true,
                        ),
                        TemarLijeMenuItem(
                          route: '/finance/reports',
                          icon: Iconsax.chart_square,
                          itemName: "Financial Reports",
                          isSubmenu: true,
                        ),
                      ],
                    ),

                    // Transport
                    TemarLijeMenuItem(
                      route: '/transport',
                      icon: Iconsax.truck,
                      itemName: "Transport",
                      children: [
                        TemarLijeMenuItem(
                          route: '/transport/routes',
                          icon: Iconsax.map,
                          itemName: "Routes",
                          isSubmenu: true,
                        ),
                        TemarLijeMenuItem(
                          route: '/transport/vehicles',
                          icon: Iconsax.car,
                          itemName: "Vehicles",
                          isSubmenu: true,
                        ),
                        TemarLijeMenuItem(
                          route: '/transport/tracking',
                          icon: Iconsax.location,
                          itemName: "Tracking",
                          isSubmenu: true,
                        ),
                      ],
                    ),

                    // Resources
                    TemarLijeMenuItem(
                      route: '/resources',
                      icon: Iconsax.folder,
                      itemName: "Resources",
                      children: [
                        TemarLijeMenuItem(
                          route: '/resources/library',
                          icon: Iconsax.book_1,
                          itemName: "Library",
                          isSubmenu: true,
                        ),
                        TemarLijeMenuItem(
                          route: '/resources/documents',
                          icon: Iconsax.document,
                          itemName: "Documents",
                          isSubmenu: true,
                        ),
                        TemarLijeMenuItem(
                          route: '/resources/assets',
                          icon: Iconsax.box,
                          itemName: "Assets",
                          isSubmenu: true,
                        ),
                      ],
                    ),

                    // Reports & Analytics
                    TemarLijeMenuItem(
                      route: '/reports',
                      icon: Iconsax.chart_square,
                      itemName: "Reports & Analytics",
                      children: [
                        TemarLijeMenuItem(
                          route: '/reports/academic',
                          icon: Iconsax.chart,
                          itemName: "Academic Reports",
                          isSubmenu: true,
                        ),
                        TemarLijeMenuItem(
                          route: '/reports/financial',
                          icon: Iconsax.chart_2,
                          itemName: "Financial Reports",
                          isSubmenu: true,
                        ),
                        TemarLijeMenuItem(
                          route: '/reports/attendance',
                          icon: Iconsax.chart_3,
                          itemName: "Attendance Reports",
                          isSubmenu: true,
                        ),
                        TemarLijeMenuItem(
                          route: '/reports/custom',
                          icon: Iconsax.setting,
                          itemName: "Custom Reports",
                          isSubmenu: true,
                        ),
                      ],
                    ),

                    // Settings
                    TemarLijeMenuItem(
                      route: '/settings',
                      icon: Iconsax.setting_2,
                      itemName: "Settings",
                      children: [
                        TemarLijeMenuItem(
                          route: TemarLijeRoutes.school,
                          icon: Iconsax.home_11,
                          itemName: "My School",
                          isSubmenu: true,
                        ),
                        TemarLijeMenuItem(
                          route: '/settings/general',
                          icon: Iconsax.building,
                          itemName: "General Settings",
                          isSubmenu: true,
                        ),
                        TemarLijeMenuItem(
                          route: '/settings/profile',
                          icon: Iconsax.profile_circle,
                          itemName: "Profile Settings",
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
                        ),
                      ],
                    ),

                    // Admin Only
                    TemarLijeMenuItem(
                      route: '/admin',
                      icon: Iconsax.security_user,
                      itemName: "Admin Only",
                      children: [
                        TemarLijeMenuItem(
                          route: '/admin/dashboard',
                          icon: Iconsax.activity,
                          itemName: "Admin Dashboard",
                          isSubmenu: true,
                        ),
                        TemarLijeMenuItem(
                          route: '/admin/logs',
                          icon: Iconsax.document,
                          itemName: "System Logs",
                          isSubmenu: true,
                        ),
                        TemarLijeMenuItem(
                          route: '/admin/backup',
                          icon: Iconsax.cloud,
                          itemName: "Backup",
                          isSubmenu: true,
                        ),
                      ],
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
