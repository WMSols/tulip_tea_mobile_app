import 'package:tulip_tea_order_booker/core/network/api_exceptions.dart';
import 'package:tulip_tea_order_booker/domain/entities/shop.dart';
import 'package:tulip_tea_order_booker/domain/repositories/shop_repository.dart';
import 'package:tulip_tea_order_booker/data/data_sources/remote/shops_api.dart';
import 'package:tulip_tea_order_booker/data/models/shop/shop_register_request.dart';

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
    required int zoneId,
    required int routeId,
    required double creditLimit,
    String? ownerCnicFrontPhoto,
    String? ownerCnicBackPhoto,
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
        ownerCnicFrontPhoto: ownerCnicFrontPhoto,
        ownerCnicBackPhoto: ownerCnicBackPhoto,
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
}
