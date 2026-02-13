import 'package:dio/dio.dart';

import 'package:tulip_tea_mobile_app/core/constants/api_constants.dart';
import 'package:tulip_tea_mobile_app/core/network/dio_client.dart';
import 'package:tulip_tea_mobile_app/data/models/credit_limit_request/credit_limit_request_create.dart';
import 'package:tulip_tea_mobile_app/data/models/credit_limit_request/credit_limit_request_response_model.dart';

class CreditLimitRequestsApi {
  CreditLimitRequestsApi() : _dio = DioClient.instance;

  final Dio _dio;

  Future<CreditLimitRequestResponseModel> createRequest(
    int orderBookerId,
    CreditLimitRequestCreate request,
  ) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '${ApiConstants.creditLimitRequestsByOrderBooker}/$orderBookerId',
      data: request.toJson(),
    );
    return CreditLimitRequestResponseModel.fromJson(res.data!);
  }

  /// List pending credit limit requests for this order booker.
  /// Backend: GET /credit-limit-requests/pending?distributor_id=X — returns all pending for distributor.
  /// We filter by [orderBookerId] so "My Requests" shows only this order booker's.
  Future<List<CreditLimitRequestResponseModel>> getRequestsByOrderBooker(
    int orderBookerId, {
    int? distributorId,
  }) async {
    final res = await _dio.get<List<dynamic>>(
      ApiConstants.creditLimitRequestsPending,
      queryParameters: distributorId != null
          ? {'distributor_id': distributorId}
          : null,
    );
    final list = res.data ?? [];
    final models = list
        .map(
          (e) => CreditLimitRequestResponseModel.fromJson(
            e as Map<String, dynamic>,
          ),
        )
        .toList();
    return models
        .where((m) => m.requestedById == orderBookerId)
        .toList();
  }
}
