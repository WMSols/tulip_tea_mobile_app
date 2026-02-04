import 'package:tulip_tea_order_booker/domain/entities/shop.dart';

class ShopResponseModel {
  ShopResponseModel({
    required this.id,
    required this.name,
    required this.ownerName,
    required this.ownerPhone,
    this.gpsLat,
    this.gpsLng,
    this.zoneId,
    this.routeId,
    this.creditLimit,
    this.registrationStatus,
    this.createdAt,
  });

  factory ShopResponseModel.fromJson(Map<String, dynamic> json) {
    return ShopResponseModel(
      id: json['id'] as int,
      name: json['name'] as String,
      ownerName: json['owner_name'] as String,
      ownerPhone: json['owner_phone'] as String,
      gpsLat: (json['gps_lat'] as num?)?.toDouble(),
      gpsLng: (json['gps_lng'] as num?)?.toDouble(),
      zoneId: json['zone_id'] as int?,
      routeId: json['route_id'] as int?,
      creditLimit: (json['credit_limit'] as num?)?.toDouble(),
      registrationStatus: json['registration_status'] as String?,
      createdAt: json['created_at'] as String?,
    );
  }

  final int id;
  final String name;
  final String ownerName;
  final String ownerPhone;
  final double? gpsLat;
  final double? gpsLng;
  final int? zoneId;
  final int? routeId;
  final double? creditLimit;
  final String? registrationStatus;
  final String? createdAt;

  Shop toEntity() => Shop(
    id: id,
    name: name,
    ownerName: ownerName,
    ownerPhone: ownerPhone,
    gpsLat: gpsLat,
    gpsLng: gpsLng,
    zoneId: zoneId,
    routeId: routeId,
    creditLimit: creditLimit,
    registrationStatus: registrationStatus,
    createdAt: createdAt,
  );
}
