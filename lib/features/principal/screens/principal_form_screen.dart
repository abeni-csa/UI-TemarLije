import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:ui_temarlije/data/models/principal_user.dart';
import 'package:ui_temarlije/features/users/controllers/principal_controller.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class PrincipalFormScreen extends StatefulWidget {
  final PrincipalUser? principal;
  const PrincipalFormScreen({super.key, this.principal});

  @override
  State<PrincipalFormScreen> createState() => _PrincipalFormScreenState();
}

class _PrincipalFormScreenState extends State<PrincipalFormScreen> {
  final controller = Get.find<PrincipalController>();
  final _formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;

  // Form controllers
  final _firstNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _authUserIdController = TextEditingController();
  final _departmentController = TextEditingController();
  final _positionController = TextEditingController();
  final _employmentTypeController = TextEditingController();

  // Address controllers
  final _regionController = TextEditingController();
  final _zoneController = TextEditingController();
  final _cityController = TextEditingController();
  final _kebeleController = TextEditingController();

  // Date pickers
  DateTime? _selectedDateOfBirth;
  DateTime? _selectedHireDate;

  // Checkboxes
  var _canManageUsers = false.obs;
  var _canManageFinances = false.obs;
  var _canManageAcademics = false.obs;

  final _isEditMode = false.obs;

  @override
  void initState() {
    super.initState();
    if (widget.principal != null) {
      _isEditMode.value = true;
      _loadPrincipalData();
    }
  }

  void _loadPrincipalData() {
    final p = widget.principal!;
    _firstNameController.text = p.firstName;
    _middleNameController.text = p.middleName ?? '';
    _lastNameController.text = p.lastName;
    _authUserIdController.text = p.authUserId;
    _departmentController.text = p.department;
    _positionController.text = p.position;
    _employmentTypeController.text = p.employmentType;
    _selectedDateOfBirth = DateTime.parse(p.dateOfBirth);
    _selectedHireDate = DateTime.parse(p.hireDate);
    _canManageUsers.value = p.canManageUsers;
    _canManageFinances.value = p.canManageFinances;
    _canManageAcademics.value = p.canManageAcademics;

    // Address
    _regionController.text = p.addressInfo.region;
    _zoneController.text = p.addressInfo.zone;
    _cityController.text = p.addressInfo.city;
    _kebeleController.text = p.addressInfo.kebeleNo;
  }

