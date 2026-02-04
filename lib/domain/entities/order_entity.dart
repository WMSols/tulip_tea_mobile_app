class OrderItem {
  const OrderItem({
    required this.productName,
    required this.quantity,
    required this.unitPrice,
  });

  final String productName;
  final int quantity;
  final double unitPrice;
}

class OrderEntity {
  const OrderEntity({
    required this.id,
    required this.shopId,
    this.orderItems,
    this.scheduledDate,
    this.visitId,
    this.status,
    this.createdAt,
  });

  final int id;
  final int shopId;
  final List<OrderItem>? orderItems;
  final String? scheduledDate;
  final int? visitId;
  final String? status;
  final String? createdAt;
}
