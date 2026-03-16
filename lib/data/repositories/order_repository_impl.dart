import 'package:tulip_tea_mobile_app/core/network/api_exceptions.dart';
import 'package:tulip_tea_mobile_app/domain/entities/order_entity.dart';
import 'package:tulip_tea_mobile_app/domain/entities/order_for_delivery_man.dart';
import 'package:tulip_tea_mobile_app/domain/repositories/order_repository.dart';
import 'package:tulip_tea_mobile_app/data/data_sources/remote/orders_api.dart';
import 'package:tulip_tea_mobile_app/data/models/order/order_create_request.dart';
import 'package:tulip_tea_mobile_app/data/models/order/order_response_model.dart';

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

  @override
  Future<List<OrderForDeliveryMan>> getOrdersByDeliveryMan(
    int deliveryManId,
  ) async {
    try {
      final list = await _api.getOrdersByDeliveryMan(deliveryManId);
      return list.map(_modelToOrderForDeliveryMan).toList();
    } catch (e, st) {
      final failure = ApiExceptions.handle<List<OrderForDeliveryMan>>(e, st);
      throw Exception(failure.message);
    }
  }

  @override
  Future<List<OrderWithDelivery>> getPendingOrdersWithDeliveryByDeliveryMan(
    int deliveryManId,
  ) async {
    try {
      final list = await _api.getOrdersByDeliveryManPending(deliveryManId);
      return list
          .map(
            (m) => OrderWithDelivery(
              order: _modelToOrderForDeliveryMan(m),
              delivery: m.delivery,
            ),
          )
          .toList();
    } catch (e, st) {
      final failure = ApiExceptions.handle<List<OrderWithDelivery>>(e, st);
      throw Exception(failure.message);
    }
  }

  @override
  Future<List<OrderWithDelivery>> getOrdersWithDeliveriesByDeliveryMan(
    int deliveryManId,
  ) async {
    try {
      final list = await _api.getOrdersByDeliveryManDeliveries(deliveryManId);
      return list
          .map(
            (m) => OrderWithDelivery(
              order: _modelToOrderForDeliveryMan(m),
              delivery: m.delivery,
            ),
          )
          .toList();
    } catch (e, st) {
      final failure = ApiExceptions.handle<List<OrderWithDelivery>>(e, st);
      throw Exception(failure.message);
    }
  }

  @override
  Future<OrderForDeliveryMan?> getOrderById(int orderId) async {
    try {
      final model = await _api.getOrderById(orderId);
      return _modelToOrderForDeliveryMan(model);
    } catch (e, st) {
      final failure = ApiExceptions.handle<OrderForDeliveryMan?>(e, st);
      throw Exception(failure.message);
    }
  }

  static OrderForDeliveryMan _modelToOrderForDeliveryMan(OrderResponseModel m) {
    return OrderForDeliveryMan(
      id: m.id,
      shopId: m.shopId,
      shopName: m.shopName,
      orderBookerId: m.orderBookerId,
      orderBookerName: m.orderBookerName,
      deliveryManId: m.deliveryManId,
      deliveryManName: m.deliveryManName,
      orderItems: m.orderItems,
      scheduledDate: m.scheduledDate,
      visitId: m.visitId,
      status: m.status,
      createdAt: m.createdAt,
      totalAmount: m.totalAmount,
      calculatedTotalAmount: m.calculatedTotalAmount,
      finalTotalAmount: m.finalTotalAmount,
      deliveryRemarks: m.deliveryRemarks,
      deliveryImages: m.deliveryImages,
      subsidyStatus: m.subsidyStatus,
      subsidyApprovedBy: m.subsidyApprovedBy,
      subsidyApprovedAt: m.subsidyApprovedAt,
      subsidyRejectionReason: m.subsidyRejectionReason,
      orderResolutionType: m.orderResolutionType,
      subsidyId: m.subsidyId,
      subsidyInfo: m.subsidyInfo != null
          ? SubsidyInfoEntity(
              id: m.subsidyInfo!.id,
              name: m.subsidyInfo!.name,
              percentage: m.subsidyInfo!.percentage,
            )
          : null,
      originalAmount: m.originalAmount,
      paymentCollectedBeforeDelivery: m.paymentCollectedBeforeDelivery,
      paymentCollectedAmount: m.paymentCollectedAmount,
      paymentCollectedAt: m.paymentCollectedAt,
      shopAddress: m.shopAddress,
      shopOwner: m.shopOwner,
      shopPhone: m.shopPhone,
    );
  }
}
