import 'package:flutter/material.dart';
import 'package:ui_temarlije/data/models/academic_year.dart';
import 'package:ui_temarlije/features/administrator/academic_year/screens/widgets/academic_year_card.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class AcademicYearList extends StatelessWidget {
  final List<AcademicYear> academicYears;
  final AcademicYear? currentAcademicYear;
  final bool isLoading;
  final VoidCallback onRefresh;
  final Function(AcademicYear) onDelete;
  final Function(AcademicYear) onEdit;

  const AcademicYearList({
    super.key,
    required this.academicYears,
    this.currentAcademicYear,
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
              'Academic Years',
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
        else if (academicYears.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 64,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No Academic Years',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap + to create your first academic year',
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
                  ),
                ],
              ),
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            itemCount: academicYears.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final academicYear = academicYears[index];
              return AcademicYearCard(
                academicYear: academicYear,
                onDelete: () => onDelete(academicYear),
                onEdit: () => onEdit(academicYear),
                onTap: () {
                  // Navigate to academic year details if needed
                },
              );
            },
          ),
      ],
    );
  }
}
