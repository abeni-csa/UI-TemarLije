import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:ui_temarlije/common/widgets/data_table/data_table.dart';
import 'package:ui_temarlije/data/models/attendance_record.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';

class AttendanceDataTable extends StatelessWidget {
  final List<Student> students;
  final Function(String) onToggleAttendance;

  const AttendanceDataTable({
    super.key,
    required this.students,
    required this.onToggleAttendance,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: TemarLijeDataTable(columns: _buildColumns(), rows: _buildRows()),
    );
  }

  List<DataColumn> _buildColumns() {
    return [
      const DataColumn2(
        label: Text(
          'ID',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        size: ColumnSize.S,
        fixedWidth: 80,
      ),
      const DataColumn2(
        label: Text(
          'Student Name',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        size: ColumnSize.L,
      ),
      const DataColumn2(
        label: Text(
          'Grade',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        size: ColumnSize.S,
        fixedWidth: 80,
      ),
      const DataColumn2(
        label: Text(
          'Section',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        size: ColumnSize.S,
        fixedWidth: 90,
      ),
      const DataColumn2(
        label: Text(
          'Status',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        size: ColumnSize.M,
      ),
      const DataColumn2(
        label: Text(
          'Actions',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        size: ColumnSize.S,
        fixedWidth: 100,
      ),
    ];
  }

  List<DataRow> _buildRows() {
    return students.map((student) {
      return DataRow(
        cells: [
          DataCell(Text(student.id)),
          DataCell(_buildStudentNameCell(student)),
          DataCell(Text(student.grade)),
          DataCell(_buildSectionCell(student)),
          DataCell(_buildStatusCell(student)),
          DataCell(_buildActionCell(student)),
        ],
      );
    }).toList();
  }

  Widget _buildStudentNameCell(Student student) {
    return Row(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: TemarLijeColors.primary.withValues(alpha: 0.2),
          child: Text(
            student.name[0],
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 12),
        Flexible(child: Text(student.name, overflow: TextOverflow.ellipsis)),
      ],
    );
  }

  Widget _buildSectionCell(Student student) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: TemarLijeColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        'Sec ${student.section}',
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildStatusCell(Student student) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: student.isPresent
            ? TemarLijeColors.present.withValues(alpha: 0.15)
            : TemarLijeColors.absent.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            student.isPresent ? Icons.check_circle : Icons.cancel,
            size: 16,
            color: student.isPresent
                ? TemarLijeColors.present
                : TemarLijeColors.absent,
          ),
          const SizedBox(width: 4),
          Text(
            student.isPresent ? 'Present' : 'Absent',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: student.isPresent
                  ? TemarLijeColors.present
                  : TemarLijeColors.absent,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCell(Student student) {
    return Switch(
      value: student.isPresent,
      onChanged: (_) => onToggleAttendance(student.id),
      activeColor: TemarLijeColors.present,
      inactiveThumbColor: TemarLijeColors.absent,
    );
  }
}
