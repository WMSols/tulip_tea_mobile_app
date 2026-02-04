import 'package:tulip_tea_order_booker/domain/entities/credit_limit_request.dart';

abstract class CreditLimitRequestRepository {
  Future<CreditLimitRequest> createRequest({
    required int orderBookerId,
    required int shopId,
    required double requestedCreditLimit,
    String? remarks,
  });
  Future<List<CreditLimitRequest>> getAllRequests();
}
