class WarehouseInventoryItem {
  const WarehouseInventoryItem({
    required this.productId,
    required this.productName,
    this.quantity,
    this.unitPrice,
  });

  final int productId;
  final String productName;
  final int? quantity;
  final double? unitPrice;
}
