class BagModel {
  final List<OrderItem> orderItems;
  final DateTime createdAt;
  BagModel({required this.orderItems, required this.createdAt});
}

class OrderItem {
  final String product;
  final String id;
  final int quantity;
  final String selectedColor;
  final String selectedSize;
  final DateTime createdAt;
  OrderItem(
      {required this.product,
      required this.quantity,
      required this.id,
      required this.selectedSize,
      required this.selectedColor,
      required this.createdAt});
}
