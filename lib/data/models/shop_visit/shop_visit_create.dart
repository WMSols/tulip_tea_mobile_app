class ShopVisitCreate {
  ShopVisitCreate({
    this.shopId,
    this.visitType,
    this.gpsLat,
    this.gpsLng,
    this.visitTime,
    this.photo,
    this.reason,
  });

  final int? shopId;
  final String? visitType;
  final double? gpsLat;
  final double? gpsLng;
  final String? visitTime;
  final String? photo;
  final String? reason;

  Map<String, dynamic> toJson() => {
    if (shopId != null) 'shop_id': shopId,
    if (visitType != null) 'visit_type': visitType,
    if (gpsLat != null) 'gps_lat': gpsLat,
    if (gpsLng != null) 'gps_lng': gpsLng,
    if (visitTime != null) 'visit_time': visitTime,
    if (photo != null) 'photo': photo,
    if (reason != null) 'reason': reason,
  };
}
