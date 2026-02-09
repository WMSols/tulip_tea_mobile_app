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
    this.outstandingBalance,
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
  final double? outstandingBalance;
  final String? registrationStatus;
  final String? createdAt;

  /// Available credit = creditLimit - outstandingBalance (when both present).
  double? get availableCredit {
    if (creditLimit == null) return null;
    final out = outstandingBalance ?? 0;
    return (creditLimit! - out).clamp(0, double.infinity);
  }
}
