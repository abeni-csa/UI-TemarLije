import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:ui_temarlije/common/widgets/data_table/paginated_data_table.dart';

class DashboardTabletScreen extends StatelessWidget {
  const DashboardTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Dashbord View of Tablet"),
        TemarLijePaginatedDataTable(
          columns: const [
            DataColumn2(label: Text("Column1")),
            DataColumn2(label: Text("Column2")),
            DataColumn2(label: Text("Column3")),
            DataColumn2(label: Text("Column4")),
          ],
          source: MyDataTable(),
        ),
      ],
    );
  }
}

class DashboardController extends GetxController {
  var dataList = <Map<String, String>>[].obs;
  @override
  void onInit() {
    super.onInit();
    fetchDummyData();
  }

  void fetchDummyData() {
    dataList.addAll(
      List.generate(
        1000,
        (index) => {
          'Column1': 'Data ${index + 1} - 1',
          'Column2': 'Data ${index + 1} - 1',
          'Column3': 'Data ${index + 1} - 1',
          'Column4': 'Data ${index + 1} - 1',
        },
      ),
    );
  }
}

class MyDataTable extends DataTableSource {
  final DashboardController controller = Get.put(DashboardController());
  @override
  DataRow? getRow(int index) {
    final data = controller.dataList[index];
    return DataRow2(
      cells: [
        DataCell(Text(data['Column1'] ?? '')),
        DataCell(Text(data['Column2'] ?? '')),
        DataCell(Text(data['Column3'] ?? '')),
        DataCell(Text(data['Column4'] ?? '')),
      ],
    );
  }

  @override
  int get rowCount => controller.dataList.length;
  @override
  bool get isRowCountApproximate => false;
  @override
  int get selectedRowCount => 0;
}
