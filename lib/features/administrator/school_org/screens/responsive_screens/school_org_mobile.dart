import 'package:flutter/material.dart';
import 'package:ui_temarlije/features/administrator/school_org/screens/widgets/school_org_view.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class SchoolOrgMobile extends StatelessWidget {
  const SchoolOrgMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsetsGeometry.all(TemarLijeSizes.defaultSpace),
        child: Column(children: [SchoolOrgView()]),
      ),
    );
  }
}
