import 'package:flutter/material.dart';
import 'package:ui_temarlije/data/models/lesson_plans.dart';
import 'package:ui_temarlije/features/teachers/screens/lesson_planning/widgets/lesson_planning_card.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class LessonPlanningList extends StatelessWidget {
  final List<LessonPlan> lessonPlans;
  final bool isLoading;
  final VoidCallback onRefresh;
  final Function(LessonPlan) onDelete;
  final Function(LessonPlan) onEdit;

  const LessonPlanningList({
    super.key,
    required this.lessonPlans,
    required this.isLoading,
    required this.onRefresh,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'My Lesson Plans',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.refresh, color: Colors.black),
              onPressed: onRefresh,
              tooltip: 'Refresh',
            ),
          ],
        ),
        const SizedBox(height: TemarLijeSizes.spaceBtwItems),

        if (isLoading)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: CircularProgressIndicator(color: Colors.black),
            ),
          )
        else if (lessonPlans.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: [
                  Icon(
                    Icons.menu_book_outlined,
                    size: 64,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No lesson plans yet',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap + to create your first lesson plan',
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
                  ),
                ],
              ),
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: lessonPlans.length,
            itemBuilder: (context, index) {
              final lessonPlan = lessonPlans[index];
              return LessonPlanningCard(
                lessonPlan: lessonPlan,
                onDelete: () => onDelete(lessonPlan),
                onEdit: () => onEdit(lessonPlan),
              );
            },
          ),
      ],
    );
  }
}
