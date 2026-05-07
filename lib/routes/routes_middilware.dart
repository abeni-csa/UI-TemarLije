import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/routes/routes.dart';

class TemarLijeMiddlware extends GetMiddleware {
  RouteSettings? redirect(String? route) {
    final isAuteticated = false;
    return isAuteticated
        ? null
        : const RouteSettings(name: TemarLijeRoutes.logIn);
  }
}
