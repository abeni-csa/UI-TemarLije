import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ui_temarlije/data/models/students.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';

class SectionStudentCard extends StatelessWidget {
  const SectionStudentCard({
    super.key,
    required this.student,
    required this.onRemove,
  });

  final Students student;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM dd, yyyy');
    final isMale = student.gender.toLowerCase() == 'male';

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      color: TemarLijeColors.cardBackgroundColor,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Avatar
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: isMale ? Colors.blue.shade100 : Colors.pink.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  student.initials,
                  style: TextStyle(
                    color: isMale ? Colors.blue.shade800 : Colors.pink.shade800,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Student Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    student.fullName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 12,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'DOB: ${dateFormat.format(student.dateOfBirth)}',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Icon(Icons.phone, size: 12, color: Colors.grey.shade600),
                      const SizedBox(width: 4),
                      Text(
                        student.phoneNumber,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: isMale
                              ? Colors.blue.shade50
                              : Colors.pink.shade50,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          student.gender,
                          style: TextStyle(
                            fontSize: 10,
                            color: isMale
                                ? Colors.blue.shade800
                                : Colors.pink.shade800,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (student.addressInfo.city.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 10,
                                color: Colors.grey.shade600,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                student.addressInfo.city,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),

            // Remove Button
            IconButton(
              icon: const Icon(
                Icons.person_remove_outlined,
                color: TemarLijeColors.error,
                size: 22,
              ),
              onPressed: onRemove,
              tooltip: 'Remove from section',
            ),
          ],
        ),
      ),
    );
  }
}
