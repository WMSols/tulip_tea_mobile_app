import 'package:dio/dio.dart';

import 'package:tulip_tea_mobile_app/core/constants/api_constants.dart';
import 'package:tulip_tea_mobile_app/core/network/dio_client.dart';
import 'package:tulip_tea_mobile_app/data/models/delivery/delivery_model.dart';

class DeliveriesApi {
  DeliveriesApi() : _dio = DioClient.instance;

  final Dio _dio;

  /// Create a delivery record for an order
  /// POST /deliveries/order/{order_id}
  Future<DeliveryModel> createDelivery({
    required int orderId,
    required int warehouseId,
  }) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/deliveries/order/$orderId',
      data: {'warehouse_id': warehouseId},
    );
    return DeliveryModel.fromJson(res.data!);
  }

  /// Get delivery by order ID
  /// GET /deliveries/order/{order_id}
  Future<DeliveryModel?> getDeliveryByOrder(int orderId) async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/deliveries/order/$orderId',
    );
    if (res.data == null) return null;
    return DeliveryModel.fromJson(res.data!);
  }

  /// Get all deliveries for a delivery man
  /// GET /deliveries/delivery-man/{delivery_man_id}
  Future<List<DeliveryModel>> getDeliveriesByDeliveryMan(
    int deliveryManId,
  ) async {
    final res = await _dio.get<List<dynamic>>(
      ApiConstants.deliveriesByDeliveryMan(deliveryManId),
    );
    final list = res.data ?? [];
    return list
        .map((e) => DeliveryModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// Record warehouse pickup
  /// POST /deliveries/{delivery_id}/pickup
  Future<DeliveryModel> pickupFromWarehouse({
    required int deliveryId,
    required Map<String, int> pickupQuantities,
    double? pickupGpsLat,
    double? pickupGpsLng,
  }) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/deliveries/$deliveryId/pickup',
      data: {
        'pickup_quantities': pickupQuantities,
        'pickup_gps_lat': pickupGpsLat,
        'pickup_gps_lng': pickupGpsLng,
      },
    );
    return DeliveryModel.fromJson(res.data!);
  }

  /// Record shop delivery
  /// POST /deliveries/{delivery_id}/deliver
  Future<DeliveryModel> deliverToShop({
    required int deliveryId,
    required Map<String, int> deliveryQuantities,
    double? deliveryGpsLat,
    double? deliveryGpsLng,
    String? deliveryRemarks,
    List<String>? deliveryImages,
  }) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/deliveries/$deliveryId/deliver',
      data: {
        'delivery_quantities': deliveryQuantities,
        'delivery_gps_lat': deliveryGpsLat,
        'delivery_gps_lng': deliveryGpsLng,
        'delivery_remarks': deliveryRemarks,
        'delivery_images': deliveryImages,
      },
    );
    return DeliveryModel.fromJson(res.data!);
  }

  /// Record return to warehouse
  /// POST /deliveries/{delivery_id}/return
  Future<DeliveryModel> returnToWarehouse({
    required int deliveryId,
    required Map<String, int> returnQuantities,
    double? returnGpsLat,
    double? returnGpsLng,
    String? returnReason,
  }) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/deliveries/$deliveryId/return',
      data: {
        'return_quantities': returnQuantities,
        'return_gps_lat': returnGpsLat,
        'return_gps_lng': returnGpsLng,
        'return_reason': returnReason,
      },
    );
    return DeliveryModel.fromJson(res.data!);
  }

  /// Mark order as delivered or disapproved
  /// PUT /orders/{order_id}/deliver
  Future<Map<String, dynamic>> deliverOrder({
    required int orderId,
    required String status,
    double? deliveryGpsLat,
    double? deliveryGpsLng,
    String? deliveryRemarks,
    List<String>? deliveryImages,
  }) async {
    final res = await _dio.put<Map<String, dynamic>>(
      '/orders/$orderId/deliver',
      data: {
        'status': status,
        'delivery_gps_lat': deliveryGpsLat,
        'delivery_gps_lng': deliveryGpsLng,
        'delivery_remarks': deliveryRemarks,
        'delivery_images': deliveryImages,
      },
    );
    return res.data!;
  }
}
