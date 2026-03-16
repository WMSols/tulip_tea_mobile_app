import 'package:tulip_tea_mobile_app/data/models/delivery/delivery_model.dart';
import 'package:tulip_tea_mobile_app/domain/entities/order_entity.dart';

/// Response for GET/POST orders (OrderResponse schema).
/// GET /orders/delivery-man/{id} returns each order with nested "delivery" (full delivery + delivery_items, dates).
class OrderResponseModel {
  OrderResponseModel({
    required this.id,
    this.shopId,
    this.shopName,
    this.orderBookerId,
    this.orderBookerName,
    this.distributorId,
    this.deliveryManId,
    this.deliveryManName,
    this.orderItems,
    this.scheduledDate,
    this.visitId,
    this.status,
    this.createdAt,
    // Delivery Man specific fields
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
    this.delivery,
  });

  /// Nested delivery from API (GET /orders/delivery-man/{id}) – has delivery_items, pickup_date, etc.
  final DeliveryModel? delivery;

  factory OrderResponseModel.fromJson(Map<String, dynamic> json) {
    List<OrderItem>? items;
    if (json['order_items'] != null) {
      final list = json['order_items'] as List<dynamic>;
      items = list.map((e) {
        final m = e as Map<String, dynamic>;
        return OrderItem(
          id: m['id'] as int?,
          orderId: m['order_id'] as int?,
          productName: m['product_name'] as String?,
          quantity: m['quantity'] as int?,
          unitPrice: (m['unit_price'] as num?)?.toDouble(),
          totalPrice: (m['total_price'] as num?)?.toDouble(),
        );
      }).toList();
    }

    SubsidyInfo? subsidyInfo;
    if (json['subsidy_info'] != null) {
      final m = json['subsidy_info'] as Map<String, dynamic>;
      subsidyInfo = SubsidyInfo(
        id: m['id'] as int?,
        name: m['name'] as String?,
        percentage: (m['percentage'] as num?)?.toDouble(),
      );
    }

    return OrderResponseModel(
      id: json['id'] as int,
      shopId: json['shop_id'] as int?,
      shopName: json['shop_name'] as String?,
      orderBookerId: json['order_booker_id'] as int?,
      orderBookerName: json['order_booker_name'] as String?,
      distributorId: json['distributor_id'] as int?,
      deliveryManId: json['delivery_man_id'] as int?,
      deliveryManName: json['delivery_man_name'] as String?,
      orderItems: items,
      scheduledDate: json['scheduled_date'] as String?,
      visitId: json['visit_id'] as int?,
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
      // Delivery Man specific fields
      totalAmount: (json['total_amount'] as num?)?.toDouble(),
      calculatedTotalAmount: (json['calculated_total_amount'] as num?)
          ?.toDouble(),
      finalTotalAmount: (json['final_total_amount'] as num?)?.toDouble(),
      deliveryRemarks: json['delivery_remarks'] as String?,
      deliveryImages: (json['delivery_images'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      subsidyStatus: json['subsidy_status'] as String?,
      subsidyApprovedBy: json['subsidy_approved_by'] as int?,
      subsidyApprovedAt: json['subsidy_approved_at'] as String?,
      subsidyRejectionReason: json['subsidy_rejection_reason'] as String?,
      orderResolutionType: json['order_resolution_type'] as String?,
      subsidyId: json['subsidy_id'] as int?,
      subsidyInfo: subsidyInfo,
      originalAmount: (json['original_amount'] as num?)?.toDouble(),
      paymentCollectedBeforeDelivery:
          json['payment_collected_before_delivery'] as bool?,
      paymentCollectedAmount: (json['payment_collected_amount'] as num?)
          ?.toDouble(),
      paymentCollectedAt: json['payment_collected_at'] as String?,
      shopAddress: json['shop_address'] as String?,
      shopOwner: json['shop_owner'] as String?,
      shopPhone: json['shop_phone'] as String?,
      delivery:
          json['delivery'] != null && json['delivery'] is Map<String, dynamic>
          ? DeliveryModel.fromJson(json['delivery'] as Map<String, dynamic>)
          : null,
    );
  }

  final int id;
  final int? shopId;
  final String? shopName;
  final int? orderBookerId;
  final String? orderBookerName;
  final int? distributorId;
  final int? deliveryManId;
  final String? deliveryManName;
  final List<OrderItem>? orderItems;
  final String? scheduledDate;
  final int? visitId;
  final String? status;
  final String? createdAt;
  // Delivery Man specific fields
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
  final SubsidyInfo? subsidyInfo;
  final double? originalAmount;
  final bool? paymentCollectedBeforeDelivery;
  final double? paymentCollectedAmount;
  final String? paymentCollectedAt;
  final String? shopAddress;
  final String? shopOwner;
  final String? shopPhone;

  OrderEntity toEntity() => OrderEntity(
    id: id,
    shopId: shopId ?? 0,
    orderItems: orderItems,
    scheduledDate: scheduledDate,
    visitId: visitId,
    status: status,
    createdAt: createdAt,
  );
}

class SubsidyInfo {
  SubsidyInfo({this.id, this.name, this.percentage});

  final int? id;
  final String? name;
  final double? percentage;
}
