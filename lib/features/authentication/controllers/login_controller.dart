import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ui_temarlije/data/repositories/authentication_repository.dart';
import 'package:ui_temarlije/routes/routes.dart';

/// Manages login flow including authentication, 2FA verification,
/// and session persistence with "Remember Me" functionality
class LoginController extends GetxController {
  static LoginController get instance => Get.find<LoginController>();

  final AuthRepository _authRepository = Get.find<AuthRepository>();
  final GetStorage _storage = GetStorage();

  // Form controllers for text input fields
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final twoFactorController = TextEditingController();

  // Form keys for validation
  final loginFormKey = GlobalKey<FormState>();
  // final twoFactorFormKey = GlobalKey<FormState>();

  // Observable state variables
  final isLoading = false.obs; // Login loading state
  final isTwoFactorLoading = false.obs; // 2FA verification loading state
  final hidePassword = true.obs; // Password visibility toggle
  final rememberMe = false.obs; // Remember me checkbox state
  final requiresTwoFactor = false.obs; // 2FA required flag
  final twoFactorUserId = Rxn<String>(); // User ID for 2FA verification
  final errorMessage = Rxn<String>(); // Error message display

  @override
  void onInit() {
    super.onInit();
    _loadSavedCredentials();
  }

  /// Loads previously saved credentials if "Remember Me" was checked
  void _loadSavedCredentials() {
    final savedEmail = _storage.read('REMEMBER_ME_EMAIL');
    final savedPassword = _storage.read('REMEMBER_ME_PASSWORD');

    if (savedEmail != null && savedPassword != null) {
      emailController.text = savedEmail;
      passwordController.text = savedPassword;
      rememberMe.value = true;
    }
  }

  /// Authenticates user with email/username and password
  /// Handles both successful login and 2FA redirection
  Future<void> login() async {
    // Validate form inputs before proceeding
    // if (!loginFormKey.currentState!.validate()) return;

    // Verify internet connectivity
    // if (!await _networkManager.checkConnectivity()) {
    //   errorMessage.value = 'No internet connection';
    //   return;
    // }

    isLoading.value = true;
    errorMessage.value = null;

    try {
      final response = await _authRepository.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      if (response.requiresTwoFactor) {
        // Account requires 2FA - show verification screen
        requiresTwoFactor.value = true;
        twoFactorUserId.value = response.userId;
        isLoading.value = false;
      } else {
        // Login successful - save credentials if requested
        if (rememberMe.value) {
          await _storage.write(
            'REMEMBER_ME_EMAIL',
            emailController.text.trim(),
          );
          await _storage.write(
            'REMEMBER_ME_PASSWORD',
            passwordController.text.trim(),
          );
        } else {
          await _storage.remove('REMEMBER_ME_EMAIL');
          await _storage.remove('REMEMBER_ME_PASSWORD');
        }

        // Navigate to main app screen
        Get.offAllNamed(TemarLijeRoutes.dashbord);
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  // /// Verifies 2FA code and completes authentication
  // Future<void> verifyTwoFactor() async {
  //   // Validate 2FA form
  //   if (!twoFactorFormKey.currentState!.validate()) return;

  //   isTwoFactorLoading.value = true;
  //   errorMessage.value = null;

  //   try {
  //     await _authRepository.verifyTwoFactor(
  //       twoFactorController.text.trim(),
  //       userId: twoFactorUserId.value,
  //     );

  //     // Save credentials if "Remember Me" is checked
  //     if (rememberMe.value) {
  //       await _storage.write('REMEMBER_ME_EMAIL', emailController.text.trim());
  //       await _storage.write(
  //         'REMEMBER_ME_PASSWORD',
  //         passwordController.text.trim(),
  //       );
  //     }

  //     // Navigate to main app on successful verification
  //     Get.offAllNamed('/home');
  //   } catch (e) {
  //     errorMessage.value = e.toString();
  //   } finally {
  //     isTwoFactorLoading.value = false;
  //   }
  // }

  /// Resends 2FA code (if backend supports this feature)
  void resendTwoFactorCode() async {
    // TODO: Implement actual resend logic based on backend API
    Get.snackbar(
      'Info',
      'Please check your authenticator app for the code',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  /// Toggles password field visibility
  void togglePasswordVisibility() {
    hidePassword.value = !hidePassword.value;
  }

  /// Toggles "Remember Me" checkbox state
  void toggleRememberMe(bool? value) {
    rememberMe.value = value ?? false;
  }

  /// Navigates to forgot password recovery screen
  void goToForgotPassword() {
    Get.offAllNamed(TemarLijeRoutes.forgetPassword);
  }

  /// Navigates to signup/registration screen
  void goToSignup() {
    Get.offAllNamed(TemarLijeRoutes.signUp);
  }

  /// Resets 2FA state to return to login form
  void resetTwoFactorState() {
    requiresTwoFactor.value = false;
    twoFactorUserId.value = null;
    twoFactorController.clear();
    errorMessage.value = null;
  }

  @override
  void onClose() {
    // Clean up controllers to prevent memory leaks
    emailController.dispose();
    passwordController.dispose();
    twoFactorController.dispose();
    super.onClose();
  }
}
