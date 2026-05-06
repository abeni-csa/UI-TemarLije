import 'package:flutter/material.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';
import 'package:ui_temarlije/utils/constants/text_string.dart';
import 'package:iconsax/iconsax.dart';

class TemarLijeLoginForm extends StatelessWidget {
  const TemarLijeLoginForm({super.key});
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsetsGeometry.symmetric(
          vertical: TemarLijeSizes.spaceBtwSections,
        ),
        child: Column(
          children: [
            // Email
            TextFormField(
              maxLength: 255,
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: TemarLijeTexts.email,
              ),
            ),
            const SizedBox(height: TemarLijeSizes.spaceBtwInputFields),
            // Password
            TextFormField(
              maxLength: 255,
              decoration: InputDecoration(
                prefixIcon: Icon(Iconsax.password_check),
                labelText: TemarLijeTexts.password,
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Iconsax.eye_slash),
                ),
              ),
            ),
            const SizedBox(height: TemarLijeSizes.spaceBtwInputFields / 2),
            // Remeber Password && Forget Password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Remeber Me
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(value: false, onChanged: (value) {}),
                    const Text(TemarLijeTexts.rememberMe),
                  ],
                ),
                // Forget Password
                TextButton(
                  onPressed: () {},
                  child: const Text(TemarLijeTexts.forgetPassword),
                ),
              ],
            ),
            const SizedBox(height: TemarLijeSizes.spaceBtwInputFields),

            /// Sign In Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(TemarLijeTexts.signIn),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
