/// Request body for POST /orders/order-booker/{order_booker_id} (OrderCreate schema).
class OrderCreateRequest {
  OrderCreateRequest({
    required this.shopId,
    required this.orderItems,
    this.scheduledDate,
    this.visitId,
    this.finalTotalAmount,
  });

  final int shopId;
  final List<OrderItemRequest> orderItems;
  final String? scheduledDate;
  final int? visitId;
  final double? finalTotalAmount;

  Map<String, dynamic> toJson() => {
    'shop_id': shopId,
    'order_items': orderItems.map((e) => e.toJson()).toList(),
    if (scheduledDate != null) 'scheduled_date': scheduledDate,
    if (visitId != null) 'visit_id': visitId,
    if (finalTotalAmount != null) 'final_total_amount': finalTotalAmount,
  };
}

/// OrderItemCreate schema: product_id and/or product_name, quantity (required), unit_price.
class OrderItemRequest {
  OrderItemRequest({
    this.productId,
    this.productName,
    required this.quantity,
    this.unitPrice,
  });

  final int? productId;
  final String? productName;
  final int quantity;
  final double? unitPrice;

  Map<String, dynamic> toJson() => {
    if (productId != null) 'product_id': productId,
    if (productName != null) 'product_name': productName,
    'quantity': quantity,
    if (unitPrice != null) 'unit_price': unitPrice,
  };
}
