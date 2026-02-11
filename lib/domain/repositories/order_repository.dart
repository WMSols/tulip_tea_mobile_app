import 'package:tulip_tea_mobile_app/domain/entities/order_entity.dart';

abstract class OrderRepository {
  Future<OrderEntity> createOrder({
    required int orderBookerId,
    required int shopId,
    required List<OrderItemInput> orderItems,
    String? scheduledDate,
    int? visitId,
    double? finalTotalAmount,
  });
  Future<List<OrderEntity>> getOrdersByOrderBooker(int orderBookerId);
}

class OrderItemInput {
  const OrderItemInput({
    this.productId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
  });
  final int? productId;
  final String productName;
  final int quantity;
  final double unitPrice;
}
