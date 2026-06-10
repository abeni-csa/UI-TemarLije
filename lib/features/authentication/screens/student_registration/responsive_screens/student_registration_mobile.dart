import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/common/widgets/form/dropdown_builder.dart';
import 'package:ui_temarlije/common/widgets/layouts/template/loging_template.dart';
import 'package:ui_temarlije/features/authentication/controllers/student_registration_controller.dart';
import 'package:ui_temarlije/features/authentication/screens/student_registration/widget/studnet_text_input_field.dart';

class StudentRegistrationMobile extends StatelessWidget {
  const StudentRegistrationMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StudentRegistrationController());

    return TemarLijeLoginScreenTemplate(
      child: Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Student Registration',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),

              // Personal Information
              StudnetTextSectionTitle(title: 'Personal Information'),
              StudnetTextInputField(
                controller: controller.firstName,
                label: 'First Name',
                icon: Icons.person,
                required: true,
              ),
              const SizedBox(height: 12),
              StudnetTextInputField(
                controller: controller.middleName,
                label: 'Middle Name',
                icon: Icons.person,
                required: true,
              ),
              const SizedBox(height: 12),
              StudnetTextInputField(
                controller: controller.lastName,
                label: 'Last Name',
                icon: Icons.person,
                required: true,
              ),
              const SizedBox(height: 12),
              StudnetDateField(
                controller: controller,
                label: 'Date of Birth',
                required: true,
              ),
              const SizedBox(height: 12),

              StudnetIntigerInputField(
                controller: controller.phoneNumber,
                label: 'Phone Number',
                icon: Icons.phone,
                required: true,
              ),
              const SizedBox(height: 12),

              TemarLijesDropdownFormField(
                label: 'Gender',
                required: true,
                items: ['Male', 'Female'],
                initialValue: controller.selectedGender.value,
                onChanged: (value) => controller.selectedGender.value =
                    value, // Update reactive variable
                onSaved: (value) => controller.selectedGender.value = value,
                validator: (value) => value == null ? 'Gender required' : null,
              ),
              // Address Information
              StudnetTextSectionTitle(title: 'Address Information'),
              StudnetTextInputField(
                controller: controller.region,
                label: 'Region',
                icon: Icons.map,
                required: true,
              ),
              const SizedBox(height: 12),
              StudnetTextInputField(
                controller: controller.zone,
                label: 'Zone',
                icon: Icons.location_on,
                required: true,
              ),
              const SizedBox(height: 12),
              StudnetTextInputField(
                controller: controller.city,
                label: 'City',
                icon: Icons.location_city,
                required: true,
              ),
              const SizedBox(height: 12),
              StudnetTextInputField(
                controller: controller.kebeleNo,
                label: 'Kebele No',
                icon: Icons.home,
                required: true,
              ),

              const SizedBox(height: 20),
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
                  Expanded(child: Text('I agree to the terms and conditions')),
                ],
              ),
              const SizedBox(height: 20),
              Obx(
                () => ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : controller.registerStudent,
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
}
