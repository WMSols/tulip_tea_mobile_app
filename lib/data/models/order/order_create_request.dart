class OrderCreateRequest {
  OrderCreateRequest({
    required this.shopId,
    required this.orderItems,
    this.scheduledDate,
    this.visitId,
  });

  final int shopId;
  final List<OrderItemRequest> orderItems;
  final String? scheduledDate;
  final int? visitId;

  Map<String, dynamic> toJson() => {
    'shop_id': shopId,
    'order_items': orderItems.map((e) => e.toJson()).toList(),
    if (scheduledDate != null) 'scheduled_date': scheduledDate,
    if (visitId != null) 'visit_id': visitId,
  };
}

class OrderItemRequest {
  OrderItemRequest({
    required this.productName,
    required this.quantity,
    required this.unitPrice,
  });

  final String productName;
  final int quantity;
  final double unitPrice;

  Map<String, dynamic> toJson() => {
    'product_name': productName,
    'quantity': quantity,
    'unit_price': unitPrice,
  };
}
