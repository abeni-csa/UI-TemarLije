import 'package:flutter/material.dart';
import 'package:ui_temarlije/common/widgets/layouts/template/site_layout.dart';
import 'package:ui_temarlije/data/models/section.dart';
import 'package:ui_temarlije/features/administrator/section_management/responsive_screens/sections_desktop.dart';
import 'package:ui_temarlije/features/administrator/section_management/responsive_screens/sections_mobile.dart';
import 'package:ui_temarlije/features/administrator/section_management/responsive_screens/sections_tablet.dart';
import 'package:uuid/uuid.dart';

class SectionManagement extends StatelessWidget {
  const SectionManagement({super.key, required this.section});
  final Section section;

  @override
  Widget build(BuildContext context) {
    const Uuid uuid = Uuid();
    final Section _ = Section(
      id: UuidValue.fromString(uuid.v4()),
      schoolId: UuidValue.fromString(uuid.v4()),
      classroomId: UuidValue.fromString(uuid.v4()),
      roomTeacherId: UuidValue.fromString(uuid.v4()),
      sectionName: 'Grade 10 - Alpha',
      sectionCode: 'G10-A',
      capacity: 30,
      currentEnrollment: 25,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now(),
    );

    return TemarLijeSiteTemplate(
      mobile: SectionMngMobileScreen(section: section),

      tablet: SectionMngTabletScreen(section: section),

      desktop: SectionMngDesktopScreen(section: section),
    );
  }
}
