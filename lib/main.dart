import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui_temarlije/views/screens/gradebook_screen.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';

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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Interactive Gradebook',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // Optional: Customize DataTable theme
        dataTableTheme: DataTableThemeData(
          columnSpacing: 20,
          horizontalMargin: 16,
          headingRowColor: WidgetStateProperty.resolveWith(
            (states) => Colors.grey[100],
          ),
          dataRowColor: WidgetStateProperty.resolveWith(
            (states) => Colors.white,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
          ),
        ),
      ),
      home: const GradebookScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
