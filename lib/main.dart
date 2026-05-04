import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:io';
import 'package:go_router/go_router.dart';
import 'package:ui_temarlije/app.dart';

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

/// The route configuration.
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const ResponsiveDesignScreen();
      },
    ),
  ],
  errorBuilder: (BuildContext context, GoRouterState state) =>
      ErrorScreen(state.error!),
);

/// The main app.
class MyApp extends StatelessWidget {
  /// Constructs a [MyApp]
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: _router);
  }
}

/// The screen of the error page.
class ErrorScreen extends StatelessWidget {
  /// Creates an [ErrorScreen].
  const ErrorScreen(this.error, {super.key});

  /// The error to display.
  final Exception error;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('My "Page Not Found" Screen')),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SelectableText(error.toString()),
          TextButton(
            onPressed: () => context.go('/'),
            child: const Text('Home'),
          ),
        ],
      ),
    ),
  );
}
