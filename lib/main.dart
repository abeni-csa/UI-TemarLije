import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:ui_temarlije/bindings/auth_bindings.dart';
import 'package:ui_temarlije/common/widgets/layouts/template/site_layout.dart';
import 'package:ui_temarlije/routes/app_routes.dart';
import 'package:ui_temarlije/routes/routes.dart';
import 'package:ui_temarlije/utils/constants/text_string.dart';
import 'package:ui_temarlije/utils/theme/theme.dart';

Future<void> main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  // Ensure Flutter binding is initialized (for any platform-specific setup)

  if (Platform.isWindows) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  // Run the app with Riverpod ProviderScope
  runApp(const ProviderScope(child: TemarLijeMainApp()));
}

/// The main app.
class TemarLijeMainApp extends StatelessWidget {
  /// Constructs a [TemarLijeMainApp]
  const TemarLijeMainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: TemarLijeTexts.appName,
      themeMode: ThemeMode.light,
      theme: TemarLijeAppTheme.lightTheme,
      darkTheme: TemarLijeAppTheme.darkTheme,
      initialBinding: TemarLijeAppBindings(),
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
        children: [Text("NotFOund")],
      ),
    ),
    desktop: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text("NotFOund")],
      ),
    ),
    mobile: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text("NotFOund")],
      ),
    ),
  );
}
