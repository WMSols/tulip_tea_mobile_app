/// Response item for GET /visit-tasks/order-booker/{order_booker_id}/today
class VisitTaskModel {
  VisitTaskModel({
    required this.id,
    required this.shopId,
    this.shopName,
    this.shopOwner,
    this.shopPhone,
    this.shopGpsLat,
    this.shopGpsLng,
    this.routeId,
    this.routeName,
    this.scheduledDate,
    this.dayOfWeek,
    this.status,
  });

  factory VisitTaskModel.fromJson(Map<String, dynamic> json) {
    return VisitTaskModel(
      id: json['id'] as int,
      shopId: json['shop_id'] as int,
      shopName: json['shop_name'] as String?,
      shopOwner: json['shop_owner'] as String?,
      shopPhone: json['shop_phone'] as String?,
      shopGpsLat: (json['shop_gps_lat'] as num?)?.toDouble(),
      shopGpsLng: (json['shop_gps_lng'] as num?)?.toDouble(),
      routeId: json['route_id'] as int?,
      routeName: json['route_name'] as String?,
      scheduledDate: json['scheduled_date'] as String?,
      dayOfWeek: json['day_of_week'] as int?,
      status: json['status'] as String?,
    );
  }

  final int id;
  final int shopId;
  final String? shopName;
  final String? shopOwner;
  final String? shopPhone;
  final double? shopGpsLat;
  final double? shopGpsLng;
  final int? routeId;
  final String? routeName;
  final String? scheduledDate;
  final int? dayOfWeek;
  final String? status;
}
