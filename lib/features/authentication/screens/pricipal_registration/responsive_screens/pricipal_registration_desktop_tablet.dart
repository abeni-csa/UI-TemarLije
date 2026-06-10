import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/common/widgets/form/dropdown_builder.dart';
import 'package:ui_temarlije/common/widgets/layouts/template/loging_template.dart';
import 'package:ui_temarlije/features/authentication/controllers/principal_controller.dart';
import 'package:ui_temarlije/features/authentication/screens/student_registration/widget/studnet_text_input_field.dart';
import 'package:ui_temarlije/features/authentication/screens/pricipal_registration/widget/principal_text_input_field.dart';

class PricipalRegistrationDesktopTablet extends StatelessWidget {
  const PricipalRegistrationDesktopTablet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PrincipalController());
    return TemarLijeLoginScreenTemplate(
      child: Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Student Registration',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 24),

              // Personal Information
              StudnetTextSectionTitle(title: 'Personal Information'),
              _buildTwoColumnRow([
                StudnetTextInputField(
                  controller: controller.firstName,
                  label: 'First Name',
                  icon: Icons.person,
                  required: true,
                ),
                StudnetTextInputField(
                  controller: controller.middleName,
                  label: 'Middle Name',
                  icon: Icons.person_outline,
                  required: false,
                ),
              ]),
              _buildTwoColumnRow([
                StudnetTextInputField(
                  controller: controller.lastName,
                  label: 'Last Name',
                  icon: Icons.person,
                  required: true,
                ),
                PrincipalDateField(
                  controller: controller,
                  label: 'Date of Birth',
                  required: true,
                ),
              ]),
              _buildTwoColumnRow([
                StudnetIntigerInputField(
                  controller: controller.phoneNumber,
                  label: 'Phone Number',
                  icon: Icons.phone,
                  required: true,
                ),

                TemarLijesDropdownFormField(
                  label: 'Gender',
                  required: true,
                  items: ['Male', 'Female'],
                  initialValue: controller.selectedGender.value,
                  onSaved: (value) => controller.selectedGender.value = value,
                  validator: (value) =>
                      value == null ? 'Gender required' : null,
                ),
              ]),

              const SizedBox(height: 24),

              // Address Information
              StudnetTextSectionTitle(title: 'Address Information'),
              _buildTwoColumnRow([
                StudnetTextInputField(
                  controller: controller.region,
                  label: 'Region',
                  icon: Icons.map,
                  required: true,
                ),
                StudnetTextInputField(
                  controller: controller.zone,
                  label: 'Zone',
                  icon: Icons.location_on,
                  required: true,
                ),
              ]),
              _buildTwoColumnRow([
                StudnetTextInputField(
                  controller: controller.city,
                  label: 'City',
                  icon: Icons.location_city,
                  required: true,
                ),
                StudnetTextInputField(
                  controller: controller.kebeleNo,
                  label: 'Kebele No',
                  icon: Icons.home,
                  required: true,
                ),
              ]),

              const SizedBox(height: 24),

              // Account Information
              StudnetTextSectionTitle(title: 'Account Information'),

              const SizedBox(height: 16),

              // Checkbox and Submit
              Row(
                children: [
                  Obx(
                    () => Checkbox(
                      value: controller.agreeToTerms.value,
                      onChanged: (value) =>
                          controller.agreeToTerms.value = value!,
                    ),
                  ),
                  const Text('I agree to the terms and conditions'),
                ],
              ),
              const SizedBox(height: 24),
              Obx(
                () => ElevatedButton(
                  onPressed: controller.isLoading.value ? null : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator()
                      : const Text(
                          'Register Student',
                          style: TextStyle(fontSize: 16),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTwoColumnRow(List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: children[0]),
          const SizedBox(width: 12),
          Expanded(child: children[1]),
        ],
      ),
    );
  }
}
