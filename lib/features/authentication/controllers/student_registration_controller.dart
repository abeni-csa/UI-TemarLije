import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/data/models/students.dart';
import 'package:ui_temarlije/data/models/fileds.dart';
import 'package:ui_temarlije/service/student_service.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';

class StudentRegistrationController extends GetxController {
  final StudentService _studentService = StudentService();
  static StudentRegistrationController get instance =>
      Get.find<StudentRegistrationController>();

  // Form Key
  final formKey = GlobalKey<FormState>();

  // Text Controllers
  final firstName = TextEditingController();
  final middleName = TextEditingController();
  final lastName = TextEditingController();
  final dateOfBirth = TextEditingController();
  final phoneNumber = TextEditingController();

  // Address Controllers
  final region = TextEditingController();
  final zone = TextEditingController();
  final city = TextEditingController();
  final kebeleNo = TextEditingController();

  // Reactive variables
  var selectedGender = Rx<String?>(null);
  var agreeToTerms = false.obs;
  var isLoading = false.obs;

  @override
  void onClose() {
    firstName.dispose();
    middleName.dispose();
    lastName.dispose();
    dateOfBirth.dispose();
    phoneNumber.dispose();
    region.dispose();
    zone.dispose();
    city.dispose();
    kebeleNo.dispose();
    super.onClose();
  }

  // Date Picker
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      dateOfBirth.text = picked.toIso8601String().split('T').first;
    }
  }

  // Register Student
  Future<void> registerStudent() async {
    if (!formKey.currentState!.validate()) return;
    if (!agreeToTerms.value) {
      Get.snackbar(
        backgroundColor: TemarLijeColors.warning,
        colorText: TemarLijeColors.white,
        'Error',
        'Please agree to terms and conditions',
      );
      return;
    }
    if (selectedGender.value == null) {
      Get.snackbar(
        backgroundColor: TemarLijeColors.warning,
        colorText: TemarLijeColors.white,
        'Error',
        'Please select gender',
      );
      return;
    }

    isLoading.value = true;

    try {
      // Create AddressInfo
      final addressInfo = AddressInfo(
        region: region.text,
        zone: zone.text,
        city: city.text,
        kebeleNo: kebeleNo.text,
      );

      // Create Student
      final student = Students.create(
        firstName: firstName.text,
        middleName: middleName.text,
        lastName: lastName.text,
        dateOfBirth: DateTime.parse(dateOfBirth.text),
        phoneNumber: phoneNumber.text,
        gender: selectedGender.value!,
        addressInfo: addressInfo,
      );

      // Send to server (includes both student data and auth credentials)
      final response = await _studentService.registerStudent(student: student);

      if (response.isEmpty) {
        Get.snackbar(
          'Success',
          'Student registered successfully!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        debugPrint(response.toString());
        // Clear form
        _clearForm();
      } else {
        Get.snackbar('Error', response['message'] ?? 'Registration failed');
        debugPrint(response.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void _clearForm() {
    firstName.clear();
    middleName.clear();
    lastName.clear();
    dateOfBirth.clear();
    phoneNumber.clear();
    region.clear();
    zone.clear();
    city.clear();
    kebeleNo.clear();
    selectedGender.value = null;
    agreeToTerms.value = false;
  }
}
