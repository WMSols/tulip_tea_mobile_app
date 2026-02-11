import 'package:dio/dio.dart';

import 'package:tulip_tea_mobile_app/core/constants/api_constants.dart';
import 'package:tulip_tea_mobile_app/core/constants/app_constants.dart';
import 'package:tulip_tea_mobile_app/core/network/dio_client.dart';
import 'package:tulip_tea_mobile_app/data/models/shop_visit/shop_visit_create.dart';
import 'package:tulip_tea_mobile_app/data/models/shop_visit/shop_visit_response_model.dart';

class ShopVisitsApi {
  ShopVisitsApi() : _dio = DioClient.instance;

  final Dio _dio;

  Future<ShopVisitResponseModel> registerVisit(
    int orderBookerId,
    ShopVisitCreate request,
  ) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '${ApiConstants.shopVisitsByOrderBooker}/$orderBookerId',
      data: request.toJson(),
    );
    return ShopVisitResponseModel.fromJson(res.data!);
  }

  Future<List<ShopVisitResponseModel>> getVisitsByOrderBooker(
    int orderBookerId, {
    int skip = 0,
    int limit = AppConstants.visitHistoryPageSize,
  }) async {
    final res = await _dio.get<List<dynamic>>(
      '${ApiConstants.shopVisitsByOrderBooker}/$orderBookerId',
      queryParameters: {'skip': skip, 'limit': limit},
    );
    final list = res.data ?? [];
    return list
        .map((e) => ShopVisitResponseModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
