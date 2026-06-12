import 'package:flutter/material.dart';
import 'package:ui_temarlije/features/membership/screens/widgets/membership_view.dart';

import 'package:ui_temarlije/utils/constants/sizes.dart';

class SchoolMembershipMobile extends StatelessWidget {
  const SchoolMembershipMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsetsGeometry.all(TemarLijeSizes.defaultSpace),
        child: Column(children: [SchoolMembershipView()]),
      ),
    );
  }
}
