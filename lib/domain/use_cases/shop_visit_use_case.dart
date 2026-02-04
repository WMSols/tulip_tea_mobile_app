import 'package:tulip_tea_order_booker/domain/entities/shop_visit.dart';
import 'package:tulip_tea_order_booker/domain/repositories/shop_visit_repository.dart';

class ShopVisitUseCase {
  ShopVisitUseCase(this._repo);
  final ShopVisitRepository _repo;

  Future<ShopVisit> registerVisit({
    required int orderBookerId,
    int? shopId,
    String? visitType,
    double? gpsLat,
    double? gpsLng,
    String? visitTime,
    String? photo,
    String? reason,
  }) => _repo.registerVisit(
    orderBookerId: orderBookerId,
    shopId: shopId,
    visitType: visitType,
    gpsLat: gpsLat,
    gpsLng: gpsLng,
    visitTime: visitTime,
    photo: photo,
    reason: reason,
  );

  Future<List<ShopVisit>> getVisitsByOrderBooker(
    int orderBookerId, {
    int skip = 0,
    int limit = 100,
  }) => _repo.getVisitsByOrderBooker(orderBookerId, skip: skip, limit: limit);
}
