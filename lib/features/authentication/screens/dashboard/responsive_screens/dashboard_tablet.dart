import 'package:flutter/material.dart';
import 'package:ui_temarlije/common/widgets/layouts/template/loging_template.dart';

class DashboardTabletScreen extends StatelessWidget {
  const DashboardTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TemarLijeLoginScreenTemplate(
      child: Column(children: [Text("Dashbord View of Tablet")]),
    );
  }
}
// class DashboardController extends GetxController {
//   var dataList = <Map<String, String>>[].obs;
//   @override
//   void onInit() {
//     super.onInit();
//     fetchDummyData();
//   }

//   void fetchDummyData() {
//     dataList.addAll(
//       List.generate(
//         36,
//         (index) => {
//           'Column1': 'Data ${index + 1} - 1',
//           'Column2': 'Data ${index + 1} - 1',
//           'Column3': 'Data ${index + 1} - 1',
//           'Column4': 'Data ${index + 1} - 1',
//         },
//       ),
//     );
//   }
// }

// class MyDataTable extends DataTableSource {
//   final DashboardController controller = Get.put(DashboardController());
//   @override
//   DataRow? getRow(int index) {
//     final data = controller.dataList[index];
//     return DataRow2(
//       cells: [
//         DataCell(Text(data['Column1'] ?? '')),
//         DataCell(Text(data['Column2'] ?? '')),
//         DataCell(Text(data['Column3'] ?? '')),
//         DataCell(Text(data['Column4'] ?? '')),
//       ],
//     );
//   }

//   @override
//   // TODO: implement rowCount
//   int get rowCount => controller.dataList.length;
//   @override
//   // TODO: implement isRowCountApproximate
//   bool get isRowCountApproximate => false;
//   @override
//   // TODO: implement selectedRowCount
//   int get selectedRowCount => 0;
// }
// // PaginatedDataTable2(
// //   checkboxHorizontalMargin: 12,
// //   wrapInCard: false,
// //   renderEmptyRowsInTheEnd: false,

// //   minWidth: 500,
// //   columnSpacing: 12,
// //   dividerThickness: 0,
// //   horizontalMargin: 12,
// //   dataRowHeight: 56,
// //   headingTextStyle: Theme.of(context).textTheme.titleSmall,
// //   headingRowDecoration: const BoxDecoration(
// //     borderRadius: BorderRadius.only(
// //       topLeft: Radius.circular(TemarLijeSizes.borderRadiusMd),
// //       topRight: Radius.circular(TemarLijeSizes.borderRadiusMd),
// //     ),
// //   ),
// //   showCheckboxColumn: true,
// //   columns: const [
// //     DataColumn2(label: Text("Column 1")),
// //     DataColumn2(label: Text("Column 2")),
// //     DataColumn2(label: Text("Column 3")),
// //     DataColumn2(label: Text("Column 4")),
// //   ],
// //   source: MyDataTable(),
// // ),
