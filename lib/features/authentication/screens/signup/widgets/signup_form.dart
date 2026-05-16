import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ui_temarlije/features/authentication/controllers/signup_controller.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';
import 'package:ui_temarlije/utils/validators/validation.dart';
import 'package:ui_temarlije/common/widgets/buttons/primary_button.dart';

import 'package:ui_temarlije/utils/constants/text_string.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SignupController>();
    return Container(
      padding: const EdgeInsets.only(
        top: TemarLijeSizes.xl - 15,
        bottom: TemarLijeSizes.xl,
      ),
      child: Form(
        key: controller.signupFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: TemarLijeSizes.spaceBtwItems),
            TextFormField(
              controller: controller.emailController,
              validator: (value) => TemarLijeValidator.validateEmail(value),
              decoration: const InputDecoration(
                label: Text(TemarLijeTexts.tEmail),
                prefixIcon: Icon(Iconsax.emoji_normal5),
              ),
            ),
            const SizedBox(height: TemarLijeSizes.spaceBtwItems),
            Obx(
              () => TextFormField(
                obscureText: controller.hidePassword.value,
                controller: controller.passwordController,
                validator: (value) =>
                    TemarLijeValidator.validatePassword(value),
                decoration: InputDecoration(
                  label: const Text(TemarLijeTexts.tPassword),
                  prefixIcon: const Icon(Icons.fingerprint),
                  suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.value =
                        !controller.hidePassword.value,
                    icon: const Icon(Iconsax.eye_slash),
                  ),
                ),
              ),
            ),
            const SizedBox(height: TemarLijeSizes.spaceBtwItems),
            Obx(
              () => TemarLijePrimaryButton(
                isLoading: controller.isLoading.value ? true : false,
                text: TemarLijeTexts.tSignup.tr,
                onPressed: controller.isLoading.value
                    ? () => controller.signup
                    : () => controller.signup,
              ),
            ),
            const SizedBox(height: TemarLijeSizes.spaceBtwItems),
            // Signup link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(TemarLijeTexts.tAlreadyHaveAnAccount),
                TextButton(
                  onPressed: () => controller.goToLogin,
                  child: const Text(TemarLijeTexts.tLogin),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
