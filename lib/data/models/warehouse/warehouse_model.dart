int? _parseInt(dynamic v) {
  if (v == null) return null;
  if (v is int) return v;
  if (v is double) return v.toInt();
  if (v is String) return int.tryParse(v);
  return null;
}

class WarehouseModel {
  WarehouseModel({
    required this.id,
    this.name,
    this.address,
    this.contactPerson,
    this.contactPhone,
    this.deliveryManId,
    this.zoneName,
    this.isActive,
    this.totalItemsInStock,
    this.inventory,
    this.createdAt,
    this.updatedAt,
  });

  factory WarehouseModel.fromJson(Map<String, dynamic> json) {
    return WarehouseModel(
      id: json['id'] as int,
      name: json['name'] as String?,
      address: json['address'] as String?,
      contactPerson: json['contact_person'] as String?,
      contactPhone: json['contact_phone'] as String?,
      deliveryManId: json['delivery_man_id'] as int?,
      zoneName: json['zone_name'] as String?,
      isActive: json['is_active'] as bool?,
      totalItemsInStock:
          _parseInt(json['total_items']) ??
          _parseInt(json['total_items_in_stock']),
      inventory: (json['inventory'] as List<dynamic>?)
          ?.map(
            (e) => WarehouseInventoryItem.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  final int id;
  final String? name;
  final String? address;
  final String? contactPerson;
  final String? contactPhone;
  final int? deliveryManId;
  final String? zoneName;
  final bool? isActive;
  final int? totalItemsInStock;
  final List<WarehouseInventoryItem>? inventory;
  final DateTime? createdAt;
  final DateTime? updatedAt;
}

class WarehouseInventoryItem {
  WarehouseInventoryItem({
    required this.id,
    this.warehouseId,
    this.productId,
    this.productName,
    this.productCode,
    this.quantity,
    this.unit,
    this.status,
    this.availableQuantity,
    this.reservedQuantity,
  });

  factory WarehouseInventoryItem.fromJson(Map<String, dynamic> json) {
    final quantityParsed = _parseInt(json['quantity']);
    final availableParsed = _parseInt(json['available_quantity']);
    return WarehouseInventoryItem(
      id: json['id'] as int,
      warehouseId: json['warehouse_id'] as int?,
      productId: _parseInt(json['product_id']),
      productName: json['product_name'] as String?,
      productCode: json['product_code'] as String? ?? json['code'] as String?,
      quantity: quantityParsed ?? availableParsed,
      unit: json['unit'] as String?,
      status: json['status'] as String?,
      availableQuantity: availableParsed ?? quantityParsed,
      reservedQuantity: _parseInt(json['reserved_quantity']),
    );
  }

  final int id;
  final int? warehouseId;
  final int? productId;
  final String? productName;
  final String? productCode;
  final int? quantity;
  final String? unit;
  final String? status;
  final int? availableQuantity;
  final int? reservedQuantity;
}
