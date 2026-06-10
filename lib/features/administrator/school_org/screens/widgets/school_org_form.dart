import 'package:flutter/material.dart';
import 'package:ui_temarlije/data/models/fileds.dart';
import 'package:ui_temarlije/data/models/school_organzation.dart';
import 'package:ui_temarlije/features/administrator/school_org/model/school.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';

class SchoolOrgFormDialog extends StatefulWidget {
  final SchoolOrganzationModel? schoolOrganization;
  final Function(CreateSchoolOrganzationRequest)? onSubmit;
  final Function(String, UpdateSchoolOrganzationRequest)? onSubmitUpdate;

  const SchoolOrgFormDialog({
    super.key,
    this.schoolOrganization,
    this.onSubmit,
    this.onSubmitUpdate,
  });

  @override
  State<SchoolOrgFormDialog> createState() => _SchoolOrgFormDialogState();
}

class _SchoolOrgFormDialogState extends State<SchoolOrgFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _establishedYearController;
  late final TextEditingController _regionController;
  late final TextEditingController _zoneController;
  late final TextEditingController _cityController;
  late final TextEditingController _kebeleController;

  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;
  late final TextEditingController _websiteController;

  late SchoolType _selectedSchoolType;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.schoolOrganization?.name ?? '',
    );
    _establishedYearController = TextEditingController(
      text: widget.schoolOrganization?.establishedYear.toString() ?? '',
    );
    _regionController = TextEditingController(
      text: widget.schoolOrganization?.address.region ?? '',
    );
    _zoneController = TextEditingController(
      text: widget.schoolOrganization?.address.zone ?? '',
    );
    _cityController = TextEditingController(
      text: widget.schoolOrganization?.address.city ?? '',
    );
    _kebeleController = TextEditingController(
      text: widget.schoolOrganization?.address.kebeleNo ?? '',
    );

    _phoneController = TextEditingController(
      text: widget.schoolOrganization?.contact.phone ?? '',
    );
    _websiteController = TextEditingController(
      text: widget.schoolOrganization?.contact.website ?? '',
    );

    _emailController = TextEditingController(
      text: widget.schoolOrganization?.contact.email ?? '',
    );
    _selectedSchoolType =
        widget.schoolOrganization?.schoolType ?? SchoolType.Public;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _establishedYearController.dispose();
    _regionController.dispose();
    _zoneController.dispose();
    _cityController.dispose();
    _kebeleController.dispose();

    _phoneController.dispose();
    _emailController.dispose();
    _websiteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: TemarLijeColors.cardBackgroundColor,
      child: Container(
        padding: const EdgeInsets.all(24),
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 700),
        child: Form(
          key: _formKey,
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
                        widget.schoolOrganization == null
                            ? Icons.add_business
                            : Icons.edit_attributes,
                        color: TemarLijeColors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        widget.schoolOrganization == null
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
                  controller: _nameController,
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
                  controller: _establishedYearController,
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
                DropdownButtonFormField<SchoolType>(
                  initialValue: _selectedSchoolType,
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
                      setState(() => _selectedSchoolType = value);
                    }
                  },
                ),
                const SizedBox(height: 16),

                // Address Section
                const Text(
                  'Address Information',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _regionController,
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
                        controller: _cityController,
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
                        controller: _zoneController,
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
                        controller: _cityController,
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
                        controller: _kebeleController,
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
                  controller: _phoneController,
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
                  controller: _websiteController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Website',
                    hintText: 'Enter website address',
                    prefixIcon: const Icon(Icons.phone),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _emailController,
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
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: TemarLijeColors.accent,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          widget.schoolOrganization == null
                              ? 'Create'
                              : 'Update',
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

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final address = AddressInfo(
        region: _regionController.text,
        zone: _zoneController.text,
        city: _cityController.text,
        kebeleNo: _kebeleController.text,
      );

      final location = Location(
        region: _regionController.text,
        zone: _zoneController.text,
        city: _cityController.text,
        kebeleNo: _kebeleController.text,
      );
      final contact = Contact(
        phone: _phoneController.text,
        email: _emailController.text,
        website: _websiteController.text,
      );

      if (widget.schoolOrganization != null && widget.onSubmitUpdate != null) {
        // Update existing school
        final request = UpdateSchoolOrganzationRequest(
          schoolName: _nameController.text,
          address: address,
          location: location,
          contact: contact,
          establishedYear: int.parse(_establishedYearController.text),
          schoolType: _selectedSchoolType.toString().split('.').last,
        );
        widget.onSubmitUpdate!(
          widget.schoolOrganization!.id.toString(),
          request,
        );
      } else if (widget.onSubmit != null) {
        // Create new school
        final request = CreateSchoolOrganzationRequest(
          schoolName: _nameController.text,
          address: address,
          location: location,
          contact: contact,
          establishedYear: int.parse(_establishedYearController.text),
          schoolType: _selectedSchoolType.toString().split('.').last,
        );
        widget.onSubmit!(request);
      }

      Navigator.pop(context);
    }
  }
}
