import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/data/models/school_organzation.dart';
import 'package:ui_temarlije/features/administrator/school_org/school_org_controller.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';

class EditTeacherForm extends StatelessWidget {
  final SchoolOrganzationModel? schoolOrganization;
  final Function(CreateSchoolOrganzationRequest)? onSubmit;
  final Function(String, UpdateSchoolOrganzationRequest)? onSubmitUpdate;

  const EditTeacherForm({
    super.key,
    this.schoolOrganization,
    this.onSubmit,
    this.onSubmitUpdate,
  });

  @override
  Widget build(BuildContext context) {
    final SchoolOrgController controller = Get.find<SchoolOrgController>();

    // Set form data if editing
    if (schoolOrganization != null) {
      controller.setEditingSchool(schoolOrganization);
    } else {
      controller.setEditingSchool(null);
    }

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: TemarLijeColors.cardBackgroundColor,
      child: Container(
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
                        schoolOrganization == null
                            ? Icons.add_business
                            : Icons.edit_attributes,
                        color: TemarLijeColors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        controller.editingSchool == null
                            ? 'Create New School Organization'
                            : 'Edit School Organization',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // School Name
                TextFormField(
                  controller: controller.nameController,
                  decoration: InputDecoration(
                    labelText: 'School Name',
                    hintText: 'Enter school name',
                    prefixIcon: const Icon(Icons.business),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter school name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Established Year
                TextFormField(
                  controller: controller.establishedYearController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Established Year',
                    hintText: 'Enter established year',
                    prefixIcon: const Icon(Icons.calendar_today),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter established year';
                    }
                    final year = int.tryParse(value);
                    if (year == null ||
                        year < 1000 ||
                        year > DateTime.now().year) {
                      return 'Please enter a valid year';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // School Type
                Obx(
                  () => DropdownButtonFormField<SchoolType>(
                    initialValue: controller.selectedSchoolType.value,
                    decoration: InputDecoration(
                      labelText: 'School Type',
                      prefixIcon: const Icon(Icons.school),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    items: SchoolType.values.map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(type.toString().split('.').last),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        controller.selectedSchoolType.value = value;
                      }
                    },
                  ),
                ),
                const SizedBox(height: 16),

                // Address Section
                const Text(
                  'Address Information',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: controller.regionController,
                  decoration: InputDecoration(
                    labelText: 'Region Name',
                    hintText: 'Enter region address',
                    prefixIcon: const Icon(Icons.location_on),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
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
                  controller: controller.phoneController,
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
                  controller: controller.websiteController,
                  keyboardType: TextInputType.url,
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
                  controller: controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email Address',
                    hintText: 'Enter email address',
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
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
                                  _submitForm(controller, context);
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
                              : Text(
                                  controller.editingSchool == null
                                      ? 'Create'
                                      : 'Update',
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm(SchoolOrgController controller, BuildContext context) {
    if (controller.validateForm()) {
      if (controller.editingSchool != null && onSubmitUpdate != null) {
        final request = controller.getUpdateRequest();
        onSubmitUpdate!(controller.editingSchool!.id.toString(), request);
      } else if (onSubmit != null) {
        final request = controller.getCreateRequest();
        onSubmit!(request);
      }
      Navigator.pop(context);
    }
  }
}
