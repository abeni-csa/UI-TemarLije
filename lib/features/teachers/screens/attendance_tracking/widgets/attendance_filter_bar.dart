import 'package:flutter/material.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';

class AttendanceFilterBar extends StatelessWidget {
  final String selectedSection;
  final List<String> sections;
  final VoidCallback onMarkAllPresent;
  final VoidCallback onMarkAllAbsent;
  final ValueChanged<String?> onSectionChanged;

  const AttendanceFilterBar({
    super.key,
    required this.selectedSection,
    required this.sections,
    required this.onMarkAllPresent,
    required this.onMarkAllAbsent,
    required this.onSectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        alignment: WrapAlignment.spaceBetween,
        children: [_buildFilterDropdown(), _buildActionButtons()],
      ),
    );
  }

  Widget _buildFilterDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Material(
        color: Colors.transparent,
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedSection,
            icon: const Icon(Icons.filter_list),
            items: sections.map((section) {
              return DropdownMenuItem<String>(
                value: section,
                child: Text('Section $section'),
              );
            }).toList(),
            onChanged: onSectionChanged,
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton.icon(
          onPressed: onMarkAllPresent,
          icon: const Icon(Icons.done_all, size: 18),
          label: const Text('All Present'),
          style: ElevatedButton.styleFrom(
            backgroundColor: TemarLijeColors.present,
            foregroundColor: TemarLijeColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(width: 8),
        OutlinedButton.icon(
          onPressed: onMarkAllAbsent,
          icon: const Icon(Icons.close, size: 18),
          label: const Text('All Absent'),
          style: OutlinedButton.styleFrom(
            foregroundColor: TemarLijeColors.absent,
            side: const BorderSide(color: TemarLijeColors.absent),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
