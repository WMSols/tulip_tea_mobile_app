class Shop {
  const Shop({
    required this.id,
    required this.name,
    required this.ownerName,
    required this.ownerPhone,
    this.gpsLat,
    this.gpsLng,
    this.zoneId,
    this.routeId,
    this.creditLimit,
    this.registrationStatus,
    this.createdAt,
  });

  final int id;
  final String name;
  final String ownerName;
  final String ownerPhone;
  final double? gpsLat;
  final double? gpsLng;
  final int? zoneId;
  final int? routeId;
  final double? creditLimit;
  final String? registrationStatus;
  final String? createdAt;
}
