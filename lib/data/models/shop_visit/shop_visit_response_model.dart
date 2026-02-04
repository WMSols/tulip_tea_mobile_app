import 'package:tulip_tea_order_booker/domain/entities/shop_visit.dart';

class ShopVisitResponseModel {
  ShopVisitResponseModel({
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

  factory ShopVisitResponseModel.fromJson(Map<String, dynamic> json) {
    return ShopVisitResponseModel(
      id: json['id'] as int,
      shopId: json['shop_id'] as int?,
      shopName: json['shop_name'] as String?,
      visitType: json['visit_type'] as String?,
      gpsLat: (json['gps_lat'] as num?)?.toDouble(),
      gpsLng: (json['gps_lng'] as num?)?.toDouble(),
      visitTime: json['visit_time'] as String?,
      reason: json['reason'] as String?,
      createdAt: json['created_at'] as String?,
    );
  }

  final int id;
  final int? shopId;
  final String? shopName;
  final String? visitType;
  final double? gpsLat;
  final double? gpsLng;
  final String? visitTime;
  final String? reason;
  final String? createdAt;

  ShopVisit toEntity() => ShopVisit(
    id: id,
    shopId: shopId,
    shopName: shopName,
    visitType: visitType,
    gpsLat: gpsLat,
    gpsLng: gpsLng,
    visitTime: visitTime,
    reason: reason,
    createdAt: createdAt,
  );
}
