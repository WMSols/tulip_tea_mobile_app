class DailyCollectionCreate {
  DailyCollectionCreate({
    required this.shopId,
    required this.amount,
    this.collectedAt,
    this.remarks,
    this.visitId,
  });

  final int shopId;
  final double amount;
  final String? collectedAt;
  final String? remarks;
  final int? visitId;

  Map<String, dynamic> toJson() => {
    'shop_id': shopId,
    'amount': amount,
    if (collectedAt != null) 'collected_at': collectedAt,
    if (remarks != null) 'remarks': remarks,
    if (visitId != null) 'visit_id': visitId,
  };
}
