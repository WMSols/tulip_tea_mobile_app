import 'package:tulip_tea_mobile_app/domain/entities/product.dart';

/// Response for GET /products/active (ProductResponse schema).
class ProductModel {
  ProductModel({
    required this.id,
    required this.code,
    required this.name,
    this.unit,
    this.price,
    required this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      code: json['code'] as String? ?? '',
      name: json['name'] as String,
      unit: json['unit'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      isActive: json['is_active'] as bool? ?? true,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  final int id;
  final String code;
  final String name;
  final String? unit;
  final double? price;
  final bool isActive;
  final String? createdAt;
  final String? updatedAt;

  Product toEntity() => Product(
    id: id,
    code: code.isEmpty ? null : code,
    name: name,
    unit: unit,
    unitPrice: price,
    isActive: isActive,
  );
}
