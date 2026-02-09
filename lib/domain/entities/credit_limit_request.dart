/// Credit limit request: order booker requests increase/decrease for a shop.
/// API: POST /credit-limit-requests/order-booker/{order_booker_id} (create).
class CreditLimitRequest {
  const CreditLimitRequest({
    required this.id,
    required this.shopId,
    this.shopName,
    this.shopOwner,
    required this.requestedById,
    this.requestedByName,
    this.requestedByRole,
    this.oldCreditLimit,
    required this.requestedCreditLimit,
    this.status,
    this.approvedAt,
    this.approvedByDistributorName,
    this.remarks,
    this.createdAt,
  });

  final int id;
  final int shopId;
  final String? shopName;
  final String? shopOwner;
  final int requestedById;
  final String? requestedByName;
  final String? requestedByRole;
  final double? oldCreditLimit;
  final double requestedCreditLimit;
  final String? status;
  final String? approvedAt;
  final String? approvedByDistributorName;
  final String? remarks;
  final String? createdAt;
}
