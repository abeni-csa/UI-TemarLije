// lib/features/administrator/academic_year/screens/widgets/academic_year_form.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ui_temarlije/data/models/academic_year.dart';
import 'package:ui_temarlije/features/administrator/academic_year/academic_year_controller.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';

class AcademicYearFormDialog extends StatelessWidget {
  final AcademicYear? academicYear;
  final Function(CreateAcademicYearRequest)? onSubmit;
  final Function(String, UpdateAcademicYearRequest)? onSubmitUpdate;

  const AcademicYearFormDialog({
    super.key,
    this.academicYear,
    this.onSubmit,
    this.onSubmitUpdate,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AcademicYearController>();

    if (academicYear != null) {
      controller.setEditingAcademicYear(academicYear);
    } else {
      controller.setEditingAcademicYear(null);
    }

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: TemarLijeColors.cardBackgroundColor,
      child: Container(
        padding: const EdgeInsets.all(24),
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 650),
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
                        academicYear == null
                            ? Icons.calendar_month_sharp
                            : Icons.edit_calendar,
                        color: TemarLijeColors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        controller.editingAcademicYear == null
                            ? 'Create New Academic Year'
                            : 'Edit Academic Year',
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

                // Year Range
                TextFormField(
                  controller: controller.yearRangeController,
                  decoration: InputDecoration(
                    labelText: 'Year Range',
                    hintText: 'e.g., 2024-2025',
                    prefixIcon: const Icon(Icons.date_range),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter year range';
                    }
                    final pattern = RegExp(r'^\d{4}-\d{4}$');
                    if (!pattern.hasMatch(value)) {
                      return 'Please enter valid year range (e.g., 2024-2025)';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Start Date
                TextFormField(
                  controller: controller.startDateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Start Date',
                    hintText: 'Select start date',
                    prefixIcon: const Icon(Icons.calendar_today),
                    suffixIcon: const Icon(Icons.arrow_drop_down),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (date != null) {
                      controller.startDateController.text = DateFormat(
                        'yyyy-MM-dd',
                      ).format(date);
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select start date';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // End Date
                TextFormField(
                  controller: controller.endDateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'End Date',
                    hintText: 'Select end date',
                    prefixIcon: const Icon(Icons.calendar_today),
                    suffixIcon: const Icon(Icons.arrow_drop_down),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (date != null) {
                      controller.endDateController.text = DateFormat(
                        'yyyy-MM-dd',
                      ).format(date);
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select end date';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Is Current
                Obx(
                  () => SwitchListTile(
                    title: const Text('Set as Current Academic Year'),
                    subtitle: Text(
                      controller.isCurrentController.value
                          ? 'This will be the active academic year'
                          : 'Mark this as the current academic year',
                    ),
                    value: controller.isCurrentController.value,
                    onChanged: (value) {
                      controller.isCurrentController.value = value;
                    },
                    activeColor: TemarLijeColors.primary,
                    contentPadding: EdgeInsets.zero,
                  ),
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
                                  controller.editingAcademicYear == null
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

  void _submitForm(AcademicYearController controller, BuildContext context) {
    if (controller.validateForm()) {
      if (controller.editingAcademicYear != null && onSubmitUpdate != null) {
        final request = controller.getUpdateRequest();
        onSubmitUpdate!(controller.editingAcademicYear!.id, request);
      } else if (onSubmit != null) {
        final request = controller.getCreateRequest();
        onSubmit!(request);
      }
      Navigator.pop(context);
    }
  }
}
