import 'package:flutter/material.dart';

import 'package:ui_temarlije/common/widgets/layouts/header/header.dart';
import 'package:ui_temarlije/common/widgets/layouts/sidebar/sidebar.dart';

class TabletLayout extends StatelessWidget {
  TabletLayout({super.key, this.body});
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  final Widget? body;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const TemarLijeSidebar(),
      appBar: TemarLijeHeader(scaffoldKey: scaffoldKey),
      body: SingleChildScrollView(child: body ?? const SizedBox()),
    );
  }
}
