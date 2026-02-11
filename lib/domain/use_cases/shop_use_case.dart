import 'package:tulip_tea_mobile_app/domain/entities/shop.dart';
import 'package:tulip_tea_mobile_app/domain/repositories/shop_repository.dart';

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
    int? zoneId,
    int? routeId,
    double creditLimit = 0,
    double legacyBalance = 0,
    String? ownerCnicFrontPhoto,
    String? ownerCnicBackPhoto,
    String? ownerPhoto,
    String? shopExteriorPhoto,
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
    legacyBalance: legacyBalance,
    ownerCnicFrontPhoto: ownerCnicFrontPhoto,
    ownerCnicBackPhoto: ownerCnicBackPhoto,
    ownerPhoto: ownerPhoto,
    shopExteriorPhoto: shopExteriorPhoto,
  );

  Future<List<Shop>> getShopsByOrderBooker(
    int orderBookerId, {
    bool approvedOnly = false,
  }) => _repo.getShopsByOrderBooker(orderBookerId, approvedOnly: approvedOnly);

  Future<Shop> resubmitRejectedShop(
    int shopId, {
    required String name,
    required String ownerName,
    required String ownerPhone,
    required double gpsLat,
    required double gpsLng,
    int? zoneId,
    int? routeId,
    double creditLimit = 0,
    double legacyBalance = 0,
    String? ownerCnicFrontPhoto,
    String? ownerCnicBackPhoto,
    String? ownerPhoto,
    String? shopExteriorPhoto,
  }) => _repo.resubmitRejectedShop(
    shopId,
    name: name,
    ownerName: ownerName,
    ownerPhone: ownerPhone,
    gpsLat: gpsLat,
    gpsLng: gpsLng,
    zoneId: zoneId,
    routeId: routeId,
    creditLimit: creditLimit,
    legacyBalance: legacyBalance,
    ownerCnicFrontPhoto: ownerCnicFrontPhoto,
    ownerCnicBackPhoto: ownerCnicBackPhoto,
    ownerPhoto: ownerPhoto,
    shopExteriorPhoto: shopExteriorPhoto,
  );
}
