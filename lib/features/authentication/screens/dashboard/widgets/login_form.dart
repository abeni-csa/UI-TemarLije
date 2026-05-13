import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/common/widgets/loaders/circular_loader.dart';
import 'package:ui_temarlije/features/authentication/controllers/login_controller.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';
import 'package:ui_temarlije/utils/constants/text_string.dart';
import 'package:iconsax/iconsax.dart';

class Dashborarddded extends StatelessWidget {
  const Dashborarddded({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();

    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsetsGeometry.symmetric(
          vertical: TemarLijeSizes.spaceBtwSections,
        ),
        child: Column(
          children: [
            // Email
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
            const SizedBox(height: TemarLijeSizes.spaceBtwInputFields),
            // Password
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
            const SizedBox(height: TemarLijeSizes.spaceBtwInputFields / 2),
            // Remeber Password && Forget Password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Remeber Me
                Obx(
                  () => Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: controller.rememberMe.value,
                        onChanged: controller.toggleRememberMe,
                      ),
                      const Text(TemarLijeTexts.rememberMe),
                    ],
                  ),
                ),
                // Forget Password
                TextButton(
                  onPressed: () => controller.goToForgotPassword,
                  child: const Text(TemarLijeTexts.forgetPassword),
                ),
              ],
            ),
            const SizedBox(height: TemarLijeSizes.spaceBtwInputFields),

            /// Sign In Button

            // Login button with loading state
            Obx(
              () => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
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
                          child: TemarLijeCircularLoader(),
                        )
                      : const Text(TemarLijeTexts.signIn),
                ),
              ),
            ),

            const SizedBox(height: TemarLijeSizes.spaceBtwInputFields),
            // Error message display
            Obx(() {
              if (controller.errorMessage.value != null) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: TemarLijeSizes.md),
                  child: Text(
                    controller.errorMessage.value!,
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                );
              }
              return const SizedBox.shrink();
            }),
          ],
        ),
      ),
    );
  }
}
