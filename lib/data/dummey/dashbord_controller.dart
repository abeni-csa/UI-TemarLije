import 'package:get/get.dart';
import 'package:ui_temarlije/model/order.dart';
import 'package:ui_temarlije/utils/helpers/helper_functions.dart';

class DashbordCartController extends GetxController {
  static DashbordCartController get instance => Get.find();

  final RxList<double> weeklySales = <double>[].obs;
  final List<OrderModel> orders = [
    OrderModel(
      id: "jsdjafksjdf",
      totalAmount: 300.9,
      date: DateTime(2026, 05, 10),
      name: "Data One",
    ),
    OrderModel(
      id: "aksjdafjsdflj",
      totalAmount: 420,
      date: DateTime(2026, 05, 11),
      name: "Data One",
    ),
    OrderModel(
      id: "jsdjafksjdf",
      totalAmount: 300.9,
      date: DateTime(2026, 05, 12),
      name: "Data One",
    ),
    OrderModel(
      id: "aksjdafjsdflj",
      totalAmount: 420,
      date: DateTime(2026, 05, 13),
      name: "Data One",
    ),
    OrderModel(
      id: "jsdjajaksdjkf",
      totalAmount: 400.9,
      date: DateTime(2026, 05, 14),
      name: "Data One",
    ),
    OrderModel(
      id: "bbasedf",
      totalAmount: 350.9,
      date: DateTime(2026, 05, 15),
      name: "Data One",
    ),
    OrderModel(
      id: "aabbccdd",
      totalAmount: 500.9,
      date: DateTime(2026, 05, 16),
      name: "Data One",
    ),
  ];

  @override
  void onInit() {
    _calculateWeeklySales();
    super.onInit();
  }

  void _calculateWeeklySales() {
    weeklySales.value = List<double>.filled(7, 0.0);
    for (var order in orders) {
      final DateTime orderWeekStart = TemarLijeHelperFunctions.getStartOfWeek(
        order.date,
      );

      if (orderWeekStart.isBefore(DateTime.now()) &&
          orderWeekStart.add(const Duration(days: 7)).isAfter(DateTime.now())) {
        int idx = (order.date.weekday - 1) % 7;
        idx = idx < 0 ? idx + 7 : idx;
        weeklySales[idx] += order.totalAmount;
        print(
          'Order Date ${order.date}, CurrentWeekDay $orderWeekStart, Index: $idx',
        );
      }
    }
    print('Weekly Sales $weeklySales');
  }
}

class DashbordController {}
