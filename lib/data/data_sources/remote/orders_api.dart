import 'package:dio/dio.dart';

import 'package:tulip_tea_order_booker/core/constants/api_constants.dart';
import 'package:tulip_tea_order_booker/core/network/dio_client.dart';
import 'package:tulip_tea_order_booker/data/models/order/order_create_request.dart';
import 'package:tulip_tea_order_booker/data/models/order/order_response_model.dart';

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
}
