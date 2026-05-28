import 'package:flutter/material.dart';
import 'package:ui_temarlije/data/models/students.dart';
import 'package:ui_temarlije/data/models/fileds.dart';

class StudentFormScreen extends StatefulWidget {
  const StudentFormScreen({super.key});

  @override
  State<StudentFormScreen> createState() => _StudentFormScreenState();
}

class _StudentFormScreenState extends State<StudentFormScreen> {
  final _formKey = GlobalKey<FormState>();

  // Form controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _addressController = TextEditingController();
  final _address2Controller = TextEditingController();
  final _cityController = TextEditingController();
  final _zipController = TextEditingController();

  // Dropdown value for State (using region as an example)
  String? _selectedState;
  final List<String> _states = [
    'Choose...',
    'California',
    'Texas',
    'New York',
    'Florida',
    'Illinois',
  ];

  bool _checkMeOut = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _addressController.dispose();
    _address2Controller.dispose();
    _cityController.dispose();
    _zipController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Create AddressInfo object
      final addressInfo = AddressInfo(
        region: _selectedState ?? '',
        zone: _address2Controller.text,
        city: _cityController.text,
        kebeleNo: _addressController.text,
      );

      // Create Students object
      // Note: The model doesn't have email/password fields, so these are separate
      final student = Students.create(
        firstName: '', // Add field for this
        middleName: '', // Add field for this
        lastName: '', // Add field for this
        dateOfBirth: DateTime.now(), // Add date picker for this
        phoneNumber: '', // Add field for this
        gender: '', // Add dropdown for this
        addressInfo: addressInfo,
      );

      print('Student created: ${student.toJson()}');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Form submitted successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Registration'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Row for Email and Password (like col-md-6)
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter email';
                          }
                          if (!value.contains('@')) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Address (full width)
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    labelText: 'Address',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.home),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Address 2 (full width)
                TextFormField(
                  controller: _address2Controller,
                  decoration: const InputDecoration(
                    labelText: 'Address 2',
                    hintText: 'Apartment, studio, or floor',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.apartment),
                  ),
                ),
                const SizedBox(height: 16),

                // Row for City, State, Zip (like col-md-6, col-md-4, col-md-2)
                Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: TextFormField(
                        controller: _cityController,
                        decoration: const InputDecoration(
                          labelText: 'City',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.location_city),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter city';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 4,
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'State',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.map),
                        ),
                        value: _selectedState,
                        items: _states.map((String state) {
                          return DropdownMenuItem<String>(
                            value: state,
                            child: Text(state),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedState = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value == 'Choose...') {
                            return 'Please select a state';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller: _zipController,
                        decoration: const InputDecoration(
                          labelText: 'Zip',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.local_post_office),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter zip code';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Checkbox (Check me out)
                CheckboxListTile(
                  title: const Text('Check me out'),
                  value: _checkMeOut,
                  onChanged: (value) {
                    setState(() {
                      _checkMeOut = value ?? false;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                ),
                const SizedBox(height: 16),

                // Submit Button (Sign in)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text(
                      'Sign in',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
