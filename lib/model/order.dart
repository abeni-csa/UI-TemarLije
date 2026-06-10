class OrderModel {
  final String id;
  final String name;
  final double totalAmount;
  final DateTime date;
  OrderModel({
    required this.id,
    required this.totalAmount,
    required this.date,
    required this.name,
  });
}
