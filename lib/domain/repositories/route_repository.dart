import 'package:tulip_tea_mobile_app/domain/entities/route_entity.dart';

abstract class RouteRepository {
  Future<List<RouteEntity>> getRoutesByOrderBooker(int orderBookerId);
  Future<List<RouteEntity>> getRoutesByZone(int zoneId);
}
