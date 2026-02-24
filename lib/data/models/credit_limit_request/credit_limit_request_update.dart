/// Body for PUT /credit-limit-requests/{request_id} (update/re-request).
class CreditLimitRequestUpdate {
  CreditLimitRequestUpdate({
    required this.requestedCreditLimit,
    this.remarks,
  });

  final double requestedCreditLimit;
  final String? remarks;

  Map<String, dynamic> toJson() => {
    'requested_credit_limit': requestedCreditLimit,
    if (remarks != null && remarks!.trim().isNotEmpty) 'remarks': remarks!.trim(),
  };
}
