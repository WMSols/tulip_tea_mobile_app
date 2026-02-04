import 'package:tulip_tea_order_booker/domain/entities/order_entity.dart';

class OrderResponseModel {
  OrderResponseModel({
    required this.id,
    required this.shopId,
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
      items = list
          .map(
            (e) => OrderItem(
              productName: e['product_name'] as String,
              quantity: e['quantity'] as int,
              unitPrice: (e['unit_price'] as num).toDouble(),
            ),
          )
          .toList();
    }
    return OrderResponseModel(
      id: json['id'] as int,
      shopId: json['shop_id'] as int,
      orderItems: items,
      scheduledDate: json['scheduled_date'] as String?,
      visitId: json['visit_id'] as int?,
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
    );
  }

  final int id;
  final int shopId;
  final List<OrderItem>? orderItems;
  final String? scheduledDate;
  final int? visitId;
  final String? status;
  final String? createdAt;

  OrderEntity toEntity() => OrderEntity(
    id: id,
    shopId: shopId,
    orderItems: orderItems,
    scheduledDate: scheduledDate,
    visitId: visitId,
    status: status,
    createdAt: createdAt,
  );
}
