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

  Future<List<CreditLimitRequest>> getMyRequestsByOrderBooker(
    int orderBookerId,
  ) => _repo.getMyRequestsByOrderBooker(orderBookerId);

  /// Resubmit a disapproved credit limit request.
  /// Backend: PUT /credit-limit-requests/{request_id}/resubmit
  Future<CreditLimitRequest> updateRequest(
    int requestId, {
    required double requestedCreditLimit,
    String? remarks,
  }) => _repo.updateRequest(
        requestId,
        requestedCreditLimit: requestedCreditLimit,
        remarks: remarks,
      );
}
