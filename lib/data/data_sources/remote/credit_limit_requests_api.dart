import 'package:dio/dio.dart';

import 'package:tulip_tea_order_booker/core/constants/api_constants.dart';
import 'package:tulip_tea_order_booker/core/network/dio_client.dart';
import 'package:tulip_tea_order_booker/data/models/credit_limit_request/credit_limit_request_create.dart';
import 'package:tulip_tea_order_booker/data/models/credit_limit_request/credit_limit_request_response_model.dart';

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

  Future<List<CreditLimitRequestResponseModel>> getAllRequests() async {
    final res = await _dio.get<List<dynamic>>(
      ApiConstants.creditLimitRequestsAll,
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
