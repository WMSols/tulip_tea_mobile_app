import 'package:tulip_tea_mobile_app/core/network/api_exceptions.dart';
import 'package:tulip_tea_mobile_app/domain/entities/shop.dart';
import 'package:tulip_tea_mobile_app/domain/repositories/shop_repository.dart';
import 'package:tulip_tea_mobile_app/data/data_sources/remote/shops_api.dart';
import 'package:tulip_tea_mobile_app/data/models/shop/shop_register_request.dart';

class ShopRepositoryImpl implements ShopRepository {
  ShopRepositoryImpl(this._api);

  final ShopsApi _api;

  @override
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
  }) async {
    try {
      final request = ShopRegisterRequest(
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
      final model = await _api.registerShop(orderBookerId, request);
      return model.toEntity();
    } catch (e, st) {
      final failure = ApiExceptions.handle<Shop>(e, st);
      throw Exception(failure.message);
    }
  }

  @override
  Future<List<Shop>> getShopsByOrderBooker(
    int orderBookerId, {
    bool approvedOnly = false,
  }) async {
    try {
      final list = await _api.getShopsByOrderBooker(
        orderBookerId,
        approvedOnly: approvedOnly,
      );
      return list.map((e) => e.toEntity()).toList();
    } catch (e, st) {
      final failure = ApiExceptions.handle<List<Shop>>(e, st);
      throw Exception(failure.message);
    }
  }

  @override
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
  }) async {
    try {
      final request = ShopRegisterRequest(
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
      final model = await _api.resubmitRejectedShop(shopId, request);
      return model.toEntity();
    } catch (e, st) {
      final failure = ApiExceptions.handle<Shop>(e, st);
      throw Exception(failure.message);
    }
  }
}
