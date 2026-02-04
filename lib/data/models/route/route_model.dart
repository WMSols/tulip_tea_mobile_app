import 'package:tulip_tea_order_booker/domain/entities/route_entity.dart';

class RouteModel {
  RouteModel({
    required this.id,
    required this.name,
    this.zoneId,
    this.orderBookerId,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    return RouteModel(
      id: json['id'] as int,
      name: json['name'] as String,
      zoneId: json['zone_id'] as int?,
      orderBookerId: json['order_booker_id'] as int?,
    );
  }

  final int id;
  final String name;
  final int? zoneId;
  final int? orderBookerId;

  RouteEntity toEntity() => RouteEntity(
    id: id,
    name: name,
    zoneId: zoneId,
    orderBookerId: orderBookerId,
  );
}
