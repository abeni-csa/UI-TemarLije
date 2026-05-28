import 'package:flutter/material.dart';
import 'package:ui_temarlije/data/models/attendance_record.dart';
import 'package:ui_temarlije/features/teachers/screens/attendance_tracking/widgets/attendance_stat_cards.dart';
import 'package:ui_temarlije/features/teachers/screens/attendance_tracking/widgets/attendance_filter_bar.dart';
import 'package:ui_temarlije/features/teachers/screens/attendance_tracking/widgets/attendance_data_table.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  // Sample data
  final List<Student> _allStudents = [
    Student(
      id: 'S001',
      name: 'Emma Watson',
      grade: '10',
      section: 'A',
      isPresent: true,
    ),
    Student(
      id: 'S002',
      name: 'Liam Chen',
      grade: '10',
      section: 'A',
      isPresent: false,
    ),
    Student(
      id: 'S003',
      name: 'Olivia Rodriguez',
      grade: '10',
      section: 'A',
      isPresent: true,
    ),
    Student(
      id: 'S004',
      name: 'Noah Kim',
      grade: '10',
      section: 'B',
      isPresent: true,
    ),
    Student(
      id: 'S005',
      name: 'Ava Sharma',
      grade: '10',
      section: 'B',
      isPresent: false,
    ),
    Student(
      id: 'S006',
      name: 'Mason Johnson',
      grade: '10',
      section: 'B',
      isPresent: true,
    ),
    Student(
      id: 'S007',
      name: 'Isabella Brown',
      grade: '10',
      section: 'C',
      isPresent: true,
    ),
    Student(
      id: 'S008',
      name: 'Lucas Garcia',
      grade: '10',
      section: 'C',
      isPresent: false,
    ),
    Student(
      id: 'S009',
      name: 'Mia Taylor',
      grade: '10',
      section: 'C',
      isPresent: true,
    ),
    Student(
      id: 'S010',
      name: 'Ethan Martinez',
      grade: '10',
      section: 'A',
      isPresent: true,
    ),
  ];

  String _selectedSection = 'All';
  final List<String> _sections = ['All', 'A', 'B', 'C'];

  // Computed properties
  List<Student> get _filteredStudents {
    if (_selectedSection == 'All') return _allStudents;
    return _allStudents.where((s) => s.section == _selectedSection).toList();
  }

  int get totalStudents => _filteredStudents.length;
  int get presentCount => _filteredStudents.where((s) => s.isPresent).length;
  int get absentCount => totalStudents - presentCount;
  double get attendancePercentage =>
      totalStudents > 0 ? (presentCount / totalStudents) * 100 : 0;

  // Actions
  void _toggleAttendance(String studentId) {
    setState(() {
      final student = _allStudents.firstWhere((s) => s.id == studentId);
      student.isPresent = !student.isPresent;
    });
  }

  void _markAllPresent() {
    setState(() {
      for (var student in _filteredStudents) {
        student.isPresent = true;
      }
    });
  }

  void _markAllAbsent() {
    setState(() {
      for (var student in _filteredStudents) {
        student.isPresent = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize:
          MainAxisSize.min, // shrink-wrap so it's safe in a scrollable

      children: [
        // ...existing children before the problematic Expanded...
        // Replace:
        // Expanded(child: SomeWidget(...)),
        // With:
        Flexible(
          fit: FlexFit.loose,
          child: AttendanceStatCards(
            totalStudents: totalStudents,
            presentCount: presentCount,
            absentCount: absentCount,
            attendancePercentage: attendancePercentage,
          ), // ...existing widget content...
        ),

        // ...other children...
        // ...existing code...
        const SizedBox(height: 16),
        Flexible(
          fit: FlexFit.loose,
          child: AttendanceFilterBar(
            selectedSection: _selectedSection,
            sections: _sections,
            onMarkAllPresent: _markAllPresent,
            onMarkAllAbsent: _markAllAbsent,
            onSectionChanged: (value) =>
                setState(() => _selectedSection = value!),
          ),
        ),
        const SizedBox(height: TemarLijeSizes.spaceBtwItems),
        Flexible(
          fit: FlexFit.loose,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: constraints.maxWidth),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: AttendanceDataTable(
                      students: _filteredStudents,
                      onToggleAttendance: _toggleAttendance,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
