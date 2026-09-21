import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ui_temarlije/data/models/section.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';

class SectionInfoCard extends StatelessWidget {
  const SectionInfoCard({super.key, required this.section});

  final Section section;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM dd, yyyy');
    final enrollmentPercentage = section.capacity > 0
        ? (section.currentEnrollment / section.capacity * 100)
        : 0.0;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            TemarLijeColors.primary.withAlpha(10),
            TemarLijeColors.primary.withAlpha(5),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: TemarLijeColors.primary.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: TemarLijeColors.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.class_, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      section.sectionName,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        section.sectionCode,
                        style: TextStyle(
                          color: Colors.blue.shade800,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Status Badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: enrollmentPercentage >= 100
                      ? Colors.red.shade50
                      : enrollmentPercentage >= 80
                      ? Colors.orange.shade50
                      : Colors.green.shade50,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: enrollmentPercentage >= 100
                        ? Colors.red.shade200
                        : enrollmentPercentage >= 80
                        ? Colors.orange.shade200
                        : Colors.green.shade200,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      enrollmentPercentage >= 100
                          ? Icons.error
                          : enrollmentPercentage >= 80
                          ? Icons.warning
                          : Icons.check_circle,
                      size: 14,
                      color: enrollmentPercentage >= 100
                          ? Colors.red.shade700
                          : enrollmentPercentage >= 80
                          ? Colors.orange.shade700
                          : Colors.green.shade700,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      enrollmentPercentage >= 100
                          ? 'Full'
                          : enrollmentPercentage >= 80
                          ? 'Almost Full'
                          : 'Available',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: enrollmentPercentage >= 100
                            ? Colors.red.shade700
                            : enrollmentPercentage >= 80
                            ? Colors.orange.shade700
                            : Colors.green.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Stats Row
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  icon: Icons.people,
                  label: 'Enrolled',
                  value: '${section.currentEnrollment}',
                  color: Colors.blue,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatItem(
                  icon: Icons.event_seat,
                  label: 'Capacity',
                  value: '${section.capacity}',
                  color: Colors.purple,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatItem(
                  icon: Icons.person_add,
                  label: 'Available',
                  value: '${section.capacity - section.currentEnrollment}',
                  color: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Progress Bar
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Enrollment Progress',
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                  Text(
                    '${enrollmentPercentage.toStringAsFixed(1)}%',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: enrollmentPercentage >= 100
                          ? Colors.red
                          : enrollmentPercentage >= 80
                          ? Colors.orange
                          : Colors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: (enrollmentPercentage / 100).clamp(0.0, 1.0),
                  minHeight: 10,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    enrollmentPercentage >= 100
                        ? Colors.red
                        : enrollmentPercentage >= 80
                        ? Colors.orange
                        : Colors.green,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Additional Info
          Row(
            children: [
              _buildInfoChip(
                icon: Icons.calendar_today,
                text: 'Created: ${dateFormat.format(section.createdAt)}',
              ),
              const SizedBox(width: 16),
              _buildInfoChip(
                icon: Icons.update,
                text: 'Updated: ${dateFormat.format(section.updatedAt)}',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withAlpha(15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withAlpha(40)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip({required IconData icon, required String text}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: Colors.grey.shade500),
        const SizedBox(width: 4),
        Text(text, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
      ],
    );
  }
}
