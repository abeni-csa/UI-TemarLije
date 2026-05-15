import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/data/repositories/authentication_repository.dart';
import 'package:ui_temarlije/routes/routes.dart';

class TemarLijeRouteMiddlware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    return AuthRepository.instance.isAuthteicated
        ? null
        : const RouteSettings(name: TemarLijeRoutes.logIn);
  }
}
