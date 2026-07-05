import 'package:get/get.dart';
import 'package:ui_temarlije/service/school_orginzation_service.dart';

class MembershipControllers extends GetxController {
  static MembershipControllers get instance =>
      Get.find<MembershipControllers>();
  final SchoolOrganizationService _schoolOrganizationService =
      Get.find<SchoolOrganizationService>();
}
