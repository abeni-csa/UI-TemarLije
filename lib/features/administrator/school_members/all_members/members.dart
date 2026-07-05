import 'package:flutter/material.dart';
import 'package:ui_temarlije/common/widgets/layouts/template/site_layout.dart';
import 'package:ui_temarlije/features/administrator/school_members/all_members/responsive_screens/members_desktop.dart';
import 'package:ui_temarlije/features/administrator/school_members/all_members/responsive_screens/members_mobile.dart';
import 'package:ui_temarlije/features/administrator/school_members/all_members/responsive_screens/members_tablet.dart';

class AllMembersScreen extends StatelessWidget {
  const AllMembersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TemarLijeSiteTemplate(
      mobile: MembersMobileScreen(),
      tablet: MembersTabletScreen(),
      desktop: MembersDesktopScreen(),
    );
  }
}
