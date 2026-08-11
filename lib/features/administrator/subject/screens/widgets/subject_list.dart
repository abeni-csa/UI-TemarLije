import 'package:flutter/material.dart';
import 'package:ui_temarlije/data/models/subject.dart';
import 'package:ui_temarlije/features/administrator/subject/screens/widgets/subject_card.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class SubjectList extends StatelessWidget {
  final List<Subject> subjects;
  final bool isLoading;
  final VoidCallback onRefresh;
  final Function(Subject) onDelete;
  final Function(Subject) onEdit;

  const SubjectList({
    super.key,
    required this.subjects,
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
              'Subjects',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              overflow: TextOverflow.fade,
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
        else if (subjects.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: [
                  Icon(
                    Icons.book_outlined,
                    size: 64,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No Subjects Yet',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap + to create a new subject',
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
                  ),
                ],
              ),
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            itemCount: subjects.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final subject = subjects[index];
              return SubjectCard(
                subject: subject,
                onDelete: () => onDelete(subject),
                onEdit: () => onEdit(subject),
              );
            },
          ),
      ],
    );
  }
}
