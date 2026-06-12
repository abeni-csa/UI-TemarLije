import 'package:flutter/material.dart';
import 'package:ui_temarlije/features/membership/screens/widgets/membership_view.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class SchoolMembershipDesktopTablet extends StatelessWidget {
  const SchoolMembershipDesktopTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsetsGeometry.all(TemarLijeSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [SchoolMembershipView()],
      ),
    );
  }
}
