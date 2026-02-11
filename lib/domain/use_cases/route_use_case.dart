import 'package:tulip_tea_mobile_app/domain/entities/route_entity.dart';
import 'package:tulip_tea_mobile_app/domain/repositories/route_repository.dart';

class RouteUseCase {
  RouteUseCase(this._repo);
  final RouteRepository _repo;

  Future<List<RouteEntity>> getRoutesByOrderBooker(int orderBookerId) =>
      _repo.getRoutesByOrderBooker(orderBookerId);

  Future<List<RouteEntity>> getRoutesByZone(int zoneId) =>
      _repo.getRoutesByZone(zoneId);
}
