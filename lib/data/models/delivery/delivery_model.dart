class DeliveryModel {
  DeliveryModel({
    required this.id,
    this.orderId,
    this.warehouseId,
    this.deliveryManId,
    this.status,
    this.pickupDate,
    this.deliveryDate,
    this.returnDate,
    this.pickupGpsLat,
    this.pickupGpsLng,
    this.deliveryGpsLat,
    this.deliveryGpsLng,
    this.deliveryRemarks,
    this.deliveryImages,
    this.returnReason,
    this.deliveryItems,
    this.createdAt,
    this.updatedAt,
  });

  factory DeliveryModel.fromJson(Map<String, dynamic> json) {
    return DeliveryModel(
      id: json['id'] as int,
      orderId: json['order_id'] as int?,
      warehouseId: json['warehouse_id'] as int?,
      deliveryManId: json['delivery_man_id'] as int?,
      status: json['status'] as String?,
      pickupDate: json['pickup_date'] != null
          ? DateTime.parse(json['pickup_date'] as String)
          : null,
      deliveryDate: json['delivery_date'] != null
          ? DateTime.parse(json['delivery_date'] as String)
          : null,
      returnDate: json['return_date'] != null
          ? DateTime.parse(json['return_date'] as String)
          : null,
      pickupGpsLat: json['pickup_gps_lat'] as double?,
      pickupGpsLng: json['pickup_gps_lng'] as double?,
      deliveryGpsLat: json['delivery_gps_lat'] as double?,
      deliveryGpsLng: json['delivery_gps_lng'] as double?,
      deliveryRemarks: json['delivery_remarks'] as String?,
      deliveryImages: (json['delivery_images'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      returnReason: json['return_reason'] as String?,
      deliveryItems: (json['delivery_items'] as List<dynamic>?)
          ?.map((e) => DeliveryItemModel.fromJson(e as Map<String, dynamic>))
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
  final int? orderId;
  final int? warehouseId;
  final int? deliveryManId;
  final String? status;
  final DateTime? pickupDate;
  final DateTime? deliveryDate;
  final DateTime? returnDate;
  final double? pickupGpsLat;
  final double? pickupGpsLng;
  final double? deliveryGpsLat;
  final double? deliveryGpsLng;
  final String? deliveryRemarks;
  final List<String>? deliveryImages;
  final String? returnReason;
  final List<DeliveryItemModel>? deliveryItems;
  final DateTime? createdAt;
  final DateTime? updatedAt;
}

class DeliveryItemModel {
  DeliveryItemModel({
    required this.id,
    this.deliveryId,
    this.productId,
    this.productName,
    this.quantity,
    this.status,
  });

  factory DeliveryItemModel.fromJson(Map<String, dynamic> json) {
    return DeliveryItemModel(
      id: json['id'] as int,
      deliveryId: json['delivery_id'] as int?,
      productId: json['product_id'] as int?,
      productName: json['product_name'] as String?,
      quantity: json['quantity'] as int?,
      status: json['status'] as String?,
    );
  }

  final int id;
  final int? deliveryId;
  final int? productId;
  final String? productName;
  final int? quantity;
  final String? status;
}
