import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:io';
import 'package:ui_temarlije/routes/app_routes.dart';
import 'package:ui_temarlije/routes/routes.dart';
import 'package:ui_temarlije/utils/constants/text_string.dart';
import 'package:ui_temarlije/utils/theme/theme.dart';

void main() {
  // 2. Initialize FFI for Windows

  // Ensure Flutter binding is initialized (for any platform-specific setup)
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  // Run the app with Riverpod ProviderScope
  runApp(const ProviderScope(child: MyApp()));
}

/// The main app.
class MyApp extends StatelessWidget {
  /// Constructs a [MyApp]
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: TemarLijeTexts.appName,
      themeMode: ThemeMode.light,
      theme: TemarLijeAppTheme.lightTheme,
      darkTheme: TemarLijeAppTheme.darkTheme,
      getPages: TemarLijeAppRoutes.pages,
      initialRoute: TemarLijeStaticPageRoutes.logIn,
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
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('My "Page Not Found" Screen')),
    body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center)),
  );
}
