import 'package:dio/dio.dart';

import 'package:tulip_tea_mobile_app/core/constants/api_constants.dart';
import 'package:tulip_tea_mobile_app/core/network/dio_client.dart';
import 'package:tulip_tea_mobile_app/data/models/daily_collection/daily_collection_create.dart';
import 'package:tulip_tea_mobile_app/data/models/daily_collection/daily_collection_response_model.dart';

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

  /// POST /daily-collections/delivery-man/{delivery_man_id}
  Future<DailyCollectionResponseModel> submitCollectionByDeliveryMan(
    int deliveryManId,
    DailyCollectionCreate request,
  ) async {
    final res = await _dio.post<Map<String, dynamic>>(
      ApiConstants.dailyCollectionsByDeliveryMan(deliveryManId),
      data: request.toJson(),
    );
    return DailyCollectionResponseModel.fromJson(res.data!);
  }

  /// GET /daily-collections/delivery-man/{delivery_man_id}
  Future<List<DailyCollectionResponseModel>> getCollectionsByDeliveryMan(
    int deliveryManId,
  ) async {
    final res = await _dio.get<List<dynamic>>(
      ApiConstants.dailyCollectionsByDeliveryMan(deliveryManId),
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
