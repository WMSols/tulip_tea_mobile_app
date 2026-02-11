/// Request body for POST /shops/order-booker/{order_booker_id} (ShopRegister schema).
class ShopRegisterRequest {
  ShopRegisterRequest({
    required this.name,
    required this.ownerName,
    required this.ownerPhone,
    required this.gpsLat,
    required this.gpsLng,
    this.zoneId,
    this.routeId,
    this.creditLimit = 0,
    this.legacyBalance = 0,
    this.ownerCnicFrontPhoto,
    this.ownerCnicBackPhoto,
    this.ownerPhoto,
    this.shopExteriorPhoto,
  });

  final String name;
  final String ownerName;
  final String ownerPhone;
  final double gpsLat;
  final double gpsLng;
  final int? zoneId;
  final int? routeId;
  final double creditLimit;
  final double legacyBalance;
  final String? ownerCnicFrontPhoto;
  final String? ownerCnicBackPhoto;
  final String? ownerPhoto;
  final String? shopExteriorPhoto;

  Map<String, dynamic> toJson() => {
    'name': name,
    'owner_name': ownerName,
    'owner_phone': ownerPhone,
    'gps_lat': gpsLat,
    'gps_lng': gpsLng,
    if (zoneId != null) 'zone_id': zoneId,
    if (routeId != null) 'route_id': routeId,
    'credit_limit': creditLimit,
    if (legacyBalance != 0) 'legacy_balance': legacyBalance,
    if (ownerCnicFrontPhoto != null)
      'owner_cnic_front_photo': ownerCnicFrontPhoto,
    if (ownerCnicBackPhoto != null) 'owner_cnic_back_photo': ownerCnicBackPhoto,
    if (ownerPhoto != null) 'owner_photo': ownerPhoto,
    if (shopExteriorPhoto != null) 'shop_exterior_photo': shopExteriorPhoto,
  };
}
