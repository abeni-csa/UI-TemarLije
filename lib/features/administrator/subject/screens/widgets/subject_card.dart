import 'package:flutter/material.dart';
import 'package:ui_temarlije/data/models/subject.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';

class SubjectCard extends StatelessWidget {
  final Subject subject;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const SubjectCard({
    super.key,
    required this.subject,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      elevation: 2,
      color: Colors.white,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon section
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: subject.isCore
                    ? TemarLijeColors.primary.withAlpha(100)
                    : TemarLijeColors.accent.withAlpha(50),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                subject.isFieldBased ? Icons.agriculture : Icons.book,
                color: subject.isCore
                    ? TemarLijeColors.facebookBackgroundColor
                    : TemarLijeColors.accent,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),

            // Content section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          subject.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (subject.isCore)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: TemarLijeColors.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Core',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Code: ${subject.code}',
                    style: const TextStyle(color: Colors.black54, fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.timer, size: 14, color: Colors.grey.shade600),
                      const SizedBox(width: 4),
                      Text(
                        '${subject.weeklyPeriods} periods/week',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Icon(Icons.school, size: 14, color: Colors.grey.shade600),
                      const SizedBox(width: 4),
                      Text(
                        subject.educationLevels
                            .map((e) => e.toString().split('.').last)
                            .join(', '),
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  if (subject.streams.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Wrap(
                      spacing: 4,
                      children: subject.streams.take(3).map((stream) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            stream.toString().split('.').last,
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 10,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),
            ),

            // Action buttons
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.edit_outlined,
                    color: TemarLijeColors.warning,
                    size: 20,
                  ),
                  onPressed: onEdit,
                  tooltip: 'Edit',
                ),
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
          ],
        ),
      ),
    );
  }
}
