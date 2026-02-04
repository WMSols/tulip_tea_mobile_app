import 'package:dio/dio.dart';

import 'package:tulip_tea_order_booker/core/constants/api_constants.dart';
import 'package:tulip_tea_order_booker/core/network/dio_client.dart';
import 'package:tulip_tea_order_booker/data/models/product/product_model.dart';

class ProductsApi {
  ProductsApi() : _dio = DioClient.instance;

  final Dio _dio;

  Future<List<ProductModel>> getActiveProducts() async {
    final res = await _dio.get<List<dynamic>>(ApiConstants.productsActive);
    final list = res.data ?? [];
    return list
        .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
