import 'package:tulip_tea_mobile_app/domain/entities/shop_credit_info.dart';

/// Response for GET /shops/{shop_id}/credit-info
class ShopCreditInfoModel {
  ShopCreditInfoModel({
    required this.shopId,
    this.shopName,
    this.creditLimit,
    this.outstandingBalance,
    this.totalOutstanding,
    this.availableCredit,
  });

  factory ShopCreditInfoModel.fromJson(Map<String, dynamic> json) {
    return ShopCreditInfoModel(
      shopId: json['shop_id'] as int,
      shopName: json['shop_name'] as String?,
      creditLimit: (json['credit_limit'] as num?)?.toDouble(),
      outstandingBalance: (json['outstanding_balance'] as num?)?.toDouble(),
      totalOutstanding: (json['total_outstanding'] as num?)?.toDouble(),
      availableCredit: (json['available_credit'] as num?)?.toDouble(),
    );
  }

  final int shopId;
  final String? shopName;
  final double? creditLimit;
  final double? outstandingBalance;
  final double? totalOutstanding;
  final double? availableCredit;

  ShopCreditInfo toEntity() => ShopCreditInfo(
        shopId: shopId,
        shopName: shopName,
        creditLimit: creditLimit,
        outstandingBalance: outstandingBalance ?? totalOutstanding,
        availableCredit: availableCredit,
      );
}
