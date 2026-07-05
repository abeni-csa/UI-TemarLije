import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/common/widgets/form/dropdown_builder.dart';
import 'package:ui_temarlije/features/authentication/controllers/teacher_controller.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';
import 'package:ui_temarlije/utils/validators/validation.dart';

class TeacherRegistrationForm extends StatelessWidget {
  const TeacherRegistrationForm({super.key});

  @override
  Widget build(BuildContext context) {
    final TeacherController controller = Get.isRegistered<TeacherController>()
        ? Get.find<TeacherController>()
        : Get.put(TeacherController());
    return Container(
      padding: const EdgeInsets.all(24),
      constraints: const BoxConstraints(maxWidth: 600, maxHeight: 700),
      child: Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: TemarLijeColors.accent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.add_business,
                      color: TemarLijeColors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Create Teachers Profle',

                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Frist Name
              TextFormField(
                controller: controller.firstNameController,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  hintText: 'abebe alemu',
                  prefixIcon: const Icon(Icons.business),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) =>
                    TemarLijeValidator.validateEmptyText('First Name', value),
              ),

              const SizedBox(height: TemarLijeSizes.spaceBtwItems),

              // Middle Name
              TextFormField(
                controller: controller.middleNameController,
                decoration: InputDecoration(
                  labelText: 'Middle Name',
                  hintText: 'abebe alemu',
                  prefixIcon: const Icon(Icons.business),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) =>
                    TemarLijeValidator.validateEmptyText('Middle Name', value),
              ),

              const SizedBox(height: TemarLijeSizes.spaceBtwItems),
              // Last Name
              TextFormField(
                controller: controller.lastNameController,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  hintText: 'abebe alemu',
                  prefixIcon: const Icon(Icons.business),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) =>
                    TemarLijeValidator.validateEmptyText('Last Name', value),
              ),

              const SizedBox(height: TemarLijeSizes.spaceBtwItems),
              TemarLijesDropdownFormField(
                label: 'Gender',
                required: true,
                items: ['Male', 'Female'],
                initialValue: controller.selectedGender.value,
                onChanged: (value) => controller.selectedGender.value = value,
                onSaved: (value) => controller.selectedGender.value = value,
                validator: (value) => value == null ? 'Gender required' : null,
              ),
              const SizedBox(height: TemarLijeSizes.spaceBtwItems),

              // Address Section
              const Text(
                'Address Information',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller.regionController,
                      decoration: InputDecoration(
                        labelText: 'Region Name',
                        hintText: 'Enter region address',

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: controller.zoneController,
                      decoration: InputDecoration(
                        labelText: 'Zone',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller.cityController,
                      decoration: InputDecoration(
                        labelText: 'City',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: controller.kebeleController,
                      decoration: InputDecoration(
                        labelText: 'Kebele Code',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Contact Section
              const Text(
                'Contact Information',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: controller.phoneNumberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  hintText: 'Enter phone number',
                  prefixIcon: const Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: controller.yearsOfExperienceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Website',
                  hintText: 'Enter website address',
                  prefixIcon: const Icon(Icons.language),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: controller.genderController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  hintText: 'Enter email address',
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) => TemarLijeValidator.validateEmail(value),
              ),
              const SizedBox(height: 24),

              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Obx(
                      () => ElevatedButton(
                        onPressed: controller.isLoading.value
                            ? null
                            : () {
                                // _submitForm(controller, context);
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: TemarLijeColors.accent,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: controller.isLoading.value
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Text('Create'),
                      ),
                    ),
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
