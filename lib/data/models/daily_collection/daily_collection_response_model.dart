import 'package:tulip_tea_order_booker/domain/entities/daily_collection.dart';

class DailyCollectionResponseModel {
  DailyCollectionResponseModel({
    required this.id,
    this.shopId,
    this.shopName,
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
      amount: (json['amount'] as num).toDouble(),
      status: json['status'] as String?,
      collectionDate: json['collection_date'] as String?,
      remarks: json['remarks'] as String?,
    );
  }

  final int id;
  final int? shopId;
  final String? shopName;
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
