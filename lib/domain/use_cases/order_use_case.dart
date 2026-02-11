import 'package:tulip_tea_mobile_app/domain/entities/order_entity.dart';
import 'package:tulip_tea_mobile_app/domain/repositories/order_repository.dart';

class OrderUseCase {
  OrderUseCase(this._repo);
  final OrderRepository _repo;

  Future<OrderEntity> createOrder({
    required int orderBookerId,
    required int shopId,
    required List<OrderItemInput> orderItems,
    String? scheduledDate,
    int? visitId,
    double? finalTotalAmount,
  }) => _repo.createOrder(
    orderBookerId: orderBookerId,
    shopId: shopId,
    orderItems: orderItems,
    scheduledDate: scheduledDate,
    visitId: visitId,
    finalTotalAmount: finalTotalAmount,
  );

  Future<List<OrderEntity>> getOrdersByOrderBooker(int orderBookerId) =>
      _repo.getOrdersByOrderBooker(orderBookerId);
}
