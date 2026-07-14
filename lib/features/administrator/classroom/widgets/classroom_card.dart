import 'package:flutter/material.dart';
import 'package:ui_temarlije/data/models/classroom.dart';
import 'package:ui_temarlije/data/models/section.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';

class ClassroomCard extends StatelessWidget {
  final Classroom classroom;
  final List<Section>? sections;
  final VoidCallback onTap;
  final VoidCallback? onDelete;

  const ClassroomCard({
    super.key,
    required this.classroom,
    this.sections,
    required this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final color = classroom.color;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      elevation: 2,
      color: TemarLijeColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: color.withAlpha(10),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      _getIconForGrade(classroom.gradeLevel),
                      color: color,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          classroom.gradeDisplay,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.school_outlined,
                              size: 14,
                              color: Colors.grey.shade500,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              _getGradeLevelDisplay(classroom.gradeLevel),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade500,
                              ),
                            ),
                            if (sections != null) ...[
                              const SizedBox(width: 8),
                              Container(
                                width: 4,
                                height: 4,
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${sections!.length} Sections',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (onDelete != null)
                    IconButton(
                      icon: const Icon(
                        Icons.delete_outline,
                        color: TemarLijeColors.error,
                        size: 20,
                      ),
                      onPressed: onDelete,
                      tooltip: 'Delete',
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _buildInfoChip(
                    'Capacity: ${classroom.capacity}',
                    Icons.people_outline,
                    Colors.grey.shade600,
                  ),
                  const SizedBox(width: 8),
                  if (sections != null)
                    _buildInfoChip(
                      'Enrolled: ${sections!.fold(0, (sum, s) => sum + s.currentEnrollment)}',
                      Icons.person_add_outlined,
                      TemarLijeColors.primary,
                    ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: TemarLijeColors.primary.withAlpha(10),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'View',
                          style: TextStyle(
                            color: TemarLijeColors.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward,
                          color: TemarLijeColors.primary,
                          size: 14,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withAlpha(18),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconForGrade(GradeLevel level) {
    switch (level) {
      case GradeLevel.kindergarten:
        return Icons.child_care;
      case GradeLevel.primary:
        return Icons.school;
      case GradeLevel.secondary:
        return Icons.auto_stories;
      case GradeLevel.highSchool:
        return Icons.emoji_events;
      case GradeLevel.preparatory:
        return Icons.workspace_premium;
    }
  }

  String _getGradeLevelDisplay(GradeLevel level) {
    switch (level) {
      case GradeLevel.kindergarten:
        return 'Kindergarten';
      case GradeLevel.primary:
        return 'Primary';
      case GradeLevel.secondary:
        return 'Secondary';
      case GradeLevel.highSchool:
        return 'High School';
      case GradeLevel.preparatory:
        return 'Preparatory';
    }
  }
}
