import 'package:flutter/material.dart';
import 'package:ui_temarlije/features/administrator/school_members/all_members/widgets/all_members_view.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class MembersDesktopScreen extends StatelessWidget {
  const MembersDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(TemarLijeSizes.defaultSpace),
        child: AllMembersView(),
      ),
    );
  }
}
