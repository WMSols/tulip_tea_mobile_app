import 'package:tulip_tea_order_booker/domain/entities/credit_limit_request.dart';

class CreditLimitRequestResponseModel {
  CreditLimitRequestResponseModel({
    required this.id,
    required this.shopId,
    this.shopName,
    this.shopOwner,
    required this.requestedById,
    this.requestedByName,
    this.oldCreditLimit,
    required this.requestedCreditLimit,
    this.status,
    this.approvedAt,
    this.remarks,
    this.createdAt,
  });

  factory CreditLimitRequestResponseModel.fromJson(Map<String, dynamic> json) {
    return CreditLimitRequestResponseModel(
      id: json['id'] as int,
      shopId: json['shop_id'] as int,
      shopName: json['shop_name'] as String?,
      shopOwner: json['shop_owner'] as String?,
      requestedById: json['requested_by_id'] as int,
      requestedByName: json['requested_by_name'] as String?,
      oldCreditLimit: (json['old_credit_limit'] as num?)?.toDouble(),
      requestedCreditLimit: (json['requested_credit_limit'] as num).toDouble(),
      status: json['status'] as String?,
      approvedAt: json['approved_at'] as String?,
      remarks: json['remarks'] as String?,
      createdAt: json['created_at'] as String?,
    );
  }

  final int id;
  final int shopId;
  final String? shopName;
  final String? shopOwner;
  final int requestedById;
  final String? requestedByName;
  final double? oldCreditLimit;
  final double requestedCreditLimit;
  final String? status;
  final String? approvedAt;
  final String? remarks;
  final String? createdAt;

  CreditLimitRequest toEntity() => CreditLimitRequest(
    id: id,
    shopId: shopId,
    shopName: shopName,
    shopOwner: shopOwner,
    requestedById: requestedById,
    requestedByName: requestedByName,
    oldCreditLimit: oldCreditLimit,
    requestedCreditLimit: requestedCreditLimit,
    status: status,
    approvedAt: approvedAt,
    remarks: remarks,
    createdAt: createdAt,
  );
}
