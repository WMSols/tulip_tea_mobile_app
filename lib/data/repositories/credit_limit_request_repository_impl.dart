import 'package:tulip_tea_mobile_app/core/network/api_exceptions.dart';
import 'package:tulip_tea_mobile_app/domain/entities/credit_limit_request.dart';
import 'package:tulip_tea_mobile_app/domain/repositories/credit_limit_request_repository.dart';
import 'package:tulip_tea_mobile_app/data/data_sources/remote/credit_limit_requests_api.dart';
import 'package:tulip_tea_mobile_app/data/models/credit_limit_request/credit_limit_request_create.dart';
import 'package:tulip_tea_mobile_app/data/models/credit_limit_request/credit_limit_request_update.dart';

class CreditLimitRequestRepositoryImpl implements CreditLimitRequestRepository {
  CreditLimitRequestRepositoryImpl(this._api);

  final CreditLimitRequestsApi _api;

  @override
  Future<CreditLimitRequest> createRequest({
    required int orderBookerId,
    required int shopId,
    required double requestedCreditLimit,
    String? remarks,
  }) async {
    try {
      final request = CreditLimitRequestCreate(
        shopId: shopId,
        requestedCreditLimit: requestedCreditLimit,
        remarks: remarks,
      );
      final model = await _api.createRequest(orderBookerId, request);
      return model.toEntity();
    } catch (e, st) {
      final failure = ApiExceptions.handle<CreditLimitRequest>(e, st);
      throw Exception(failure.message);
    }
  }

  @override
  Future<List<CreditLimitRequest>> getMyRequestsByOrderBooker(
    int orderBookerId,
  ) async {
    try {
      final list = await _api.getMyRequestsByOrderBooker(orderBookerId);
      return list.map((e) => e.toEntity()).toList();
    } catch (e, st) {
      final failure = ApiExceptions.handle<List<CreditLimitRequest>>(e, st);
      throw Exception(failure.message);
    }
  }

  @override
  Future<CreditLimitRequest> updateRequest(
    int requestId, {
    required double requestedCreditLimit,
    String? remarks,
  }) async {
    try {
      final body = CreditLimitRequestUpdate(
        requestedCreditLimit: requestedCreditLimit,
        remarks: remarks,
      );
      final model = await _api.resubmitRequest(requestId, body);
      return model.toEntity();
    } catch (e, st) {
      final failure = ApiExceptions.handle<CreditLimitRequest>(e, st);
      throw Exception(failure.message);
    }
  }
}
