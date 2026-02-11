import 'package:dio/dio.dart';

import 'package:tulip_tea_mobile_app/core/constants/api_constants.dart';
import 'package:tulip_tea_mobile_app/core/network/dio_client.dart';
import 'package:tulip_tea_mobile_app/data/models/shop/shop_register_request.dart';
import 'package:tulip_tea_mobile_app/data/models/shop/shop_response_model.dart';

class ShopsApi {
  ShopsApi() : _dio = DioClient.instance;

  final Dio _dio;

  Future<ShopResponseModel> registerShop(
    int orderBookerId,
    ShopRegisterRequest request,
  ) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '${ApiConstants.shopsByOrderBooker}/$orderBookerId',
      data: request.toJson(),
    );
    return ShopResponseModel.fromJson(res.data!);
  }

  Future<List<ShopResponseModel>> getShopsByOrderBooker(
    int orderBookerId, {
    bool approvedOnly = false,
  }) async {
    final res = await _dio.get<List<dynamic>>(
      '${ApiConstants.shopsByOrderBooker}/$orderBookerId',
      queryParameters: approvedOnly ? {'approved_only': true} : null,
    );
    final list = res.data ?? [];
    return list
        .map((e) => ShopResponseModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<ShopResponseModel> resubmitRejectedShop(
    int shopId,
    ShopRegisterRequest request,
  ) async {
    final res = await _dio.put<Map<String, dynamic>>(
      ApiConstants.shopResubmit(shopId),
      data: request.toJson(),
    );
    return ShopResponseModel.fromJson(res.data!);
  }
}
