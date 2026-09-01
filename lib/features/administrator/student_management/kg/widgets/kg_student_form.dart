import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ui_temarlije/data/models/students.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';
import 'package:ui_temarlije/utils/constants/enums.dart';
import 'package:ui_temarlije/utils/validators/validation.dart';
import 'package:uuid/uuid.dart';
import 'package:ui_temarlije/features/administrator/student_management/kg/kg_students_controller.dart';

class KGStudentFormDialog extends StatelessWidget {
  final VoidCallback onSubmit;
  final RxBool isSubmitting;

  const KGStudentFormDialog({
    super.key,
    required this.onSubmit,
    required this.isSubmitting,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<KGStudentsController>();

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: TemarLijeColors.googleBackgroundColor,
      child: Container(
        padding: const EdgeInsets.all(24),
        constraints: const BoxConstraints(maxWidth: 700, maxHeight: 800),
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                _buildHeader(context),
                const SizedBox(height: 10),

                // Personal Information
                _buildSectionTitle('Personal Information'),
                const SizedBox(height: 12),
                _buildPersonalInfoFields(controller),

                const SizedBox(height: 16),

                // Address Information
                _buildSectionTitle('Address Information'),
                const SizedBox(height: 12),
                _buildAddressFields(controller),

                const SizedBox(height: 16),

                // Birth Certificate
                _buildSectionTitle('Birth Certificate'),
                const SizedBox(height: 12),
                _buildBirthCertificateFields(controller),

                const SizedBox(height: 16),

                // Guardian
                _buildSectionTitle('Guardian Information'),
                const SizedBox(height: 12),
                _buildGuardianField(controller),

                const SizedBox(height: 24),

                // Action buttons
                _buildActionButtons(controller, context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.person_add_alt_1,
            color: Colors.white,
            size: 24,
          ),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Text(
            'Register New KG Student',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
    );
  }

  Widget _buildPersonalInfoFields(KGStudentsController controller) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller.firstNameController,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    TemarLijeValidator.validateEmptyText('First Name', value),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextFormField(
                controller: controller.middleNameController,
                decoration: const InputDecoration(
                  labelText: 'Middle Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    TemarLijeValidator.validateEmptyText('Middle Name', value),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller.lastNameController,
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    TemarLijeValidator.validateEmptyText('Last Name', value),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextFormField(
                controller: controller.dateOfBirthController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Date of Birth',
                  suffixIcon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(),
                ),
                onTap: () async {
                  final date = await showDatePicker(
                    context: Get.context!,
                    initialDate: DateTime.now().subtract(
                      const Duration(days: 365 * 4),
                    ),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    controller.dateOfBirthController.text = DateFormat(
                      'yyyy-MM-dd',
                    ).format(date);
                  }
                },
                validator: (value) => TemarLijeValidator.validateEmptyText(
                  "Date of Birth",
                  value,
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
                controller: controller.phoneNumberController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    TemarLijeValidator.validatePhoneNumber(value),
              ),
            ),
            const SizedBox(width: 12),

            Expanded(
              child: Obx(
                () => DropdownButtonFormField2<String>(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      gapPadding: 0,
                    ),
                  ),
                  hint: const Text(
                    'Select Gender',
                    style: TextStyle(
                      fontSize: 14,
                      color: TemarLijeColors.textPrimary,
                    ),
                  ),
                  items: controller.genderItems
                      .map(
                        (item) => DropdownItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                      .toList(),
                  valueListenable: controller.valueListenableOnGender,
                  validator: (value) =>
                      TemarLijeValidator.validateEmptyText("Gender", value),
                  onChanged: (value) {
                    controller.valueListenableOnGender.value = value;
                  },
                  iconStyleData: const IconStyleData(
                    icon: Icon(Icons.arrow_drop_down, color: Colors.black45),
                  ),
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    useDecorationHorizontalPadding: true,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: controller.nationalIdController,
          decoration: const InputDecoration(
            labelText: 'National ID (Optional)',
            hintText: 'FIN or FAN',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  Widget _buildAddressFields(KGStudentsController controller) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField2<RegionalStatesAndCities>(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    gapPadding: 0,
                  ),
                ),
                hint: const Text(
                  'Select Region Or Citiy ',
                  style: TextStyle(
                    fontSize: 14,
                    overflow: TextOverflow.ellipsis,
                    color: TemarLijeColors.textPrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                items: RegionalStatesAndCities.values
                    .map(
                      (item) => DropdownItem<RegionalStatesAndCities>(
                        value: item,

                        child: Text(
                          item.name.toTitleCase(),

                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                    .toList(),
                valueListenable: controller.valueListenableOnRegionalStates,
                validator: (value) => TemarLijeValidator.validateEmptyText(
                  "Regional States ",
                  value.toString(),
                ),
                onChanged: (value) {
                  controller.valueListenableOnRegionalStates.value = value;
                },
                iconStyleData: const IconStyleData(
                  icon: Icon(Icons.arrow_drop_down, color: Colors.black45),
                ),
                dropdownStyleData: DropdownStyleData(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                menuItemStyleData: const MenuItemStyleData(
                  useDecorationHorizontalPadding: true,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextFormField(
                controller: controller.cityController,
                decoration: const InputDecoration(
                  labelText: 'City',
                  border: OutlineInputBorder(),
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
                controller: controller.zoneController,
                decoration: const InputDecoration(
                  labelText: 'Zone',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextFormField(
                controller: controller.woredaController,
                decoration: const InputDecoration(
                  labelText: 'Woreda',
                  border: OutlineInputBorder(),
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
                controller: controller.kebeleController,
                decoration: const InputDecoration(
                  labelText: 'Kebele',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextFormField(
                controller: controller.houseNumberController,
                decoration: const InputDecoration(
                  labelText: 'House Number',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBirthCertificateFields(KGStudentsController controller) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller.certificateNumberController,
                decoration: const InputDecoration(
                  labelText: 'Certificate Number',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 12),

            Expanded(
              child: DropdownButtonFormField2<IssuingAuthority>(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    gapPadding: 0,
                  ),
                ),
                hint: const Text(
                  'Select Issuing Authority',
                  style: TextStyle(
                    fontSize: 14,
                    color: TemarLijeColors.textPrimary,
                  ),
                ),
                items: IssuingAuthority.values
                    .map(
                      (item) => DropdownItem<IssuingAuthority>(
                        value: item,
                        child: Text(
                          item.name.toTitleCase(),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                    .toList(),

                valueListenable:
                    controller.valueListenableOnSelectedIssuingAuthority,
                validator: (value) => TemarLijeValidator.validateEmptyText(
                  "Issuing Authority",
                  value.toString(),
                ),
                onChanged: (value) {
                  controller.selectedIssuingAuthority.value = value;
                },
                iconStyleData: const IconStyleData(
                  icon: Icon(Icons.arrow_drop_down, color: Colors.black45),
                ),
                dropdownStyleData: DropdownStyleData(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                menuItemStyleData: const MenuItemStyleData(
                  useDecorationHorizontalPadding: true,
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
                controller: controller.issueDateController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Issue Date',
                  suffixIcon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(),
                ),
                onTap: () async {
                  final date = await showDatePicker(
                    context: Get.context!,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    controller.issueDateController.text = DateFormat(
                      'yyyy-MM-dd',
                    ).format(date);
                  }
                },
                validator: (value) =>
                    TemarLijeValidator.validateEmptyText("Issue Date", value),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                children: [
                  Obx(
                    () => CheckboxListTile(
                      title: const Text('Original Copy'),
                      value: controller.isOriginalCopy.value,
                      onChanged: (value) {
                        controller.isOriginalCopy.value = value ?? false;
                      },
                      contentPadding: EdgeInsets.zero,
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ),
                  Obx(
                    () => CheckboxListTile(
                      title: const Text('Photocopy Provided'),
                      value: controller.isPhotocopyProvided.value,
                      onChanged: (value) {
                        controller.isPhotocopyProvided.value = value ?? false;
                      },
                      contentPadding: EdgeInsets.zero,
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGuardianField(KGStudentsController controller) {
    return TextFormField(
      controller: controller.guardianIdController,
      decoration: const InputDecoration(
        labelText: 'Guardian ID (UUID)',
        hintText: 'Enter guardian UUID',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Guardian ID is required';
        }
        try {
          UuidValue.fromString(value);
        } catch (e) {
          return 'Invalid UUID format';
        }
        return null;
      },
    );
  }

  Widget _buildActionButtons(
    KGStudentsController controller,
    BuildContext context,
  ) {
    return Row(
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
              onPressed: isSubmitting.value ? null : onSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: isSubmitting.value
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text(
                      'Register Student',
                      style: TextStyle(color: Colors.white),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
