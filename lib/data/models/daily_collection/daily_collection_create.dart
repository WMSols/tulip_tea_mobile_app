/// Request body for POST /daily-collections/order-booker/{order_booker_id} (DailyCollectionCreate schema).
class DailyCollectionCreate {
  DailyCollectionCreate({
    required this.shopId,
    required this.amount,
    this.collectedAt,
    this.remarks,
    this.visitId,
    this.orderId,
  });

  final int shopId;
  final double amount;
  final String? collectedAt;
  final String? remarks;
  final int? visitId;
  final int? orderId;

  Map<String, dynamic> toJson() => {
    'shop_id': shopId,
    'amount': amount,
    if (collectedAt != null) 'collected_at': collectedAt,
    if (remarks != null) 'remarks': remarks,
    if (visitId != null) 'visit_id': visitId,
    if (orderId != null) 'order_id': orderId,
  };
}
