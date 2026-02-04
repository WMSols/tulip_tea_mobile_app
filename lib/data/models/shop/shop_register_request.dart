class ShopRegisterRequest {
  ShopRegisterRequest({
    required this.name,
    required this.ownerName,
    required this.ownerPhone,
    required this.gpsLat,
    required this.gpsLng,
    required this.zoneId,
    required this.routeId,
    required this.creditLimit,
    this.ownerCnicFrontPhoto,
    this.ownerCnicBackPhoto,
  });

  final String name;
  final String ownerName;
  final String ownerPhone;
  final double gpsLat;
  final double gpsLng;
  final int zoneId;
  final int routeId;
  final double creditLimit;
  final String? ownerCnicFrontPhoto;
  final String? ownerCnicBackPhoto;

  Map<String, dynamic> toJson() => {
    'name': name,
    'owner_name': ownerName,
    'owner_phone': ownerPhone,
    'gps_lat': gpsLat,
    'gps_lng': gpsLng,
    'zone_id': zoneId,
    'route_id': routeId,
    'credit_limit': creditLimit,
    if (ownerCnicFrontPhoto != null)
      'owner_cnic_front_photo': ownerCnicFrontPhoto,
    if (ownerCnicBackPhoto != null) 'owner_cnic_back_photo': ownerCnicBackPhoto,
  };
}
