import 'package:tulip_tea_order_booker/domain/entities/shop.dart';
import 'package:tulip_tea_order_booker/domain/repositories/shop_repository.dart';

class ShopUseCase {
  ShopUseCase(this._repo);
  final ShopRepository _repo;

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
  }) => _repo.registerShop(
    orderBookerId: orderBookerId,
    name: name,
    ownerName: ownerName,
    ownerPhone: ownerPhone,
    gpsLat: gpsLat,
    gpsLng: gpsLng,
    zoneId: zoneId,
    routeId: routeId,
    creditLimit: creditLimit,
    ownerCnicFrontPhoto: ownerCnicFrontPhoto,
    ownerCnicBackPhoto: ownerCnicBackPhoto,
  );

  Future<List<Shop>> getShopsByOrderBooker(
    int orderBookerId, {
    bool approvedOnly = false,
  }) => _repo.getShopsByOrderBooker(orderBookerId, approvedOnly: approvedOnly);
}
