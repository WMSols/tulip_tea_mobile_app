import 'package:tulip_tea_order_booker/domain/entities/credit_limit_request.dart';

/// Response for GET/POST credit-limit-requests (CreditLimitRequestResponse schema).
class CreditLimitRequestResponseModel {
  CreditLimitRequestResponseModel({
    required this.id,
    required this.shopId,
    this.shopName,
    this.requestedByRole,
    required this.requestedById,
    this.requestedByName,
    this.oldCreditLimit,
    required this.requestedCreditLimit,
    this.status,
    this.approvedByDistributor,
    this.approvedByDistributorName,
    this.remarks,
    this.createdAt,
  });

  factory CreditLimitRequestResponseModel.fromJson(Map<String, dynamic> json) {
    return CreditLimitRequestResponseModel(
      id: json['id'] as int,
      shopId: json['shop_id'] as int,
      shopName: json['shop_name'] as String?,
      requestedByRole: json['requested_by_role'] as String?,
      requestedById: json['requested_by_id'] as int,
      requestedByName: json['requested_by_name'] as String?,
      oldCreditLimit: (json['old_credit_limit'] as num?)?.toDouble(),
      requestedCreditLimit: (json['requested_credit_limit'] as num).toDouble(),
      status: json['status'] as String?,
      approvedByDistributor: json['approved_by_distributor'] as int?,
      approvedByDistributorName:
          json['approved_by_distributor_name'] as String?,
      remarks: json['remarks'] as String?,
      createdAt: json['created_at'] as String?,
    );
  }

  final int id;
  final int shopId;
  final String? shopName;
  final String? requestedByRole;
  final int requestedById;
  final String? requestedByName;
  final double? oldCreditLimit;
  final double requestedCreditLimit;
  final String? status;
  final int? approvedByDistributor;
  final String? approvedByDistributorName;
  final String? remarks;
  final String? createdAt;

  CreditLimitRequest toEntity() => CreditLimitRequest(
    id: id,
    shopId: shopId,
    shopName: shopName,
    shopOwner: null,
    requestedById: requestedById,
    requestedByName: requestedByName,
    requestedByRole: requestedByRole,
    oldCreditLimit: oldCreditLimit,
    requestedCreditLimit: requestedCreditLimit,
    status: status,
    approvedAt: null,
    approvedByDistributorName: approvedByDistributorName,
    remarks: remarks,
    createdAt: createdAt,
  );
}
