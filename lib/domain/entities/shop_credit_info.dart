/// Credit info from GET /shops/{shop_id}/credit-info
class ShopCreditInfo {
  const ShopCreditInfo({
    required this.shopId,
    this.shopName,
    this.creditLimit,
    this.outstandingBalance,
    this.availableCredit,
  });

  final int shopId;
  final String? shopName;
  final double? creditLimit;
  final double? outstandingBalance;
  final double? availableCredit;
}
