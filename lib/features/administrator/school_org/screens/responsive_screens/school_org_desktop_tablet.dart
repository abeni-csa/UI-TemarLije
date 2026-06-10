import 'package:flutter/material.dart';
import 'package:ui_temarlije/features/administrator/school_org/screens/widgets/school_org_view.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class SchoolOrgDesktopTablet extends StatelessWidget {
  const SchoolOrgDesktopTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsetsGeometry.all(TemarLijeSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [SchoolOrgView()],
      ),
    );
  }
}
