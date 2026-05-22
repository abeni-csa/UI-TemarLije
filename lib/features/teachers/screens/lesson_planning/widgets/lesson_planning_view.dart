import 'package:flutter/material.dart';
import 'package:ui_temarlije/data/models/lesson_plans.dart';
import 'package:ui_temarlije/data/repositories/lesson_planning_repository.dart';
import 'package:ui_temarlije/features/teachers/screens/lesson_planning/widgets/lesson_planning_form.dart';
import 'package:ui_temarlije/features/teachers/screens/lesson_planning/widgets/lesson_planning_list.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class LessonPlanningView extends StatefulWidget {
  const LessonPlanningView({super.key});

  @override
  State<LessonPlanningView> createState() => _LessonPlanningViewState();
}

class _LessonPlanningViewState extends State<LessonPlanningView> {
  final LessonPlanningRepository _repository = LessonPlanningRepository();
  List<LessonPlan> _lessonPlans = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadLessonPlans();
  }

  Future<void> _loadLessonPlans() async {
    setState(() => _isLoading = true);
    try {
      final plans = await _repository.getAllLessonPlans();
      setState(() {
        _lessonPlans = plans;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      _showError('Failed to load lesson plans: $e');
    }
  }

  Future<void> _createLessonPlan(LessonPlan lessonPlan) async {
    try {
      await _repository.createLessonPlan(lessonPlan);
      await _loadLessonPlans();
      if (mounted) {
        _showSuccess('Lesson plan created successfully!');
      }
    } catch (e) {
      _showError('Failed to create lesson plan: $e');
    }
  }

  Future<void> _updateLessonPlan(LessonPlan lessonPlan) async {
    try {
      await _repository.updateLessonPlan(lessonPlan);
      await _loadLessonPlans();
      if (mounted) {
        _showSuccess('Lesson plan updated successfully!');
      }
    } catch (e) {
      _showError('Failed to update lesson plan: $e');
    }
  }

  Future<void> _deleteLessonPlan(LessonPlan lessonPlan) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: TemarLijeColors.cardBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text('Delete Lesson Plan'),
        content: Text('Are you sure you want to delete "${lessonPlan.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: TemarLijeColors.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await _repository.deleteLessonPlan(lessonPlan.id);
        await _loadLessonPlans();
        if (mounted) {
          _showSuccess('Lesson plan deleted successfully!');
        }
      } catch (e) {
        _showError('Failed to delete lesson plan: $e');
      }
    }
  }

  void _showCreateDialog() {
    showDialog(
      context: context,
      builder: (context) =>
          LessonPlanningFormDialog(onSubmit: _createLessonPlan),
    );
  }

  void _showEditDialog(LessonPlan lessonPlan) {
    showDialog(
      context: context,
      builder: (context) => LessonPlanningFormDialog(
        lessonPlan: lessonPlan,
        onSubmit: _updateLessonPlan,
      ),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: TemarLijeColors.success,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: TemarLijeColors.error),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LessonPlanningList(
          lessonPlans: _lessonPlans,
          isLoading: _isLoading,
          onRefresh: _loadLessonPlans,
          onDelete: _deleteLessonPlan,
          onEdit: _showEditDialog,
        ),
        const SizedBox(height: TemarLijeSizes.spaceBtwItems),
        Align(
          alignment: Alignment.centerRight,
          child: FloatingActionButton(
            backgroundColor: TemarLijeColors.primary,
            onPressed: _showCreateDialog,
            mini: true,
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
