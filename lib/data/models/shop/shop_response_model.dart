import 'package:tulip_tea_mobile_app/domain/entities/shop.dart';

/// Response for GET/POST shops (ShopResponse schema).
class ShopResponseModel {
  ShopResponseModel({
    required this.id,
    required this.name,
    this.ownerName,
    this.ownerPhone,
    this.gpsLat,
    this.gpsLng,
    required this.creditLimit,
    this.outstandingBalance,
    required this.isRegistered,
    required this.registrationStatus,
    this.verifiedByDistributor,
    this.verifiedAt,
    this.zoneId,
    this.createdByOrderBooker,
    this.createdByOrderBookerName,
    this.assignedToOrderBooker,
    this.assignedToOrderBookerName,
    this.routes,
    this.ownerCnicFrontPhoto,
    this.ownerCnicBackPhoto,
    this.shopExteriorPhoto,
    this.ownerPhoto,
    this.creditLimitRequestId,
    this.createdAt,
  });

  factory ShopResponseModel.fromJson(Map<String, dynamic> json) {
    List<Map<String, dynamic>>? routesList;
    if (json['routes'] != null) {
      final r = json['routes'] as List<dynamic>;
      routesList = r.map((e) => Map<String, dynamic>.from(e as Map)).toList();
    }
    return ShopResponseModel(
      id: json['id'] as int,
      name: json['name'] as String,
      ownerName: json['owner_name'] as String?,
      ownerPhone: json['owner_phone'] as String?,
      gpsLat: (json['gps_lat'] as num?)?.toDouble(),
      gpsLng: (json['gps_lng'] as num?)?.toDouble(),
      creditLimit: (json['credit_limit'] as num).toDouble(),
      outstandingBalance: (json['outstanding_balance'] as num?)?.toDouble(),
      isRegistered: json['is_registered'] as bool? ?? false,
      registrationStatus: json['registration_status'] as String? ?? '',
      verifiedByDistributor: json['verified_by_distributor'] as int?,
      verifiedAt: json['verified_at'] as String?,
      zoneId: json['zone_id'] as int?,
      createdByOrderBooker: json['created_by_order_booker'] as int?,
      createdByOrderBookerName: json['created_by_order_booker_name'] as String?,
      assignedToOrderBooker: json['assigned_to_order_booker'] as int?,
      assignedToOrderBookerName:
          json['assigned_to_order_booker_name'] as String?,
      routes: routesList,
      ownerCnicFrontPhoto: json['owner_cnic_front_photo'] as String?,
      ownerCnicBackPhoto: json['owner_cnic_back_photo'] as String?,
      shopExteriorPhoto: json['shop_exterior_photo'] as String?,
      ownerPhoto: json['owner_photo'] as String?,
      creditLimitRequestId: json['credit_limit_request_id'] as int?,
      createdAt: json['created_at'] as String?,
    );
  }

  final int id;
  final String name;
  final String? ownerName;
  final String? ownerPhone;
  final double? gpsLat;
  final double? gpsLng;
  final double creditLimit;
  final double? outstandingBalance;
  final bool isRegistered;
  final String registrationStatus;
  final int? verifiedByDistributor;
  final String? verifiedAt;
  final int? zoneId;
  final int? createdByOrderBooker;
  final String? createdByOrderBookerName;
  final int? assignedToOrderBooker;
  final String? assignedToOrderBookerName;
  final List<Map<String, dynamic>>? routes;
  final String? ownerCnicFrontPhoto;
  final String? ownerCnicBackPhoto;
  final String? shopExteriorPhoto;
  final String? ownerPhoto;
  final int? creditLimitRequestId;
  final String? createdAt;

  Shop toEntity() {
    int? routeIdFromRoutes;
    if (routes != null && routes!.isNotEmpty) {
      final first = routes!.first;
      if (first['id'] != null) routeIdFromRoutes = first['id'] as int;
    }
    return Shop(
      id: id,
      name: name,
      ownerName: ownerName ?? '',
      ownerPhone: ownerPhone ?? '',
      gpsLat: gpsLat,
      gpsLng: gpsLng,
      zoneId: zoneId,
      routeId: routeIdFromRoutes,
      creditLimit: creditLimit,
      outstandingBalance: outstandingBalance,
      registrationStatus: registrationStatus,
      createdAt: createdAt,
      ownerPhotoUrl: ownerPhoto,
      ownerCnicFrontPhotoUrl: ownerCnicFrontPhoto,
      ownerCnicBackPhotoUrl: ownerCnicBackPhoto,
      shopExteriorPhotoUrl: shopExteriorPhoto,
    );
  }
}
