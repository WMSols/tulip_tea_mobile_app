import 'package:tulip_tea_mobile_app/domain/entities/credit_limit_request.dart';

abstract class CreditLimitRequestRepository {
  Future<CreditLimitRequest> createRequest({
    required int orderBookerId,
    required int shopId,
    required double requestedCreditLimit,
    String? remarks,
  });

  /// Get all credit limit requests for the given order booker.
  /// Backend: GET /credit-limit-requests/order-booker/{order_booker_id}/my-requests (no filtering).
  Future<List<CreditLimitRequest>> getMyRequestsByOrderBooker(
    int orderBookerId,
  );

  /// Resubmit a disapproved credit limit request (order booker).
  /// Backend: PUT /credit-limit-requests/{request_id}/resubmit
  Future<CreditLimitRequest> updateRequest(
    int requestId, {
    required double requestedCreditLimit,
    String? remarks,
  });
}
