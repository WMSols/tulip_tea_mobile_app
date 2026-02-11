import 'package:tulip_tea_mobile_app/domain/entities/shop.dart';

abstract class ShopRepository {
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
  });
  Future<List<Shop>> getShopsByOrderBooker(
    int orderBookerId, {
    bool approvedOnly = false,
  });

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
  });
}
