import 'package:dio/dio.dart';

import 'package:tulip_tea_order_booker/core/constants/api_constants.dart';
import 'package:tulip_tea_order_booker/core/network/dio_client.dart';
import 'package:tulip_tea_order_booker/data/models/daily_collection/daily_collection_create.dart';
import 'package:tulip_tea_order_booker/data/models/daily_collection/daily_collection_response_model.dart';

class DailyCollectionsApi {
  DailyCollectionsApi() : _dio = DioClient.instance;

  final Dio _dio;

  Future<DailyCollectionResponseModel> submitCollection(
    int orderBookerId,
    DailyCollectionCreate request,
  ) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '${ApiConstants.dailyCollectionsByOrderBooker}/$orderBookerId',
      data: request.toJson(),
    );
    return DailyCollectionResponseModel.fromJson(res.data!);
  }

  Future<List<DailyCollectionResponseModel>> getCollectionsByOrderBooker(
    int orderBookerId,
  ) async {
    final res = await _dio.get<List<dynamic>>(
      '${ApiConstants.dailyCollectionsByOrderBooker}/$orderBookerId',
    );
    final list = res.data ?? [];
    return list
        .map(
          (e) =>
              DailyCollectionResponseModel.fromJson(e as Map<String, dynamic>),
        )
        .toList();
  }
}
