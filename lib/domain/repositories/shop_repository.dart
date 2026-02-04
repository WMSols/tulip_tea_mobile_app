import 'package:tulip_tea_order_booker/domain/entities/shop.dart';

abstract class ShopRepository {
  Future<Shop> registerShop({
    required int orderBookerId,
    required String name,
    required String ownerName,
    required String ownerPhone,
    required double gpsLat,
    required double gpsLng,
    required int zoneId,
    required int routeId,
    required double creditLimit,
    String? ownerCnicFrontPhoto,
    String? ownerCnicBackPhoto,
  });
  Future<List<Shop>> getShopsByOrderBooker(
    int orderBookerId, {
    bool approvedOnly = false,
  });
}
