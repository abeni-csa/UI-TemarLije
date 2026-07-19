import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:ui_temarlije/common/widgets/data_table/paginated_data_table.dart';
import 'package:ui_temarlije/features/administrator/student_management/enrollments/table/enrollments_table_source.dart';

class EnrollmentsDataTable extends StatelessWidget {
  const EnrollmentsDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    return TemarLijePaginatedDataTable(
      columns: const [
        DataColumn2(label: Text('Student')),
        DataColumn2(label: Text('Section')),
        DataColumn2(label: Text('Classroom')),
        DataColumn2(label: Text('Grade')),
        DataColumn2(label: Text('Status')),
        DataColumn2(label: Text('Date')),
        DataColumn2(label: Text('Actions'), fixedWidth: 120),
      ],
      source: EnrollmentsTableSource(),
    );
  }
}
