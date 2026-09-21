import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/data/models/membeship.dart';
import 'package:ui_temarlije/data/models/school_organzation.dart';
import 'package:ui_temarlije/features/membership/membership_controllers.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';
import 'package:ui_temarlije/routes/routes.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class SchoolMembershipCard extends StatelessWidget {
  final SchoolOrganzationModel schoolOrganzation;

  const SchoolMembershipCard({super.key, required this.schoolOrganzation});

  @override
  Widget build(BuildContext context) {
    final membershipController = Get.find<MembershipControllers>();

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      elevation: 2,
      color: Colors.white,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => Get.toNamed(
          TemarLijeRoutes.lessonPlanDetail,
          arguments: schoolOrganzation,
        ),
        borderRadius: BorderRadius.circular(TemarLijeSizes.borderRadiusMd),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: TemarLijeColors.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.menu_book,
                  color: TemarLijeColors.primary,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      schoolOrganzation.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      schoolOrganzation.tenantCode,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.school,
                          size: 14,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          schoolOrganzation.schoolType
                              .toString()
                              .split('.')
                              .last,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Icon(
                          Icons.calendar_today,
                          size: 14,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          schoolOrganzation.establishedYear.toString(),
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () =>
                        _showJoinDialog(context, membershipController),
                    child: const Text('Join'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showJoinDialog(BuildContext context, MembershipControllers controller) {
    UserType? selectedRole = UserType.Student;
    String? selectedGradeLevel;
    String? selectedPosition;
    double? testScore;
    bool isJoining = false;

    showDialog(
      context: context,
      barrierDismissible: !isJoining,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Join School'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Do you want to join ${schoolOrganzation.name}?'),
                const SizedBox(height: 16),

                // Role Selection
                DropdownButtonFormField<UserType>(
                  decoration: const InputDecoration(
                    labelText: 'Join as',
                    border: OutlineInputBorder(),
                  ),
                  initialValue: selectedRole,
                  items: UserType.values.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(type.toString().split('.').last),
                    );
                  }).toList(),
                  onChanged: isJoining
                      ? null
                      : (value) {
                          setState(() {
                            selectedRole = value;
                            selectedGradeLevel = null;
                            selectedPosition = null;
                            testScore = null;
                          });
                        },
                ),

                const SizedBox(height: 16),

                // Student-specific fields
                if (selectedRole == UserType.Student) ...[
                  const Text(
                    'Student Information',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Grade Level',
                      border: OutlineInputBorder(),
                    ),
                    initialValue: selectedGradeLevel,
                    items: const [
                      DropdownMenuItem(
                        value: 'Kindergarten',
                        child: Text('Kindergarten'),
                      ),
                      DropdownMenuItem(
                        value: 'Primary',
                        child: Text('Primary'),
                      ),
                      DropdownMenuItem(
                        value: 'Middle School',
                        child: Text('Middle School'),
                      ),
                      DropdownMenuItem(
                        value: 'High School',
                        child: Text('High School'),
                      ),
                      DropdownMenuItem(
                        value: 'Preparatory',
                        child: Text('Preparatory'),
                      ),
                    ],
                    onChanged: isJoining
                        ? null
                        : (value) {
                            setState(() {
                              selectedGradeLevel = value;
                            });
                          },
                    validator: (value) {
                      if (selectedRole == UserType.Student && value == null) {
                        return 'Please select grade level';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Test Score (Optional)',
                      hintText: 'Enter your entrance exam score',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    enabled: !isJoining,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        testScore = double.tryParse(value);
                      } else {
                        testScore = null;
                      }
                    },
                  ),
                ],

                // Teacher-specific fields
                if (selectedRole == UserType.Teacher) ...[
                  const Text(
                    'Teacher Information',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Position/Subject',
                      border: OutlineInputBorder(),
                    ),
                    initialValue: selectedPosition,
                    items: const [
                      DropdownMenuItem(
                        value: 'Mathematics',
                        child: Text('Mathematics'),
                      ),
                      DropdownMenuItem(
                        value: 'Science',
                        child: Text('Science'),
                      ),
                      DropdownMenuItem(
                        value: 'English',
                        child: Text('English'),
                      ),
                      DropdownMenuItem(
                        value: 'History',
                        child: Text('History'),
                      ),
                      DropdownMenuItem(
                        value: 'Physics',
                        child: Text('Physics'),
                      ),
                      DropdownMenuItem(
                        value: 'Chemistry',
                        child: Text('Chemistry'),
                      ),
                      DropdownMenuItem(
                        value: 'Biology',
                        child: Text('Biology'),
                      ),
                      DropdownMenuItem(
                        value: 'Computer Science',
                        child: Text('Computer Science'),
                      ),
                    ],
                    onChanged: isJoining
                        ? null
                        : (value) {
                            setState(() {
                              selectedPosition = value;
                            });
                          },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Years of Experience',
                      hintText: 'Enter years of teaching experience',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    enabled: !isJoining,
                    onChanged: (value) {},
                  ),
                ],

                // Staff-specific fields
                if (selectedRole == UserType.FinanceAccountant) ...[
                  const Text(
                    'Staff Information',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Department/Role',
                      border: OutlineInputBorder(),
                    ),
                    initialValue: selectedPosition,
                    items: const [
                      DropdownMenuItem(
                        value: 'Administration',
                        child: Text('Administration'),
                      ),
                      DropdownMenuItem(
                        value: 'Finance',
                        child: Text('Finance'),
                      ),
                      DropdownMenuItem(
                        value: 'HR',
                        child: Text('Human Resources'),
                      ),
                      DropdownMenuItem(
                        value: 'IT',
                        child: Text('IT Department'),
                      ),
                      DropdownMenuItem(
                        value: 'Library',
                        child: Text('Library'),
                      ),
                      DropdownMenuItem(
                        value: 'Counseling',
                        child: Text('Counseling'),
                      ),
                    ],
                    onChanged: isJoining
                        ? null
                        : (value) {
                            setState(() {
                              selectedPosition = value;
                            });
                          },
                  ),
                ],

                if (isJoining)
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: isJoining ? null : () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: isJoining
                  ? null
                  : () async {
                      // Validate student fields
                      if (selectedRole == UserType.Student &&
                          selectedGradeLevel == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please select grade level'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      setState(() {
                        isJoining = true;
                      });

                      try {
                        // Prepare request data matching backend expectations
                        final requestData = {
                          'membership_type': selectedRole
                              .toString()
                              .split('.')
                              .last,
                        };

                        // Add role-specific fields
                        if (selectedRole == UserType.Student) {
                          requestData['requested_grade_level'] =
                              selectedGradeLevel!;
                          if (testScore != null) {
                            requestData['test_score'] = testScore as String;
                          }
                        } else if (selectedRole == UserType.Teacher) {
                          requestData['subject_specialization'] =
                              selectedPosition ?? 'General';
                          requestData['years_of_experience'] =
                              0 as String; // You can add this from the text field
                        } else if (selectedRole == UserType.Parent) {
                          requestData['department'] =
                              selectedPosition ?? 'General Staff';
                          requestData['role'] = selectedPosition ?? 'Staff';
                        }
                        if (context.mounted) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Join request sent successfully to ${schoolOrganzation.name}!',
                              ),
                              backgroundColor: Colors.green,
                              duration: const Duration(seconds: 3),
                            ),
                          );
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Failed to join: $e'),
                              backgroundColor: Colors.red,
                              duration: const Duration(seconds: 3),
                            ),
                          );
                        }
                      } finally {
                        if (context.mounted) {
                          setState(() {
                            isJoining = false;
                          });
                        }
                      }
                    },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text('Confirm Join'),
            ),
          ],
        ),
      ),
    );
  }
}
