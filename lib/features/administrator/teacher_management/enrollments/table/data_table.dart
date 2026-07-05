import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:ui_temarlije/common/widgets/data_table/paginated_data_table.dart';
import 'package:ui_temarlije/features/administrator/teacher_management/enrollments/table/table_sorce.dart';

class TeachersEnrollmentDataTable extends StatelessWidget {
  const TeachersEnrollmentDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    return TemarLijePaginatedDataTable(
      // minWidth: 1200,
      columns: const [
        // DataColumn2(label: Text("ID")),
        // DataColumn2(label: Text("School ID")),
        DataColumn2(label: Text("User ID")),
        // DataColumn2(label: Text("Academic Year")),
        DataColumn2(label: Text("Membership Type")),
        DataColumn2(label: Text("Status")),
        DataColumn2(label: Text("Action"), fixedWidth: 100),
      ],
      source: TeachersEnrollmentDataTableSource(),
    );
  }
}
