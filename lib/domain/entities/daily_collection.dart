class DailyCollection {
  const DailyCollection({
    required this.id,
    this.shopId,
    this.shopName,
    required this.amount,
    this.status,
    this.collectionDate,
    this.remarks,
  });

  final int id;
  final int? shopId;
  final String? shopName;
  final double amount;
  final String? status;
  final String? collectionDate;
  final String? remarks;
}
