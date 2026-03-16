import 'package:tulip_tea_mobile_app/domain/entities/order_entity.dart';
import 'package:tulip_tea_mobile_app/domain/entities/order_for_delivery_man.dart';

/// Order plus nested delivery from GET /orders/delivery-man/{id}. [delivery] is data-layer type (DeliveryModel), cast when using.
class OrderWithDelivery {
  const OrderWithDelivery({required this.order, this.delivery});
  final OrderForDeliveryMan order;
  final Object? delivery;
}

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
  Future<List<OrderForDeliveryMan>> getOrdersByDeliveryMan(int deliveryManId);

  /// Pending/active orders with delivery embedded (GET ...?pending=true). Use for Orders tab.
  Future<List<OrderWithDelivery>> getPendingOrdersWithDeliveryByDeliveryMan(
    int deliveryManId,
  );

  /// Orders with nested delivery in one call (GET ...?deliveries=true). Use for Deliveries tab.
  Future<List<OrderWithDelivery>> getOrdersWithDeliveriesByDeliveryMan(
    int deliveryManId,
  );

  Future<OrderForDeliveryMan?> getOrderById(int orderId);
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
