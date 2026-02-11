import 'package:tulip_tea_mobile_app/domain/entities/shop_visit.dart';

/// Response for GET/POST shop visits (ShopVisitResponse schema).
class ShopVisitResponseModel {
  ShopVisitResponseModel({
    required this.id,
    this.shopId,
    this.shopName,
    this.shopZoneId,
    this.shopRoutes,
    this.orderBookerId,
    this.orderBookerName,
    this.deliveryManId,
    this.deliveryManName,
    this.visitTypes,
    this.gpsLat,
    this.gpsLng,
    this.visitTime,
    this.reason,
    this.createdAt,
  });

  factory ShopVisitResponseModel.fromJson(Map<String, dynamic> json) {
    List<String>? visitTypesList;
    if (json['visit_types'] != null) {
      visitTypesList = (json['visit_types'] as List<dynamic>).cast<String>();
    }
    return ShopVisitResponseModel(
      id: json['id'] as int,
      shopId: json['shop_id'] as int?,
      shopName: json['shop_name'] as String?,
      shopZoneId: json['shop_zone_id'] as int?,
      shopRoutes: (json['shop_routes'] as List<dynamic>?)
          ?.map((e) => Map<String, dynamic>.from(e as Map))
          .toList(),
      orderBookerId: json['order_booker_id'] as int?,
      orderBookerName: json['order_booker_name'] as String?,
      deliveryManId: json['delivery_man_id'] as int?,
      deliveryManName: json['delivery_man_name'] as String?,
      visitTypes: visitTypesList,
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
  final int? shopZoneId;
  final List<Map<String, dynamic>>? shopRoutes;
  final int? orderBookerId;
  final String? orderBookerName;
  final int? deliveryManId;
  final String? deliveryManName;
  final List<String>? visitTypes;
  final double? gpsLat;
  final double? gpsLng;
  final String? visitTime;
  final String? reason;
  final String? createdAt;

  ShopVisit toEntity() => ShopVisit(
    id: id,
    shopId: shopId,
    shopName: shopName,
    visitType: visitTypes?.isNotEmpty == true ? visitTypes!.first : null,
    gpsLat: gpsLat,
    gpsLng: gpsLng,
    visitTime: visitTime,
    reason: reason,
    createdAt: createdAt,
  );
}
