import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/data/models/lesson_plans.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';
import 'package:ui_temarlije/routes/routes.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class LessonPlanningCard extends StatelessWidget {
  final LessonPlan lessonPlan;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const LessonPlanningCard({
    super.key,
    required this.lessonPlan,
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
      child: InkWell(
        onTap: () => Get.toNamed(
          TemarLijeRoutes.lessonPlanDetail,
          arguments: lessonPlan,
        ),
        borderRadius: BorderRadius.circular(TemarLijeSizes.borderRadiusMd),
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
                  color: TemarLijeColors.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.menu_book,
                  color: TemarLijeColors.primary,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),

              // Content section (expands)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lessonPlan.title,
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
                      lessonPlan.subject,
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
                          lessonPlan.gradeLevel,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Icon(
                          Icons.timer,
                          size: 14,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${lessonPlan.durationMinutes} min',
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
      ),
    );
  }
}
