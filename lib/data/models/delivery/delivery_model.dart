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

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    try {
      final s = value is String ? value : value.toString();
      if (s.isEmpty) return null;
      return DateTime.parse(s);
    } catch (_) {
      return null;
    }
  }

  static List<DeliveryItemModel>? _parseDeliveryItems(dynamic value) {
    if (value == null || value is! List) return null;
    try {
      return value
          .map((e) => DeliveryItemModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return null;
    }
  }

  factory DeliveryModel.fromJson(Map<String, dynamic> json) {
    // Backend may send picked_up_at / delivered_at / returned_at (or pickup_date / delivery_date / return_date)
    return DeliveryModel(
      id: json['id'] as int,
      orderId: json['order_id'] as int?,
      warehouseId: json['warehouse_id'] as int?,
      deliveryManId: json['delivery_man_id'] as int?,
      status: json['status'] as String?,
      pickupDate: _parseDate(json['picked_up_at'] ?? json['pickup_date']),
      deliveryDate: _parseDate(json['delivered_at'] ?? json['delivery_date']),
      returnDate: _parseDate(json['returned_at'] ?? json['return_date']),
      pickupGpsLat: json['pickup_gps_lat'] as double?,
      pickupGpsLng: json['pickup_gps_lng'] as double?,
      deliveryGpsLat: json['delivery_gps_lat'] as double?,
      deliveryGpsLng: json['delivery_gps_lng'] as double?,
      deliveryRemarks: json['delivery_remarks'] as String?,
      deliveryImages: (json['delivery_images'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      returnReason: json['return_reason'] as String?,
      deliveryItems: _parseDeliveryItems(json['delivery_items']),
      createdAt: _parseDate(json['created_at']),
      updatedAt: _parseDate(json['updated_at']),
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
    this.orderItemId,
    this.quantityPickedUp,
    this.quantityDelivered,
    this.quantityReturned,
  });

  /// Parse quantity from either 'quantity' (int) or 'quantity_delivered' / 'quantity_picked_up' (string or int).
  static int? _parseQuantity(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    if (value is num) return value.toInt();
    return null;
  }

  factory DeliveryItemModel.fromJson(Map<String, dynamic> json) {
    // Prefer quantity_picked_up so "Picked up" shows correctly when backend sends only quantity_picked_up/quantity_delivered.
    final quantity =
        _parseQuantity(json['quantity']) ??
        _parseQuantity(json['quantity_picked_up']) ??
        _parseQuantity(json['quantity_delivered']);
    return DeliveryItemModel(
      id: json['id'] as int,
      deliveryId: json['delivery_id'] as int?,
      productId: json['product_id'] as int?,
      productName: json['product_name'] as String?,
      quantity: quantity,
      status: json['status'] as String?,
      orderItemId: json['order_item_id'] as int?,
      quantityPickedUp: _parseQuantity(json['quantity_picked_up']),
      quantityDelivered: _parseQuantity(json['quantity_delivered']),
      quantityReturned: _parseQuantity(json['quantity_returned']),
    );
  }

  final int id;
  final int? deliveryId;
  final int? productId;
  final String? productName;
  final int? quantity;
  final String? status;
  final int? orderItemId;
  final int? quantityPickedUp;
  final int? quantityDelivered;
  final int? quantityReturned;
}
