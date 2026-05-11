import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/data/repositories/authentication_repository.dart';
import 'package:ui_temarlije/utils/helpers/network_manager.dart';

/// Manages user registration flow including form validation,
/// terms acceptance, and post-signup navigation
class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  final AuthRepository _authRepository = Get.find<AuthRepository>();
  final NetworkManager _networkManager = Get.find<NetworkManager>();

  // Form controllers for user input
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Form key for validation
  final signupFormKey = GlobalKey<FormState>();

  // Observable state variables
  final isLoading = false.obs; // Registration loading state
  final hidePassword = true.obs; // Password visibility toggle
  final hideConfirmPassword = true.obs; // Confirm password visibility toggle
  final acceptedTerms = false.obs; // Terms acceptance state
  final errorMessage = Rxn<String>(); // Error message display

  /// Registers a new user account
  /// Validates all inputs before making API request
  Future<void> signup() async {
    // Validate form inputs
    if (!signupFormKey.currentState!.validate()) return;

    // Check terms acceptance
    if (!acceptedTerms.value) {
      errorMessage.value = 'Please accept the terms and conditions';
      return;
    }

    // Verify internet connectivity
    if (!await _networkManager.checkConnectivity()) {
      errorMessage.value = 'No internet connection';
      return;
    }

    isLoading.value = true;
    errorMessage.value = null;

    try {
      final response = await _authRepository.signup(
        usernameController.text.trim(),
        passwordController.text.trim(),
      );

      if (response.requiresTwoFactor) {
        // Navigate to 2FA setup screen with recovery codes
        Get.toNamed(
          '/setup-2fa',
          arguments: {
            'userId': response.userId,
            'recoveryCodes': response.recoveryCodes,
          },
        );
      } else {
        // Registration successful
        Get.snackbar(
          'Success',
          'Account created successfully!',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );

        // Navigate to main app
        Get.offAllNamed('/home');
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  /// Toggles password field visibility
  void togglePasswordVisibility() {
    hidePassword.value = !hidePassword.value;
  }

  /// Toggles confirm password field visibility
  void toggleConfirmPasswordVisibility() {
    hideConfirmPassword.value = !hideConfirmPassword.value;
  }

  /// Toggles terms and conditions acceptance
  void toggleTermsAcceptance(bool? value) {
    acceptedTerms.value = value ?? false;
  }

  /// Navigates back to login screen
  void goToLogin() {
    Get.back();
  }

  /// Validates username format and constraints
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (value.length < 3) {
      return 'Email must be at least 3 characters';
    }
    if (value.length > 50) {
      return 'Email must be less than 50 characters';
    }
    if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
      return 'Email can only contain letters, numbers, and underscores';
    }
    return null;
  }

  /// Validates password strength and complexity
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)').hasMatch(value)) {
      return 'Password must contain uppercase, lowercase, and numbers';
    }
    return null;
  }

  /// Validates that confirm password matches original password
  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  void onClose() {
    // Clean up controllers to prevent memory leaks
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
