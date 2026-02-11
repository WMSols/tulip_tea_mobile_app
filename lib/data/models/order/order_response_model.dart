import 'package:tulip_tea_mobile_app/domain/entities/order_entity.dart';

/// Response for GET/POST orders (OrderResponse schema).
class OrderResponseModel {
  OrderResponseModel({
    required this.id,
    this.shopId,
    this.shopName,
    this.orderBookerId,
    this.orderBookerName,
    this.distributorId,
    this.deliveryManId,
    this.deliveryManName,
    this.orderItems,
    this.scheduledDate,
    this.visitId,
    this.status,
    this.createdAt,
  });

  factory OrderResponseModel.fromJson(Map<String, dynamic> json) {
    List<OrderItem>? items;
    if (json['order_items'] != null) {
      final list = json['order_items'] as List<dynamic>;
      items = list.map((e) {
        final m = e as Map<String, dynamic>;
        return OrderItem(
          id: m['id'] as int?,
          orderId: m['order_id'] as int?,
          productName: m['product_name'] as String?,
          quantity: m['quantity'] as int?,
          unitPrice: (m['unit_price'] as num?)?.toDouble(),
          totalPrice: (m['total_price'] as num?)?.toDouble(),
        );
      }).toList();
    }
    return OrderResponseModel(
      id: json['id'] as int,
      shopId: json['shop_id'] as int?,
      shopName: json['shop_name'] as String?,
      orderBookerId: json['order_booker_id'] as int?,
      orderBookerName: json['order_booker_name'] as String?,
      distributorId: json['distributor_id'] as int?,
      deliveryManId: json['delivery_man_id'] as int?,
      deliveryManName: json['delivery_man_name'] as String?,
      orderItems: items,
      scheduledDate: json['scheduled_date'] as String?,
      visitId: json['visit_id'] as int?,
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
    );
  }

  final int id;
  final int? shopId;
  final String? shopName;
  final int? orderBookerId;
  final String? orderBookerName;
  final int? distributorId;
  final int? deliveryManId;
  final String? deliveryManName;
  final List<OrderItem>? orderItems;
  final String? scheduledDate;
  final int? visitId;
  final String? status;
  final String? createdAt;

  OrderEntity toEntity() => OrderEntity(
    id: id,
    shopId: shopId ?? 0,
    orderItems: orderItems,
    scheduledDate: scheduledDate,
    visitId: visitId,
    status: status,
    createdAt: createdAt,
  );
}
