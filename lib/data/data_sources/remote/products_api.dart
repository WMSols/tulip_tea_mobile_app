import 'package:dio/dio.dart';

import 'package:tulip_tea_mobile_app/core/constants/api_constants.dart';
import 'package:tulip_tea_mobile_app/core/network/dio_client.dart';
import 'package:tulip_tea_mobile_app/data/models/product/product_model.dart';

class ProductsApi {
  ProductsApi() : _dio = DioClient.instance;

  final Dio _dio;

  /// [distributorId] required for Order Bookers (GET /products/active?distributor_id=X).
  Future<List<ProductModel>> getActiveProducts({int? distributorId}) async {
    final res = await _dio.get<List<dynamic>>(
      ApiConstants.productsActive,
      queryParameters: distributorId != null
          ? {'distributor_id': distributorId}
          : null,
    );
    final list = res.data ?? [];
    return list
        .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
