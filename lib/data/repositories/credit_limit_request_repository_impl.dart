import 'package:tulip_tea_order_booker/core/network/api_exceptions.dart';
import 'package:tulip_tea_order_booker/domain/entities/credit_limit_request.dart';
import 'package:tulip_tea_order_booker/domain/repositories/credit_limit_request_repository.dart';
import 'package:tulip_tea_order_booker/data/data_sources/remote/credit_limit_requests_api.dart';
import 'package:tulip_tea_order_booker/data/models/credit_limit_request/credit_limit_request_create.dart';

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
  Future<List<CreditLimitRequest>> getAllRequests() async {
    try {
      final list = await _api.getAllRequests();
      return list.map((e) => e.toEntity()).toList();
    } catch (e, st) {
      final failure = ApiExceptions.handle<List<CreditLimitRequest>>(e, st);
      throw Exception(failure.message);
    }
  }
}
