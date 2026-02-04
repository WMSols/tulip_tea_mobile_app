import 'package:tulip_tea_order_booker/domain/entities/order_entity.dart';

abstract class OrderRepository {
  Future<OrderEntity> createOrder({
    required int orderBookerId,
    required int shopId,
    required List<OrderItemInput> orderItems,
    String? scheduledDate,
    int? visitId,
  });
  Future<List<OrderEntity>> getOrdersByOrderBooker(int orderBookerId);
}

class OrderItemInput {
  const OrderItemInput({
    required this.productName,
    required this.quantity,
    required this.unitPrice,
  });
  final String productName;
  final int quantity;
  final double unitPrice;
}
