import 'package:tulip_tea_mobile_app/domain/entities/shop_visit.dart';
import 'package:tulip_tea_mobile_app/domain/repositories/order_repository.dart';

abstract class ShopVisitRepository {
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
  });
  Future<List<ShopVisit>> getVisitsByOrderBooker(
    int orderBookerId, {
    int skip = 0,
    int limit = 100,
  });
}
