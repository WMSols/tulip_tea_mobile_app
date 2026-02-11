import 'package:tulip_tea_mobile_app/core/network/api_exceptions.dart';
import 'package:tulip_tea_mobile_app/domain/entities/shop_visit.dart';
import 'package:tulip_tea_mobile_app/domain/repositories/order_repository.dart';
import 'package:tulip_tea_mobile_app/domain/repositories/shop_visit_repository.dart';
import 'package:tulip_tea_mobile_app/data/data_sources/remote/shop_visits_api.dart';
import 'package:tulip_tea_mobile_app/data/models/order/order_create_request.dart';
import 'package:tulip_tea_mobile_app/data/models/shop_visit/shop_visit_create.dart';

class ShopVisitRepositoryImpl implements ShopVisitRepository {
  ShopVisitRepositoryImpl(this._api);

  final ShopVisitsApi _api;

  @override
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
  }) async {
    try {
      final orderItemRequests = orderItems
          ?.map(
            (e) => OrderItemRequest(
              productId: e.productId,
              productName: e.productName,
              quantity: e.quantity,
              unitPrice: e.unitPrice,
            ),
          )
          .toList();
      final request = ShopVisitCreate(
        shopId: shopId,
        visitTypes: visitTypes?.isNotEmpty == true ? visitTypes : null,
        gpsLat: gpsLat,
        gpsLng: gpsLng,
        visitTime: visitTime,
        photo: photo,
        reason: reason,
        orderItems: orderItemRequests,
      );
      final model = await _api.registerVisit(orderBookerId, request);
      return model.toEntity();
    } catch (e, st) {
      final failure = ApiExceptions.handle<ShopVisit>(e, st);
      throw Exception(failure.message);
    }
  }

  @override
  Future<List<ShopVisit>> getVisitsByOrderBooker(
    int orderBookerId, {
    int skip = 0,
    int limit = 100,
  }) async {
    try {
      final list = await _api.getVisitsByOrderBooker(
        orderBookerId,
        skip: skip,
        limit: limit,
      );
      return list.map((e) => e.toEntity()).toList();
    } catch (e, st) {
      final failure = ApiExceptions.handle<List<ShopVisit>>(e, st);
      throw Exception(failure.message);
    }
  }
}
