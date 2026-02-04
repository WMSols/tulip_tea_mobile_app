class Product {
  const Product({
    required this.id,
    required this.name,
    this.unitPrice,
    this.isActive,
  });

  final int id;
  final String name;
  final double? unitPrice;
  final bool? isActive;
}
