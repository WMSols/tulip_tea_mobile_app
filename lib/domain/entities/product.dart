class Product {
  const Product({
    required this.id,
    this.code,
    required this.name,
    this.unit,
    this.unitPrice,
    this.isActive,
  });

  final int id;
  final String? code;
  final String name;
  final String? unit;
  final double? unitPrice;
  final bool? isActive;
}
