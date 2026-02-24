import 'package:dio/dio.dart';

import 'package:tulip_tea_mobile_app/core/constants/api_constants.dart';
import 'package:tulip_tea_mobile_app/core/network/dio_client.dart';
import 'package:tulip_tea_mobile_app/data/models/credit_limit_request/credit_limit_request_create.dart';
import 'package:tulip_tea_mobile_app/data/models/credit_limit_request/credit_limit_request_response_model.dart';
import 'package:tulip_tea_mobile_app/data/models/credit_limit_request/credit_limit_request_update.dart';

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

  /// Get all credit limit requests for this order booker.
  /// Backend: GET /credit-limit-requests/order-booker/{order_booker_id}/my-requests
  /// Returns all requests (pending, disapproved, soft-deleted; excludes approved). No filtering needed.
  Future<List<CreditLimitRequestResponseModel>> getMyRequestsByOrderBooker(
    int orderBookerId,
  ) async {
    final res = await _dio.get<List<dynamic>>(
      ApiConstants.creditLimitRequestsMyRequests(orderBookerId),
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

  /// Resubmit a disapproved credit limit request (order booker).
  /// Backend: PUT /credit-limit-requests/{request_id}/resubmit
  /// Body: requested_credit_limit, remarks. Backend ensures request is disapproved.
  Future<CreditLimitRequestResponseModel> resubmitRequest(
    int requestId,
    CreditLimitRequestUpdate body,
  ) async {
    final res = await _dio.put<Map<String, dynamic>>(
      ApiConstants.creditLimitRequestResubmit(requestId),
      data: body.toJson(),
    );
    return CreditLimitRequestResponseModel.fromJson(res.data!);
  }
}
