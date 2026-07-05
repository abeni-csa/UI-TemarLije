import 'package:flutter/material.dart';
import 'package:ui_temarlije/features/authentication/controllers/teacher_controller.dart';

class TeacherDateField extends StatelessWidget {
  const TeacherDateField({
    super.key,
    required this.controller,
    required this.label,
    required this.required,
  });
  final TeacherController controller;
  final String label;
  final bool required;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller.dateOfBirthController,
      readOnly: true,
      onTap: () => controller.selectDate(context),
      decoration: InputDecoration(
        labelText: required ? '$label *' : label,
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.calendar_today),
      ),
      validator: required
          ? (value) => value!.isEmpty ? '$label required' : null
          : null,
    );
  }
}

class TeacherGenderDropdownField extends StatelessWidget {
  const TeacherGenderDropdownField({
    super.key,
    required this.controller,
    required this.label,
    required this.required,
  });
  final TeacherController controller;
  final String label;
  final bool required;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: controller.selectedGender.value,
      decoration: const InputDecoration(
        labelText: 'Gender *',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.person_search),
      ),
      items: ['Male', 'Female'].map((gender) {
        return DropdownMenuItem(value: gender, child: Text(gender));
      }).toList(),
      onChanged: (value) => controller.selectedGender.value = value,
      validator: (value) => value == null ? 'Gender required' : null,
    );
  }
}
