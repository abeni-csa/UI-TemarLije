import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/utils/constants/enums.dart';
import 'package:uuid/uuid.dart';
import 'package:ui_temarlije/data/models/subject.dart';
import 'package:ui_temarlije/features/administrator/subject/subject_controller.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';
import 'package:ui_temarlije/utils/validators/validation.dart';

class SubjectFormDialog extends StatelessWidget {
  final Subject? subject;
  final Function(CreateSubjectRequest)? onSubmit;
  final Function(UuidValue, UpdateSubjectRequest)? onSubmitUpdate;

  const SubjectFormDialog({
    super.key,
    this.subject,
    this.onSubmit,
    this.onSubmitUpdate,
  });

  @override
  Widget build(BuildContext context) {
    final SubjectController controller = Get.find<SubjectController>();

    if (subject != null) {
      controller.setEditingSubject(subject);
    } else {
      controller.setEditingSubject(null);
    }

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: TemarLijeColors.cardBackgroundColor,
      child: Container(
        padding: const EdgeInsets.all(24),
        constraints: const BoxConstraints(maxWidth: 700, maxHeight: 750),
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
                        controller.editingSubject == null
                            ? Icons.add_circle_outline
                            : Icons.edit_note,
                        color: TemarLijeColors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        controller.editingSubject == null
                            ? 'Create New Subject'
                            : 'Edit Subject',
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

                // Basic Information
                const Text(
                  'Basic Information',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: controller.nameController,
                  decoration: InputDecoration(
                    labelText: 'Subject Name',
                    hintText: 'Enter subject name',
                    prefixIcon: const Icon(Icons.book),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) => TemarLijeValidator.validateEmptyText(
                    value,
                    "Please enter subject name",
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: controller.descriptionController,
                  maxLines: 2,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    hintText: 'Enter subject description (optional)',
                    prefixIcon: const Icon(Icons.description),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Core & Field Based
                Row(
                  children: [
                    Obx(
                      () => Checkbox(
                        value: controller.isCore.value,
                        onChanged: (value) =>
                            controller.isCore.value = value ?? false,
                      ),
                    ),
                    const Text('Core Subject'),
                    const SizedBox(width: 24),
                    Obx(
                      () => Checkbox(
                        value: controller.isFieldBased.value,
                        onChanged: (value) =>
                            controller.isFieldBased.value = value ?? false,
                      ),
                    ),
                    const Text('Field Based'),
                  ],
                ),
                const SizedBox(height: 12),

                // Weekly Periods
                TextFormField(
                  controller: controller.weeklyPeriodsController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Weekly Periods',
                    hintText: 'Enter number of weekly periods',
                    prefixIcon: const Icon(Icons.timer),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter weekly periods';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                // Room Type
                Obx(
                  () => DropdownButtonFormField<RoomType>(
                    initialValue: controller.selectedRoomType.value,
                    decoration: InputDecoration(
                      labelText: 'Room Type',
                      prefixIcon: const Icon(Icons.meeting_room),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    items: RoomType.values.map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(type.toString().split('.').last),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        controller.selectedRoomType.value = value;
                      }
                    },
                  ),
                ),
                const SizedBox(height: 12),

                // Requires Special Room
                Obx(
                  () => CheckboxListTile(
                    value: controller.requiresSpecialRoom.value,
                    onChanged: (value) =>
                        controller.requiresSpecialRoom.value = value ?? false,
                    title: const Text('Requires Special Room'),
                    controlAffinity: ListTileControlAffinity.leading,
                    dense: true,
                  ),
                ),
                const SizedBox(height: 16),

                // Education Levels
                const Text(
                  'Education Levels',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Obx(
                  () => Wrap(
                    spacing: 8,
                    children: EducationLevel.values.map((level) {
                      final isSelected = controller.selectedEducationLevels
                          .contains(level);
                      return FilterChip(
                        label: Text(level.toString().split('.').last),
                        selected: isSelected,
                        onSelected: (selected) {
                          if (selected) {
                            controller.selectedEducationLevels.add(level);
                          } else {
                            controller.selectedEducationLevels.remove(level);
                          }
                        },
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 16),

                // Streams
                const Text(
                  'Subject Streams',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Obx(
                  () => Wrap(
                    spacing: 8,
                    children: SubjectTypeStream.values.map((stream) {
                      final isSelected = controller.selectedStreams.contains(
                        stream,
                      );
                      return FilterChip(
                        label: Text(stream.toString().split('.').last),
                        selected: isSelected,
                        onSelected: (selected) {
                          if (selected) {
                            controller.selectedStreams.add(stream);
                          } else {
                            controller.selectedStreams.remove(stream);
                          }
                        },
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 16),

                // Teacher Qualifications
                const Text(
                  'Teacher Qualifications',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.teacherQualificationController,
                        decoration: InputDecoration(
                          hintText: 'Enter qualification',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        // onSubmitted: (_) => controller.addQualification(),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.add_circle, color: Colors.blue),
                      onPressed: controller.addQualification,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Obx(
                  () => Wrap(
                    spacing: 8,
                    children: controller.teacherQualifications
                        .asMap()
                        .entries
                        .map((entry) {
                          final index = entry.key;
                          final qual = entry.value;
                          return Chip(
                            label: Text(qual),
                            onDeleted: () =>
                                controller.removeQualification(index),
                          );
                        })
                        .toList(),
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
                                  controller.editingSubject == null
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

  void _submitForm(SubjectController controller, BuildContext context) {
    if (controller.validateForm()) {
      if (controller.editingSubject != null && onSubmitUpdate != null) {
        final request = controller.getUpdateRequest();
        onSubmitUpdate!(controller.editingSubject!.id, request);
      } else if (onSubmit != null) {
        final request = controller.getCreateRequest();
        onSubmit!(request);
      }
      Navigator.pop(context);
    }
  }
}
