import 'package:tulip_tea_order_booker/domain/entities/auth_user.dart';

class UserModel {
  UserModel({
    required this.id,
    required this.name,
    required this.phone,
    this.email,
    this.zoneId,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      name: json['name'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String?,
      zoneId: json['zone_id'] as int?,
      role: json['role'] as String? ?? 'order_booker',
    );
  }

  final int id;
  final String name;
  final String phone;
  final String? email;
  final int? zoneId;
  final String role;

  AuthUser toEntity() => AuthUser(
    id: id,
    name: name,
    phone: phone,
    email: email,
    zoneId: zoneId,
    role: role,
  );
}
