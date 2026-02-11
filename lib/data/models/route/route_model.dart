import 'package:tulip_tea_order_booker/domain/entities/route_entity.dart';

/// Response for GET routes (RouteResponse schema).
class RouteModel {
  RouteModel({
    required this.id,
    required this.name,
    this.zoneId,
    this.zoneName,
    this.orderBookerId,
    this.orderBookerName,
    this.createdByDistributor,
    this.createdAt,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    return RouteModel(
      id: json['id'] as int,
      name: json['name'] as String,
      zoneId: json['zone_id'] as int?,
      zoneName: json['zone_name'] as String?,
      orderBookerId: json['order_booker_id'] as int?,
      orderBookerName: json['order_booker_name'] as String?,
      createdByDistributor: json['created_by_distributor'] as int?,
      createdAt: json['created_at'] as String?,
    );
  }

  final int id;
  final String name;
  final int? zoneId;
  final String? zoneName;
  final int? orderBookerId;
  final String? orderBookerName;
  final int? createdByDistributor;
  final String? createdAt;

  RouteEntity toEntity() => RouteEntity(
    id: id,
    name: name,
    zoneId: zoneId,
    orderBookerId: orderBookerId,
  );
}
