class CreditLimitRequest {
  const CreditLimitRequest({
    required this.id,
    required this.shopId,
    this.shopName,
    this.shopOwner,
    required this.requestedById,
    this.requestedByName,
    this.oldCreditLimit,
    required this.requestedCreditLimit,
    this.status,
    this.approvedAt,
    this.remarks,
    this.createdAt,
  });

  final int id;
  final int shopId;
  final String? shopName;
  final String? shopOwner;
  final int requestedById;
  final String? requestedByName;
  final double? oldCreditLimit;
  final double requestedCreditLimit;
  final String? status;
  final String? approvedAt;
  final String? remarks;
  final String? createdAt;
}
