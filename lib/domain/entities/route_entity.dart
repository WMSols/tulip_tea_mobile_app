/// Route entity (assigned to order booker). Named to avoid conflict with GetX GetPage route.
class RouteEntity {
  const RouteEntity({
    required this.id,
    required this.name,
    this.zoneId,
    this.orderBookerId,
  });

  final int id;
  final String name;
  final int? zoneId;
  final int? orderBookerId;
}
