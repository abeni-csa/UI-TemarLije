import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/features/authentication/controllers/login_controller.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';
import 'package:ui_temarlije/utils/constants/text_string.dart';
import 'package:iconsax/iconsax.dart';

class TemarLijeLoginForm extends StatelessWidget {
  const TemarLijeLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: controller.loginFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Email/Username field
              TextFormField(
                controller: controller.emailController,
                maxLength: 255,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.direct_right),
                  labelText: TemarLijeTexts.email,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email or username';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Password field
              Obx(
                () => TextFormField(
                  controller: controller.passwordController,
                  obscureText: controller.hidePassword.value,

                  maxLength: 255,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.password_check),
                    labelText: TemarLijeTexts.password,
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.hidePassword.value
                            ? Iconsax.eye_slash
                            : Icons.visibility,
                      ),
                      onPressed: controller.togglePasswordVisibility,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 8),

              // Remember me & Forgot password
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => Row(
                      children: [
                        Checkbox(
                          value: controller.rememberMe.value,
                          onChanged: controller.toggleRememberMe,
                        ),
                        const Text(TemarLijeTexts.rememberMe),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: controller.goToForgotPassword,
                    child: const Text(TemarLijeTexts.forgetPassword),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Error message
              Obx(() {
                if (controller.errorMessage.value != null) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      controller.errorMessage.value!,
                      style: const TextStyle(color: TemarLijeColors.error),
                      textAlign: TextAlign.center,
                    ),
                  );
                }
                return const SizedBox.shrink();
              }),

              // Login button
              Obx(
                () => ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : controller.login,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: controller.isLoading.value
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Login'),
                ),
              ),
              const SizedBox(height: 16),

              // Signup link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  TextButton(
                    onPressed: controller.goToSignup,
                    child: const Text('Sign up'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
