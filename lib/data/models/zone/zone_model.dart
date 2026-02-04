import 'package:tulip_tea_order_booker/domain/entities/zone.dart';

class ZoneModel {
  ZoneModel({required this.id, required this.name});

  factory ZoneModel.fromJson(Map<String, dynamic> json) {
    return ZoneModel(id: json['id'] as int, name: json['name'] as String);
  }

  final int id;
  final String name;

  Zone toEntity() => Zone(id: id, name: name);
}
