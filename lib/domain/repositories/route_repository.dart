import 'package:tulip_tea_mobile_app/domain/entities/route_entity.dart';
import 'package:tulip_tea_mobile_app/domain/entities/weekly_route_schedule.dart';

abstract class RouteRepository {
  Future<List<RouteEntity>> getRoutesByOrderBooker(int orderBookerId);
  Future<List<RouteEntity>> getRoutesByZone(int zoneId);
  Future<List<WeeklyRouteSchedule>> getWeeklySchedulesByOrderBooker(
    int orderBookerId,
  );
}
