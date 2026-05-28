import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/data/models/lesson_plans.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';

class LessonPlanDetailScreen extends StatelessWidget {
  const LessonPlanDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lessonPlan = Get.arguments as LessonPlan;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildDetailRow(Icons.subject, 'Subject', lessonPlan.subject),
          const Divider(),
          _buildDetailRow(Icons.school, 'Grade Level', lessonPlan.gradeLevel),
          const Divider(),
          _buildDetailRow(
            Icons.timer,
            'Duration',
            '${lessonPlan.durationMinutes} minutes',
          ),
          const Divider(),
          _buildDetailRow(
            Icons.calendar_today,
            'Created',
            _formatDate(lessonPlan.createdAt),
          ),
          const Divider(),
          _buildDetailRow(
            Icons.update,
            'Last Updated',
            _formatDate(lessonPlan.updatedAt),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: TemarLijeColors.primary, size: 24),
          const SizedBox(width: 16),
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

class LessonPlanDetailBinding extends Bindings {
  @override
  void dependencies() {}
}
