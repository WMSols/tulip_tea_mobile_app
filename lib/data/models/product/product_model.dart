import 'package:tulip_tea_order_booker/domain/entities/product.dart';

class ProductModel {
  ProductModel({
    required this.id,
    required this.name,
    this.unitPrice,
    this.isActive,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      name: json['name'] as String,
      unitPrice: (json['unit_price'] as num?)?.toDouble(),
      isActive: json['is_active'] as bool?,
    );
  }

  final int id;
  final String name;
  final double? unitPrice;
  final bool? isActive;

  Product toEntity() =>
      Product(id: id, name: name, unitPrice: unitPrice, isActive: isActive);
}
