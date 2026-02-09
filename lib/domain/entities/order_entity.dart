class OrderItem {
  const OrderItem({
    this.id,
    this.orderId,
    this.productName,
    this.quantity,
    this.unitPrice,
    this.totalPrice,
  });

  final int? id;
  final int? orderId;
  final String? productName;
  final int? quantity;
  final double? unitPrice;
  final double? totalPrice;
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
