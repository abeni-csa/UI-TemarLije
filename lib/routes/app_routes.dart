import 'package:get/get.dart';
import 'package:ui_temarlije/features/authentication/screens/login/login_screen.dart';
import 'package:ui_temarlije/routes/routes.dart';

import 'package:ui_temarlije/views/screens/gradebook_screen.dart';

class TemarLijeAppRoutes {
  static final List<GetPage> pages = [
    GetPage(
      name: TemarLijeStaticPageRoutes.siteRoot,
      page: () => GradebookScreen(),
    ),
    GetPage(
      name: TemarLijeStaticPageRoutes.markListPage,
      page: () => GradebookScreen(),
    ),
    GetPage(name: TemarLijeStaticPageRoutes.logIn, page: () => LoginScreen()),
  ];
}
