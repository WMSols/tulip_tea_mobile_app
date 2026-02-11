import 'package:tulip_tea_mobile_app/core/network/api_exceptions.dart';
import 'package:tulip_tea_mobile_app/domain/entities/order_entity.dart';
import 'package:tulip_tea_mobile_app/domain/repositories/order_repository.dart';
import 'package:tulip_tea_mobile_app/data/data_sources/remote/orders_api.dart';
import 'package:tulip_tea_mobile_app/data/models/order/order_create_request.dart';

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
    double? finalTotalAmount,
  }) async {
    try {
      final request = OrderCreateRequest(
        shopId: shopId,
        orderItems: orderItems
            .map(
              (e) => OrderItemRequest(
                productId: e.productId,
                productName: e.productName,
                quantity: e.quantity,
                unitPrice: e.unitPrice,
              ),
            )
            .toList(),
        scheduledDate: scheduledDate,
        visitId: visitId,
        finalTotalAmount: finalTotalAmount,
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
