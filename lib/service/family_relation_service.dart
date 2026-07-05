import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:ui_temarlije/service/network/dio_client.dart';

class FamilyRelationService extends GetxService {
  static FamilyRelationService get instance => Get.find();

  final DioClient _dioClient = Get.find<DioClient>();
}
