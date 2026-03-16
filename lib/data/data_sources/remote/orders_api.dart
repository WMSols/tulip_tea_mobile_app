import 'package:dio/dio.dart';

import 'package:tulip_tea_mobile_app/core/constants/api_constants.dart';
import 'package:tulip_tea_mobile_app/core/network/dio_client.dart';
import 'package:tulip_tea_mobile_app/data/models/order/order_create_request.dart';
import 'package:tulip_tea_mobile_app/data/models/order/order_response_model.dart';

class OrdersApi {
  OrdersApi() : _dio = DioClient.instance;

  final Dio _dio;

  Future<OrderResponseModel> createOrder(
    int orderBookerId,
    OrderCreateRequest request,
  ) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '${ApiConstants.ordersByOrderBooker}/$orderBookerId',
      data: request.toJson(),
    );
    return OrderResponseModel.fromJson(res.data!);
  }

  Future<List<OrderResponseModel>> getOrdersByOrderBooker(
    int orderBookerId,
  ) async {
    final res = await _dio.get<List<dynamic>>(
      '${ApiConstants.ordersByOrderBooker}/$orderBookerId',
    );
    final list = res.data ?? [];
    return list
        .map((e) => OrderResponseModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// GET /orders/delivery-man/{id} — list orders assigned to delivery man
  Future<List<OrderResponseModel>> getOrdersByDeliveryMan(
    int deliveryManId,
  ) async {
    final res = await _dio.get<List<dynamic>>(
      ApiConstants.ordersByDeliveryMan(deliveryManId),
    );
    final list = res.data ?? [];
    return list
        .map((e) => OrderResponseModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// GET /orders/delivery-man/{id}?pending=true — pending/active orders with delivery embedded
  Future<List<OrderResponseModel>> getOrdersByDeliveryManPending(
    int deliveryManId,
  ) async {
    final res = await _dio.get<List<dynamic>>(
      ApiConstants.ordersByDeliveryManPending(deliveryManId),
    );
    final list = res.data ?? [];
    return list
        .map((e) => OrderResponseModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// GET /orders/delivery-man/{id}?deliveries=true — deliveries-screen orders with full delivery
  Future<List<OrderResponseModel>> getOrdersByDeliveryManDeliveries(
    int deliveryManId,
  ) async {
    final res = await _dio.get<List<dynamic>>(
      ApiConstants.ordersByDeliveryManDeliveries(deliveryManId),
    );
    final list = res.data ?? [];
    return list
        .map((e) => OrderResponseModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// GET /orders/{id} — single order by ID
  Future<OrderResponseModel> getOrderById(int orderId) async {
    final res = await _dio.get<Map<String, dynamic>>(
      ApiConstants.orderById(orderId),
    );
    return OrderResponseModel.fromJson(res.data!);
  }
}
