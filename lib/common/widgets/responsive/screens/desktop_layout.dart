import 'package:flutter/material.dart';
import 'package:ui_temarlije/common/widgets/layouts/header/header.dart';
import 'package:ui_temarlije/common/widgets/layouts/sidebar/sidebar.dart';

class DesktopLayout extends StatelessWidget {
  DesktopLayout({super.key, this.body});

  final Widget? body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const Expanded(child: TemarLijeSidebar()),
          Expanded(
            flex: 5,
            child: Column(
              children: [
                TemarLijeHeader(),
                Expanded(
                  child: SingleChildScrollView(child: body ?? const SizedBox()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
