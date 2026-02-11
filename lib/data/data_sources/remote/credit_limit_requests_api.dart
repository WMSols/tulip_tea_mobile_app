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

  /// List credit limit requests for this order booker.
  /// Backend must support GET on the same path as POST (create).
  /// Create: POST /credit-limit-requests/order-booker/{order_booker_id}.
  Future<List<CreditLimitRequestResponseModel>> getRequestsByOrderBooker(
    int orderBookerId,
  ) async {
    final res = await _dio.get<List<dynamic>>(
      '${ApiConstants.creditLimitRequestsByOrderBooker}/$orderBookerId',
    );
    final list = res.data ?? [];
    return list
        .map(
          (e) => CreditLimitRequestResponseModel.fromJson(
            e as Map<String, dynamic>,
          ),
        )
        .toList();
  }
}