  Future<void> _selectDateOfBirth(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate:
          _selectedDateOfBirth ??
          DateTime.now().subtract(const Duration(days: 365 * 30)),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedDateOfBirth = picked;
      });
    }
  }

  Future<void> _selectHireDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedHireDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedHireDate = picked;
      });
    }
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedDateOfBirth == null) {
      Get.snackbar('Error', 'Please select date of birth');
      return;
    }
    if (_selectedHireDate == null) {
      Get.snackbar('Error', 'Please select hire date');
      return;
    }

    final addressInfo = AddressInfoRequest(
      region: _regionController.text.trim(),
      zone: _zoneController.text.trim(),
      city: _cityController.text.trim(),
      kebeleNo: _kebeleController.text.trim(),
    );

    try {
      _isLoading.value = true;

      if (_isEditMode.value) {
        final request = UpdatePrincipalRequest(
          firstName: _firstNameController.text.trim(),
          middleName: _middleNameController.text.trim().isEmpty
              ? null
              : _middleNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
          dateOfBirth: DateFormat('yyyy-MM-dd').format(_selectedDateOfBirth!),
          department: _departmentController.text.trim(),
          position: _positionController.text.trim(),
          addressInfo: addressInfo,
          employmentType: _employmentTypeController.text.trim(),
          hireDate: DateFormat('yyyy-MM-dd').format(_selectedHireDate!),
          canManageUsers: _canManageUsers.value,
          canManageFinances: _canManageFinances.value,
          canManageAcademics: _canManageAcademics.value,
        );
      } else {
        final request = CreatePrincipalRequest(
          authUserId: _authUserIdController.text.trim(),
          firstName: _firstNameController.text.trim(),
          middleName: _middleNameController.text.trim().isEmpty
              ? null
              : _middleNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
          dateOfBirth: DateFormat('yyyy-MM-dd').format(_selectedDateOfBirth!),
          department: _departmentController.text.trim(),
          position: _positionController.text.trim(),
          addressInfo: addressInfo,
          employmentType: _employmentTypeController.text.trim(),
          hireDate: DateFormat('yyyy-MM-dd').format(_selectedHireDate!),
          canManageUsers: _canManageUsers.value,
          canManageFinances: _canManageFinances.value,
          canManageAcademics: _canManageAcademics.value,
        );
        await controller.createNewPrincipal(request);
      }
    } finally {
      _isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditMode.value ? 'Edit Principal' : 'Add Principal'),
        centerTitle: true,
      ),
      body: Obx(
        () => Stack(
          children: [
            Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(TemarLijeSizes.defaultSpace),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Personal Information Section
                    _buildSectionTitle('Personal Information', Iconsax.user),
                    const SizedBox(height: TemarLijeSizes.spaceBtwItems),
                    TextFormField(
                      controller: _firstNameController,
                      decoration: const InputDecoration(
                        labelText: 'First Name *',
                        prefixIcon: Icon(Iconsax.user),
                      ),
                      validator: (v) => v?.isEmpty == true ? 'Required' : null,
                    ),
                    const SizedBox(height: TemarLijeSizes.spaceBtwInputFields),
                    TextFormField(
                      controller: _middleNameController,
                      decoration: const InputDecoration(
                        labelText: 'Middle Name',
                        prefixIcon: Icon(Iconsax.user),
                      ),
                    ),
                    const SizedBox(height: TemarLijeSizes.spaceBtwInputFields),
                    TextFormField(
                      controller: _lastNameController,
                      decoration: const InputDecoration(
                        labelText: 'Last Name *',
                        prefixIcon: Icon(Iconsax.user),
                      ),
                      validator: (v) => v?.isEmpty == true ? 'Required' : null,
                    ),
                    const SizedBox(height: TemarLijeSizes.spaceBtwInputFields),

                    // Employment Information Section
                    _buildSectionTitle(
                      'Employment Information',
                      Iconsax.briefcase,
                    ),
                    const SizedBox(height: TemarLijeSizes.spaceBtwItems),
                    TextFormField(
                      controller: _departmentController,
                      decoration: const InputDecoration(
                        labelText: 'Department ID *',
                        prefixIcon: Icon(Iconsax.building),
                      ),
                      validator: (v) => v?.isEmpty == true ? 'Required' : null,
                    ),
                    const SizedBox(height: TemarLijeSizes.spaceBtwInputFields),
                    TextFormField(
                      controller: _positionController,
                      decoration: const InputDecoration(
                        labelText: 'Position ID *',
                        prefixIcon: Icon(Iconsax.briefcase),
                      ),
                      validator: (v) => v?.isEmpty == true ? 'Required' : null,
                    ),
                    const SizedBox(height: TemarLijeSizes.spaceBtwInputFields),
                    TextFormField(
                      controller: _employmentTypeController,
                      decoration: const InputDecoration(
                        labelText: 'Employment Type *',
                        prefixIcon: Icon(Iconsax.clock),
                      ),
                      validator: (v) => v?.isEmpty == true ? 'Required' : null,
                    ),
                    const SizedBox(height: TemarLijeSizes.spaceBtwInputFields),

                    // Date Pickers
                    InkWell(
                      onTap: () => _selectDateOfBirth(context),
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Date of Birth *',
                          prefixIcon: Icon(Iconsax.calendar),
                        ),
                        child: Text(
                          _selectedDateOfBirth != null
                              ? DateFormat(
                                  'yyyy-MM-dd',
                                ).format(_selectedDateOfBirth!)
                              : 'Select date',
                        ),
                      ),
                    ),
                    const SizedBox(height: TemarLijeSizes.spaceBtwInputFields),
                    InkWell(
                      onTap: () => _selectHireDate(context),
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Hire Date *',
                          prefixIcon: Icon(Iconsax.calendar),
                        ),
                        child: Text(
                          _selectedHireDate != null
                              ? DateFormat(
                                  'yyyy-MM-dd',
                                ).format(_selectedHireDate!)
                              : 'Select date',
                        ),
                      ),
                    ),

                    const SizedBox(height: TemarLijeSizes.spaceBtwSections),

                    // Address Information Section
                    _buildSectionTitle('Address Information', Iconsax.location),
                    const SizedBox(height: TemarLijeSizes.spaceBtwItems),
                    TextFormField(
                      controller: _regionController,
                      decoration: const InputDecoration(
                        labelText: 'Region *',
                        prefixIcon: Icon(Iconsax.location),
                      ),
                      validator: (v) => v?.isEmpty == true ? 'Required' : null,
                    ),
                    const SizedBox(height: TemarLijeSizes.spaceBtwInputFields),
                    TextFormField(
                      controller: _zoneController,
                      decoration: const InputDecoration(
                        labelText: 'Zone *',
                        prefixIcon: Icon(Iconsax.location),
                      ),
                      validator: (v) => v?.isEmpty == true ? 'Required' : null,
                    ),
                    const SizedBox(height: TemarLijeSizes.spaceBtwInputFields),
                    TextFormField(
                      controller: _cityController,
                      decoration: const InputDecoration(
                        labelText: 'City *',
                        prefixIcon: Icon(Iconsax.building),
                      ),
                      validator: (v) => v?.isEmpty == true ? 'Required' : null,
                    ),
                    const SizedBox(height: TemarLijeSizes.spaceBtwInputFields),
                    TextFormField(
                      controller: _kebeleController,
                      decoration: const InputDecoration(
                        labelText: 'Kebele No *',
                        prefixIcon: Icon(Iconsax.hashtag),
                      ),
                      validator: (v) => v?.isEmpty == true ? 'Required' : null,
                    ),

                    const SizedBox(height: TemarLijeSizes.spaceBtwSections),

                    // Permissions Section
                    _buildSectionTitle('Permissions', Iconsax.shield),
                    const SizedBox(height: TemarLijeSizes.spaceBtwItems),
                    Obx(
                      () => CheckboxListTile(
                        title: const Text('Can Manage Users'),
                        value: _canManageUsers.value,
                        onChanged: (v) => _canManageUsers.value = v ?? false,
                        activeColor: TemarLijeColors.primary,
                      ),
                    ),
                    Obx(
                      () => CheckboxListTile(
                        title: const Text('Can Manage Finances'),
                        value: _canManageFinances.value,
                        onChanged: (v) => _canManageFinances.value = v ?? false,
                        activeColor: TemarLijeColors.primary,
                      ),
                    ),
                    Obx(
                      () => CheckboxListTile(
                        title: const Text('Can Manage Academics'),
                        value: _canManageAcademics.value,
                        onChanged: (v) =>
                            _canManageAcademics.value = v ?? false,
                        activeColor: TemarLijeColors.primary,
                      ),
                    ),

                    const SizedBox(height: TemarLijeSizes.spaceBtwSections * 2),

                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        child: Text(_isEditMode.value ? 'Update' : 'Create'),
                      ),
                    ),
                    const SizedBox(height: TemarLijeSizes.spaceBtwSections),
                  ],
                ),
              ),
            ),
            if (_isLoading.value)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 20, color: TemarLijeColors.primary),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
