import 'package:tulip_tea_order_booker/domain/entities/shop_visit.dart';

abstract class ShopVisitRepository {
  Future<ShopVisit> registerVisit({
    required int orderBookerId,
    int? shopId,
    String? visitType,
    double? gpsLat,
    double? gpsLng,
    String? visitTime,
    String? photo,
    String? reason,
  });
  Future<List<ShopVisit>> getVisitsByOrderBooker(
    int orderBookerId, {
    int skip = 0,
    int limit = 100,
  });
}
