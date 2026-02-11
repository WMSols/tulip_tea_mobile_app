import 'package:tulip_tea_mobile_app/domain/entities/shop_visit.dart';
import 'package:tulip_tea_mobile_app/domain/repositories/order_repository.dart';
import 'package:tulip_tea_mobile_app/domain/repositories/shop_visit_repository.dart';

class ShopVisitUseCase {
  ShopVisitUseCase(this._repo);
  final ShopVisitRepository _repo;

  Future<ShopVisit> registerVisit({
    required int orderBookerId,
    int? shopId,
    List<String>? visitTypes,
    double? gpsLat,
    double? gpsLng,
    String? visitTime,
    String? photo,
    String? reason,
    List<OrderItemInput>? orderItems,
  }) => _repo.registerVisit(
    orderBookerId: orderBookerId,
    shopId: shopId,
    visitTypes: visitTypes,
    gpsLat: gpsLat,
    gpsLng: gpsLng,
    visitTime: visitTime,
    photo: photo,
    reason: reason,
    orderItems: orderItems,
  );

  Future<List<ShopVisit>> getVisitsByOrderBooker(
    int orderBookerId, {
    int skip = 0,
    int limit = 100,
  }) => _repo.getVisitsByOrderBooker(orderBookerId, skip: skip, limit: limit);
}
