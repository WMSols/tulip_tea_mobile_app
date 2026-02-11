import 'package:tulip_tea_mobile_app/domain/entities/daily_collection.dart';

/// Response for GET/POST daily collections (DailyCollectionResponse schema).
class DailyCollectionResponseModel {
  DailyCollectionResponseModel({
    required this.id,
    this.shopId,
    this.shopName,
    this.shopOwner,
    this.orderId,
    this.collectedByOrderBooker,
    this.orderBookerName,
    this.collectedByDeliveryMan,
    this.deliveryManName,
    required this.amount,
    this.status,
    this.collectionDate,
    this.remarks,
  });

  factory DailyCollectionResponseModel.fromJson(Map<String, dynamic> json) {
    return DailyCollectionResponseModel(
      id: json['id'] as int,
      shopId: json['shop_id'] as int?,
      shopName: json['shop_name'] as String?,
      shopOwner: json['shop_owner'] as String?,
      orderId: json['order_id'] as int?,
      collectedByOrderBooker: json['collected_by_order_booker'] as int?,
      orderBookerName: json['order_booker_name'] as String?,
      collectedByDeliveryMan: json['collected_by_delivery_man'] as int?,
      deliveryManName: json['delivery_man_name'] as String?,
      amount: (json['amount'] as num).toDouble(),
      status: json['status'] as String?,
      collectionDate: json['collection_date'] as String?,
      remarks: json['remarks'] as String?,
    );
  }

  final int id;
  final int? shopId;
  final String? shopName;
  final String? shopOwner;
  final int? orderId;
  final int? collectedByOrderBooker;
  final String? orderBookerName;
  final int? collectedByDeliveryMan;
  final String? deliveryManName;
  final double amount;
  final String? status;
  final String? collectionDate;
  final String? remarks;

  DailyCollection toEntity() => DailyCollection(
    id: id,
    shopId: shopId,
    shopName: shopName,
    amount: amount,
    status: status,
    collectionDate: collectionDate,
    remarks: remarks,
  );
}
