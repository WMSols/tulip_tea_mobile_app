import 'package:tulip_tea_order_booker/domain/entities/zone.dart';

/// Response for GET /zones/ (ZoneResponse schema).
class ZoneModel {
  ZoneModel({
    required this.id,
    required this.name,
    this.routeCount,
    this.shopCount,
    this.createdAt,
  });

  factory ZoneModel.fromJson(Map<String, dynamic> json) {
    return ZoneModel(
      id: json['id'] as int,
      name: json['name'] as String,
      routeCount: json['route_count'] as int?,
      shopCount: json['shop_count'] as int?,
      createdAt: json['created_at'] as String?,
    );
  }

  final int id;
  final String name;
  final int? routeCount;
  final int? shopCount;
  final String? createdAt;

  Zone toEntity() => Zone(id: id, name: name);
}
