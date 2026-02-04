import 'package:tulip_tea_order_booker/domain/entities/route_entity.dart';

abstract class RouteRepository {
  Future<List<RouteEntity>> getRoutesByOrderBooker(int orderBookerId);
  Future<List<RouteEntity>> getRoutesByZone(int zoneId);
}
