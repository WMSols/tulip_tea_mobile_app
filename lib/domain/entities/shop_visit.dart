class ShopVisit {
  const ShopVisit({
    required this.id,
    this.shopId,
    this.shopName,
    this.visitType,
    this.gpsLat,
    this.gpsLng,
    this.visitTime,
    this.reason,
    this.createdAt,
  });

  final int id;
  final int? shopId;
  final String? shopName;
  final String? visitType;
  final double? gpsLat;
  final double? gpsLng;
  final String? visitTime;
  final String? reason;
  final String? createdAt;
}
