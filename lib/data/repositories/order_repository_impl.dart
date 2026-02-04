import 'package:tulip_tea_order_booker/core/network/api_exceptions.dart';
import 'package:tulip_tea_order_booker/domain/entities/order_entity.dart';
import 'package:tulip_tea_order_booker/domain/repositories/order_repository.dart';
import 'package:tulip_tea_order_booker/data/data_sources/remote/orders_api.dart';
import 'package:tulip_tea_order_booker/data/models/order/order_create_request.dart';

class OrderRepositoryImpl implements OrderRepository {
  OrderRepositoryImpl(this._api);

  final OrdersApi _api;

  @override
  Future<OrderEntity> createOrder({
    required int orderBookerId,
    required int shopId,
    required List<OrderItemInput> orderItems,
    String? scheduledDate,
    int? visitId,
  }) async {
    try {
      final request = OrderCreateRequest(
        shopId: shopId,
        orderItems: orderItems
            .map(
              (e) => OrderItemRequest(
                productName: e.productName,
                quantity: e.quantity,
                unitPrice: e.unitPrice,
              ),
            )
            .toList(),
        scheduledDate: scheduledDate,
        visitId: visitId,
      );
      final model = await _api.createOrder(orderBookerId, request);
      return model.toEntity();
    } catch (e, st) {
      final failure = ApiExceptions.handle<OrderEntity>(e, st);
      throw Exception(failure.message);
    }
  }

  @override
  Future<List<OrderEntity>> getOrdersByOrderBooker(int orderBookerId) async {
    try {
      final list = await _api.getOrdersByOrderBooker(orderBookerId);
      return list.map((e) => e.toEntity()).toList();
    } catch (e, st) {
      final failure = ApiExceptions.handle<List<OrderEntity>>(e, st);
      throw Exception(failure.message);
    }
  }
}
