import 'package:get/get.dart';
import 'package:ui_temarlije/data/repositories/authentication_repository.dart';
import 'package:ui_temarlije/features/authentication/controllers/login_controller.dart';
import 'package:ui_temarlije/features/authentication/controllers/signup_controller.dart';
import 'package:ui_temarlije/service/network/dio_client.dart';
import 'package:ui_temarlije/utils/helpers/network_manager.dart';

/// Dependency injection bindings for authentication module
/// Registers all required dependencies before they're used
class AuthBindings extends Bindings {
  @override
  void dependencies() {
    // Core network dependencies (lazy-loaded to improve startup time)
    Get.lazyPut<DioClient>(() => DioClient(), fenix: true);
    Get.lazyPut<NetworkManager>(() => NetworkManager(), fenix: true);

    // Repository layer
    Get.lazyPut<AuthRepository>(() => AuthRepository(), fenix: true);

    // Controller layer
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<SignupController>(() => SignupController());
  }
}
