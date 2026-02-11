import 'package:tulip_tea_mobile_app/domain/entities/route_entity.dart';
import 'package:tulip_tea_mobile_app/domain/repositories/route_repository.dart';
import 'package:tulip_tea_mobile_app/data/data_sources/remote/routes_api.dart';

class RouteRepositoryImpl implements RouteRepository {
  RouteRepositoryImpl(this._api);

  final RoutesApi _api;

  @override
  Future<List<RouteEntity>> getRoutesByOrderBooker(int orderBookerId) async {
    final list = await _api.getRoutesByOrderBooker(orderBookerId);
    return list.map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<RouteEntity>> getRoutesByZone(int zoneId) async {
    final list = await _api.getRoutesByZone(zoneId);
    return list.map((e) => e.toEntity()).toList();
  }
}
