import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:ui_temarlije/bindings/app_bindings.dart';
import 'package:ui_temarlije/common/widgets/layouts/template/site_layout.dart';
import 'package:ui_temarlije/routes/app_routes.dart';
import 'package:ui_temarlije/routes/routes.dart';
import 'package:ui_temarlije/utils/constants/text_string.dart';
import 'package:ui_temarlije/utils/theme/theme.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  // Run the app with Riverpod ProviderScope / abebealemu@gamil.com
  runApp(const ProviderScope(child: TemarLijeMainApp()));
}

/// The main app.
class TemarLijeMainApp extends StatelessWidget {
  /// Constructs a [TemarLijeMainApp]
  const TemarLijeMainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: true,
      title: TemarLijeTexts.appName,
      themeMode: ThemeMode.light,
      theme: TemarLijeAppTheme.lightTheme,
      darkTheme: TemarLijeAppTheme.darkTheme,
      initialBinding: TemarLijeAppBindings(),
      defaultTransition: Transition.noTransition,
      transitionDuration: const Duration(milliseconds: 300),
      getPages: TemarLijeAppRoutes.pages,
      initialRoute: TemarLijeRoutes.logIn,
      unknownRoute: GetPage(
        name: "/page-not-found",
        page: () => const ErrorScreen(),
      ),
    );
  }
}

/// The screen of the error page.
class ErrorScreen extends StatelessWidget {
  /// Creates an [ErrorScreen].
  const ErrorScreen({super.key});

  /// The error to display.

  @override
  Widget build(BuildContext context) => TemarLijeSiteTemplate(
    tablet: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(" Not FOund")],
      ),
    ),
    desktop: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(" Not FOund")],
      ),
    ),
    mobile: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(" Not FOund")],
      ),
    ),
  );
}
