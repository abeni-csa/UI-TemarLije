// lib/features/authentication/controllers/signup_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ui_temarlije/data/repositories/authentication_repository.dart';
import 'package:ui_temarlije/routes/routes.dart';

enum UserType {
  student('Student', '/api/v1/user/student'),
  teacher('Teacher', '/api/v1/user/teacher'),
  parent('Parent', '/api/v1/user/parent'),
  staff('Staff', '/api/v1/user/staff'),
  schoolAdmin('School Admin', '/api/v1/user/school-admin');

  final String displayName;
  final String apiEndpoint;

  const UserType(this.displayName, this.apiEndpoint);
}

class SignupController extends GetxController {
  static SignupController get instance => Get.find<SignupController>();

  final AuthRepository _authRepository = Get.find<AuthRepository>();
  final GetStorage _storage = GetStorage();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  // Form keys
  final signupFormKey = GlobalKey<FormState>();
  // Observable state
  final rememberMe = false.obs; // Remember me checkbox state
  final isLoading = false.obs;
  final hidePassword = true.obs;
  final hideConfirmPassword = true.obs;
  final errorMessage = Rxn<String>();
  final currentStep = 0.obs;
  final availableGenders = ['Male', 'Female', 'Other'].obs;

  @override
  void onClose() {
    // Clean up controllers
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    hidePassword.value = !hidePassword.value;
  }

  void toggleConfirmPasswordVisibility() {
    hideConfirmPassword.value = !hideConfirmPassword.value;
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }

  /// Navigates to forgot password recovery screen
  void goToForgotPassword() {
    Get.offAllNamed(TemarLijeRoutes.forgetPassword);
  }

  /// Toggles "Remember Me" checkbox state
  void toggleRememberMe(bool? value) {
    rememberMe.value = value ?? false;
  }

  /// Navigates to signup/registration screen
  void goToLogin() {
    try {
      // Check if route exists before navigating
      if (Get.currentRoute != TemarLijeRoutes.logIn) {
        Get.toNamed(TemarLijeRoutes.logIn);
      } else {
        // Already on signup page
        debugPrint('Already on signup page');
      }
    } catch (e) {
      debugPrint('Navigation error: $e');
      // Fallback to alternative navigation
      Get.offAllNamed(TemarLijeRoutes.signUp);
    }
  }

  Future<void> performSignup() async {
    isLoading.value = true;
    errorMessage.value = null;

    try {
      // First, register the user to get JWT
      final authResponse = await _authRepository.signup(
        emailController.text.trim(),
        passwordController.text,
      );
      if (rememberMe.value) {
        await _storage.write('REMEMBER_ME_EMAIL', emailController.text.trim());
        await _storage.write(
          'REMEMBER_ME_PASSWORD',
          passwordController.text.trim(),
        );
      }
      // Store the JWT token
      await _storage.write('refresh_token', authResponse.refreshToken);
      debugPrint(authResponse.refreshToken);
      await _storage.write('access_token', authResponse.accessToken);
      debugPrint(authResponse.accessToken);
      await _storage.write('recovery_codes', authResponse.recoveryCodes);

      await _storage.write('user_email', emailController.text.trim());
      debugPrint(emailController.text);
      // Navigate to dashboard on success
      Get.offNamed(TemarLijeRoutes.userType);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
