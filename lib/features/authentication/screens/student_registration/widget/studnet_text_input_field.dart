import 'package:flutter/material.dart';
import 'package:ui_temarlije/features/authentication/controllers/student_registration_controller.dart';

class StudnetTextInputField extends StatelessWidget {
  const StudnetTextInputField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    required this.required,
    this.isEmail = false,
    this.isPassword = false,
  });
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool required;
  final bool isEmail;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      decoration: InputDecoration(
        labelText: required ? '$label *' : label,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(icon),
      ),
      validator: required
          ? (value) => value!.isEmpty ? '$label required' : null
          : null,
    );
  }
}

class StudnetIntigerInputField extends StatelessWidget {
  const StudnetIntigerInputField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    required this.required,
    this.isEmail = false,
    this.isPassword = false,
  });
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool required;
  final bool isEmail;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      decoration: InputDecoration(
        labelText: required ? '$label *' : label,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(icon),
      ),
      validator: required
          ? (value) => value!.isEmpty ? '$label required' : null
          : null,
    );
  }
}

class StudnetTextSectionTitle extends StatelessWidget {
  const StudnetTextSectionTitle({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, top: 8),
      child: Text(title, style: Theme.of(context).textTheme.titleMedium),
    );
  }
}
//   _buildDateField
//  _buildGenderDropdown

class StudnetDateField extends StatelessWidget {
  const StudnetDateField({
    super.key,
    required this.controller,
    required this.label,
    required this.required,
  });
  final StudentRegistrationController controller;
  final String label;
  final bool required;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller.dateOfBirth,
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

class StudnetGenderDropdownField extends StatelessWidget {
  const StudnetGenderDropdownField({
    super.key,
    required this.controller,
    required this.label,
    required this.required,
  });
  final StudentRegistrationController controller;
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
