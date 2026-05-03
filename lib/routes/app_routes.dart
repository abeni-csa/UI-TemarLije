import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_temarlije/app.dart';
import 'package:ui_temarlije/routes/routes.dart';

class AppRoutes {
  static final pages = [
    GoRoute(
      name: "Resposnive Desin",
      path: TemarLijeStaticPageRoutes.responsivePage,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: ResponsiveDesignScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Change the opacity of the screen using a Curve based on the the animation's
            // value
            return FadeTransition(
              opacity: CurveTween(
                curve: Curves.easeInOutCirc,
              ).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
  ];
}
