class CollectPaymentRequest {
  const CollectPaymentRequest({required this.paymentAmount, this.remarks});

  final double paymentAmount;
  final String? remarks;

  Map<String, dynamic> toJson() => {
    'payment_amount': paymentAmount,
    if (remarks != null) 'remarks': remarks,
  };
}
