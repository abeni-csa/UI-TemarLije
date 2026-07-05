import 'package:flutter/material.dart';
import 'package:ui_temarlije/common/widgets/layouts/template/site_layout.dart';
import 'package:ui_temarlije/features/administrator/school_members/create_membership/responsive_screens/members_desktop.dart';
import 'package:ui_temarlije/features/administrator/school_members/create_membership/responsive_screens/members_mobile.dart';
import 'package:ui_temarlije/features/administrator/school_members/create_membership/responsive_screens/members_tablet.dart';

class CreateMembersScreen extends StatelessWidget {
  const CreateMembersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TemarLijeSiteTemplate(
      mobile: CreateMembersMobileScreen(),
      tablet: CreateMembersTabletScreen(),
      desktop: CreateMembersDesktopScreen(),
    );
  }
}
