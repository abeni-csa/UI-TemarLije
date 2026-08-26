import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:ui_temarlije/common/widgets/data_table/paginated_data_table.dart';
import 'package:ui_temarlije/features/administrator/teacher_management/all/table/table_sorce.dart';

class AllTeachersDataTable extends StatelessWidget {
  const AllTeachersDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    return TemarLijePaginatedDataTable(
      columns: const [
        DataColumn2(label: Text("Full Name"), fixedWidth: 200),
        DataColumn2(label: Text("Experience")),
        DataColumn2(label: Text("Employment Type")),
        DataColumn2(label: Text("Phone Number")),
        DataColumn2(label: Text("Gender")),
        DataColumn2(label: Text("Homeroom")),

        DataColumn2(label: Text("Action"), fixedWidth: 100),
      ],
      source: AllTeachersDataSource(),
    );
  }
}
