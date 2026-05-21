import 'package:get/get.dart';
import 'package:ui_temarlije/features/authentication/screens/dashboard/dashboard_screen.dart';
import 'package:ui_temarlije/features/authentication/screens/forget_password/forget_password_screen.dart';
import 'package:ui_temarlije/features/authentication/screens/login/login_screen.dart';
import 'package:ui_temarlije/features/authentication/screens/reset_password/reset_password_screen.dart';
// import 'package:ui_temarlije/features/authentication/screens/signup/signup_screen.dart';
// import 'package:ui_temarlije/features/principal/screens/principal_detail_screen.dart';
import 'package:ui_temarlije/features/principal/screens/principal_list_screen.dart';
import 'package:ui_temarlije/features/teachers/screens/lesson_planning/lesson_planning_screen.dart';
import 'package:ui_temarlije/routes/routes.dart';
import 'package:ui_temarlije/routes/routes_middilware.dart';
import 'package:ui_temarlije/views/screens/gradebook_screen.dart';
import 'package:ui_temarlije/bindings/auth_bindings.dart';

class TemarLijeAppRoutes {
  static final List<GetPage> pages = [
    GetPage(
      name: TemarLijeRoutes.signUp,
      page: () => LoginScreen(),
      binding: AuthBindings(),
    ),
    GetPage(name: TemarLijeRoutes.markListPage, page: () => GradebookScreen()),
    GetPage(
      name: TemarLijeRoutes.logIn,
      page: () => LoginScreen(),
      binding: AuthBindings(),
    ),
    GetPage(
      name: TemarLijeRoutes.principals,
      page: () => PrincipalListScreen(),
      binding: AuthBindings(),
    ),
    GetPage(
      name: TemarLijeRoutes.logIn,
      page: () => LoginScreen(),
      binding: AuthBindings(),
    ),
    GetPage(
      name: TemarLijeRoutes.dashbord,
      page: () => DashboardScreen(),
      middlewares: [TemarLijeRouteMiddlware()],
    ),
    GetPage(
      name: TemarLijeRoutes.resetPassword,
      page: () => ResetPasswordScreen(),
    ),
    GetPage(
      name: TemarLijeRoutes.forgetPassword,
      page: () => ForgetPasswordScreen(),
    ),
    GetPage(
      name: TemarLijeRoutes.toolLessonPlaner,
      page: () => const LessonPlanningScreen(),
    ),
  ];
}
