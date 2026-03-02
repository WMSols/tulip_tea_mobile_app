class WarehouseModel {
  WarehouseModel({
    required this.id,
    this.name,
    this.address,
    this.contactPerson,
    this.contactPhone,
    this.deliveryManId,
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
    this.availableQuantity,
    this.reservedQuantity,
  });

  factory WarehouseInventoryItem.fromJson(Map<String, dynamic> json) {
    return WarehouseInventoryItem(
      id: json['id'] as int,
      warehouseId: json['warehouse_id'] as int?,
      productId: json['product_id'] as int?,
      productName: json['product_name'] as String?,
      availableQuantity: json['available_quantity'] as int?,
      reservedQuantity: json['reserved_quantity'] as int?,
    );
  }

  final int id;
  final int? warehouseId;
  final int? productId;
  final String? productName;
  final int? availableQuantity;
  final int? reservedQuantity;
}
