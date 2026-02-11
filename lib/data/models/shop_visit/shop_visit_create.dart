import 'package:tulip_tea_mobile_app/data/models/order/order_create_request.dart';

/// Request body for POST /shop-visits/order-booker/{order_booker_id} (ShopVisitCreate schema).
class ShopVisitCreate {
  ShopVisitCreate({
    this.shopId,
    this.visitTypes,
    this.gpsLat,
    this.gpsLng,
    this.visitTime,
    this.photo,
    this.reason,
    this.orderItems,
  });

  final int? shopId;
  final List<String>? visitTypes;
  final double? gpsLat;
  final double? gpsLng;
  final String? visitTime;
  final String? photo;
  final String? reason;
  final List<OrderItemRequest>? orderItems;

  Map<String, dynamic> toJson() => {
    if (shopId != null) 'shop_id': shopId,
    if (visitTypes != null) 'visit_types': visitTypes,
    if (gpsLat != null) 'gps_lat': gpsLat,
    if (gpsLng != null) 'gps_lng': gpsLng,
    if (visitTime != null) 'visit_time': visitTime,
    if (photo != null) 'photo': photo,
    if (reason != null) 'reason': reason,
    if (orderItems != null)
      'order_items': orderItems!.map((e) => e.toJson()).toList(),
  };
}
