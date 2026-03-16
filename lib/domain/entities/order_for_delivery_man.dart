import 'package:tulip_tea_mobile_app/domain/entities/order_entity.dart';

/// Order view for delivery man: full order details for list/detail and pickup/deliver flows.
class OrderForDeliveryMan {
  const OrderForDeliveryMan({
    required this.id,
    this.shopId,
    this.shopName,
    this.orderBookerId,
    this.orderBookerName,
    this.deliveryManId,
    this.deliveryManName,
    this.orderItems,
    this.scheduledDate,
    this.visitId,
    this.status,
    this.createdAt,
    this.totalAmount,
    this.calculatedTotalAmount,
    this.finalTotalAmount,
    this.deliveryRemarks,
    this.deliveryImages,
    this.subsidyStatus,
    this.subsidyApprovedBy,
    this.subsidyApprovedAt,
    this.subsidyRejectionReason,
    this.orderResolutionType,
    this.subsidyId,
    this.subsidyInfo,
    this.originalAmount,
    this.paymentCollectedBeforeDelivery,
    this.paymentCollectedAmount,
    this.paymentCollectedAt,
    this.shopAddress,
    this.shopOwner,
    this.shopPhone,
  });

  final int id;
  final int? shopId;
  final String? shopName;
  final int? orderBookerId;
  final String? orderBookerName;
  final int? deliveryManId;
  final String? deliveryManName;
  final List<OrderItem>? orderItems;
  final String? scheduledDate;
  final int? visitId;
  final String? status;
  final String? createdAt;
  final double? totalAmount;
  final double? calculatedTotalAmount;
  final double? finalTotalAmount;
  final String? deliveryRemarks;
  final List<String>? deliveryImages;
  final String? subsidyStatus;
  final int? subsidyApprovedBy;
  final String? subsidyApprovedAt;
  final String? subsidyRejectionReason;
  final String? orderResolutionType;
  final int? subsidyId;
  final SubsidyInfoEntity? subsidyInfo;
  final double? originalAmount;
  final bool? paymentCollectedBeforeDelivery;
  final double? paymentCollectedAmount;
  final String? paymentCollectedAt;
  final String? shopAddress;
  final String? shopOwner;
  final String? shopPhone;
}

class SubsidyInfoEntity {
  const SubsidyInfoEntity({this.id, this.name, this.percentage});
  final int? id;
  final String? name;
  final double? percentage;
}
