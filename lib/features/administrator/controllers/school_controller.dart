import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/data/models/fileds.dart';
import 'package:ui_temarlije/features/administrator/school_org/model/school.dart';

class SchoolController extends GetxController {
  // school
  final TextEditingController schoolName = TextEditingController();
  final TextEditingController schoolType = TextEditingController();
  final TextEditingController establishedYear = TextEditingController();

  // location
  final TextEditingController locRegion = TextEditingController();
  final TextEditingController locZone = TextEditingController();
  final TextEditingController locCity = TextEditingController();
  final TextEditingController locKebele = TextEditingController();

  // address
  final TextEditingController addrRegion = TextEditingController();
  final TextEditingController addrZone = TextEditingController();
  final TextEditingController addrCity = TextEditingController();
  final TextEditingController addrKebele = TextEditingController();

  // contact
  final TextEditingController contactPhone = TextEditingController();
  final TextEditingController contactEmail = TextEditingController();
  final TextEditingController contactWebsite = TextEditingController();

  final Rxn<School> currentSchool = Rxn<School>();

  void createSchool() {
    final int year = int.tryParse(establishedYear.text) ?? 0;

    final loc = Location(
      region: locRegion.text.trim(),
      zone: locZone.text.trim(),
      city: locCity.text.trim(),
      kebeleNo: locKebele.text.trim(),
    );

    final addr = Location(
      region: addrRegion.text.trim(),
      zone: addrZone.text.trim(),
      city: addrCity.text.trim(),
      kebeleNo: addrKebele.text.trim(),
    );

    final contact = Contact(
      phone: contactPhone.text.trim(),
      email: contactEmail.text.trim(),
      website: contactWebsite.text.trim(),
    );

    final s = School(
      schoolName: schoolName.text.trim(),
      location: loc,
      address: addr,
      contact: contact,
      establishedYear: year,
      schoolType: schoolType.text.trim(),
    );

    currentSchool.value = s;
    // For now just print the JSON. Replace with API call when ready.
    debugPrint('Created school: ${s.toEncodedJson()}');
    Get.snackbar('Success', 'School created');
  }

  @override
  void onClose() {
    schoolName.dispose();
    schoolType.dispose();
    establishedYear.dispose();

    locRegion.dispose();
    locZone.dispose();
    locCity.dispose();
    locKebele.dispose();

    addrRegion.dispose();
    addrZone.dispose();
    addrCity.dispose();
    addrKebele.dispose();

    contactPhone.dispose();
    contactEmail.dispose();
    contactWebsite.dispose();

    super.onClose();
  }
}
