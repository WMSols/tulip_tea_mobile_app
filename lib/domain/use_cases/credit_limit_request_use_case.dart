import 'package:tulip_tea_mobile_app/domain/entities/credit_limit_request.dart';
import 'package:tulip_tea_mobile_app/domain/repositories/credit_limit_request_repository.dart';

class CreditLimitRequestUseCase {
  CreditLimitRequestUseCase(this._repo);
  final CreditLimitRequestRepository _repo;

  Future<CreditLimitRequest> createRequest({
    required int orderBookerId,
    required int shopId,
    required double requestedCreditLimit,
    String? remarks,
  }) => _repo.createRequest(
    orderBookerId: orderBookerId,
    shopId: shopId,
    requestedCreditLimit: requestedCreditLimit,
    remarks: remarks,
  );

  Future<List<CreditLimitRequest>> getRequestsByOrderBooker(
    int orderBookerId, {
    int? distributorId,
  }) =>
      _repo.getRequestsByOrderBooker(orderBookerId, distributorId: distributorId);
}
