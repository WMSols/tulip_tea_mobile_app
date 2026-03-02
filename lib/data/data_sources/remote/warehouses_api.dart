import 'package:dio/dio.dart';

import 'package:tulip_tea_mobile_app/core/network/dio_client.dart';
import 'package:tulip_tea_mobile_app/data/models/warehouse/warehouse_model.dart';

class WarehousesApi {
  WarehousesApi() : _dio = DioClient.instance;

  final Dio _dio;

  /// Get all warehouses assigned to a delivery man
  /// GET /delivery-men/{delivery_man_id}/warehouses
  Future<List<WarehouseModel>> getWarehousesByDeliveryMan(
    int deliveryManId,
  ) async {
    final res = await _dio.get<List<dynamic>>(
      '/delivery-men/$deliveryManId/warehouses',
    );
    final list = res.data ?? [];
    return list
        .map((e) => WarehouseModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
