class CreditLimitRequestCreate {
  CreditLimitRequestCreate({
    required this.shopId,
    required this.requestedCreditLimit,
    this.remarks,
  });

  final int shopId;
  final double requestedCreditLimit;
  final String? remarks;

  Map<String, dynamic> toJson() => {
    'shop_id': shopId,
    'requested_credit_limit': requestedCreditLimit,
    if (remarks != null && remarks!.isNotEmpty) 'remarks': remarks,
  };
}
