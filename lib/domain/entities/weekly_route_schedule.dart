/// Weekly route schedule (route assigned to order booker for a specific day).
class WeeklyRouteSchedule {
  const WeeklyRouteSchedule({
    required this.id,
    required this.routeId,
    this.routeName,
    required this.dayOfWeek,
    this.isActive = true,
  });

  final int id;
  final int routeId;
  final String? routeName;
  final int dayOfWeek;
  final bool isActive;
}
