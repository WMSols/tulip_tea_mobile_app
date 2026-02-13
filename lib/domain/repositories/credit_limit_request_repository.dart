import 'package:tulip_tea_mobile_app/domain/entities/credit_limit_request.dart';

abstract class CreditLimitRequestRepository {
  Future<CreditLimitRequest> createRequest({
    required int orderBookerId,
    required int shopId,
    required double requestedCreditLimit,
    String? remarks,
  });

  /// List credit limit requests for the given order booker.
  /// [distributorId] is sent to backend (GET .../pending?distributor_id=X); result filtered by order booker.
  Future<List<CreditLimitRequest>> getRequestsByOrderBooker(
    int orderBookerId, {
    int? distributorId,
  });
}
