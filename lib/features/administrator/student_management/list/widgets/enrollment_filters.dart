import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/data/models/student_enrollment.dart';
import 'package:ui_temarlije/features/administrator/student_management/enrollments/enrollments_controller.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';
import 'package:ui_temarlije/utils/device/device_utility.dart';

class EnrollmentFilters extends StatelessWidget {
  const EnrollmentFilters({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StudentEnrollmentsController>();

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[300]!),
      ),
      child: Padding(
        padding: EdgeInsets.all(
          TemarLijeDeviceUtils.isMobileScreen(context) ? 12 : 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter header
            Row(
              children: [
                Icon(
                  Icons.filter_list,
                  size: TemarLijeDeviceUtils.isMobileScreen(context) ? 18 : 20,
                  color: TemarLijeColors.accent,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Filters',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                if (!TemarLijeDeviceUtils.isMobileScreen(context))
                  TextButton(
                    onPressed: controller.clearFilters,
                    child: const Text('Clear All'),
                  ),
              ],
            ),
            const SizedBox(height: 12),

            // Filter rows
            TemarLijeDeviceUtils.isMobileScreen(context)
                ? _buildMobileFilters(controller)
                : _buildDesktopFilters(controller),

            // Clear filters for mobile
            if (TemarLijeDeviceUtils.isMobileScreen(context))
              Obx(
                () => Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: controller.clearFilters,
                    child: const Text('Clear All'),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopFilters(StudentEnrollmentsController controller) {
    return Row(
      children: [
        Expanded(
          child: _buildDropdown(
            value: controller.selectedAcademicYearId.value,
            items: controller.availableAcademicYears,
            label: 'Academic Year',
            onChanged: controller.selectAcademicYear,
            displayValue: (ay) => ay.yearRange,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildDropdown(
            value: controller.selectedSectionId.value,
            items: controller.availableSections,
            label: 'Section',
            onChanged: controller.selectSection,
            displayValue: (s) => s.sectionName,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(child: _buildStatusDropdown(controller)),
        const SizedBox(width: 12),
        Expanded(child: _buildSearchField(controller)),
      ],
    );
  }

  Widget _buildMobileFilters(StudentEnrollmentsController controller) {
    return Column(
      children: [
        _buildDropdown(
          value: controller.selectedAcademicYearId.value,
          items: controller.availableAcademicYears,
          label: 'Academic Year',
          onChanged: controller.selectAcademicYear,
          displayValue: (ay) => ay.yearRange,
        ),
        const SizedBox(height: 12),
        _buildDropdown(
          value: controller.selectedSectionId.value,
          items: controller.availableSections,
          label: 'Section',
          onChanged: controller.selectSection,
          displayValue: (s) => s.sectionName,
        ),
        const SizedBox(height: 12),
        _buildStatusDropdown(controller),
        const SizedBox(height: 12),
        _buildSearchField(controller),
      ],
    );
  }

  Widget _buildDropdown<T>({
    required String? value,
    required List<T> items,
    required String label,
    required Function(String?) onChanged,
    required String Function(T) displayValue,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      isExpanded: true,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      items: [
        DropdownMenuItem<String>(value: null, child: Text('All $label')),
        ...items.map((item) {
          return DropdownMenuItem<String>(
            value: item.toString(),
            child: Text(displayValue(item)),
          );
        }),
      ],
      onChanged: onChanged,
    );
  }

  Widget _buildStatusDropdown(StudentEnrollmentsController controller) {
    return DropdownButtonFormField<EnrollmentStatus>(
      initialValue: controller.filterStatus.value,
      isExpanded: true,
      decoration: InputDecoration(
        labelText: 'Status',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      items: [
        const DropdownMenuItem<EnrollmentStatus>(
          value: null,
          child: Text('All Status'),
        ),
        ...EnrollmentStatus.values.map((status) {
          return DropdownMenuItem<EnrollmentStatus>(
            value: status,
            child: Text(status.toString().split('.').last),
          );
        }),
      ],
      onChanged: (value) {
        controller.filterStatus.value = value;
      },
    );
  }

  Widget _buildSearchField(StudentEnrollmentsController controller) {
    return TextField(
      onChanged: (value) => controller.searchQuery.value = value,
      decoration: InputDecoration(
        labelText: 'Search',
        hintText: 'Search by name or ID...',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        suffixIcon: Obx(() {
          if (controller.searchQuery.value.isNotEmpty) {
            return IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () => controller.searchQuery.value = '',
            );
          }
          return SizedBox();
        }),
      ),
    );
  }
}
