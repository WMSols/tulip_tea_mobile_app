import 'package:tulip_tea_mobile_app/data/data_sources/remote/deliveries_api.dart';
import 'package:tulip_tea_mobile_app/data/models/delivery/delivery_model.dart';
import 'package:tulip_tea_mobile_app/domain/repositories/delivery_repository.dart';

class DeliveryRepositoryImpl implements DeliveryRepository {
  DeliveryRepositoryImpl(this._api);

  final DeliveriesApi _api;

  @override
  Future<DeliveryModel> createDelivery({
    required int orderId,
    required int warehouseId,
  }) async {
    return _api.createDelivery(orderId: orderId, warehouseId: warehouseId);
  }

  @override
  Future<DeliveryModel?> getDeliveryByOrder(int orderId) async {
    return _api.getDeliveryByOrder(orderId);
  }

  @override
  Future<DeliveryModel> pickupFromWarehouse({
    required int deliveryId,
    required Map<String, int> pickupQuantities,
    double? pickupGpsLat,
    double? pickupGpsLng,
  }) async {
    return _api.pickupFromWarehouse(
      deliveryId: deliveryId,
      pickupQuantities: pickupQuantities,
      pickupGpsLat: pickupGpsLat,
      pickupGpsLng: pickupGpsLng,
    );
  }

  @override
  Future<DeliveryModel> deliverToShop({
    required int deliveryId,
    required Map<String, int> deliveryQuantities,
    double? deliveryGpsLat,
    double? deliveryGpsLng,
    String? deliveryRemarks,
    List<String>? deliveryImages,
  }) async {
    return _api.deliverToShop(
      deliveryId: deliveryId,
      deliveryQuantities: deliveryQuantities,
      deliveryGpsLat: deliveryGpsLat,
      deliveryGpsLng: deliveryGpsLng,
      deliveryRemarks: deliveryRemarks,
      deliveryImages: deliveryImages,
    );
  }

  @override
  Future<DeliveryModel> returnToWarehouse({
    required int deliveryId,
    required Map<String, int> returnQuantities,
    double? returnGpsLat,
    double? returnGpsLng,
    String? returnReason,
  }) async {
    return _api.returnToWarehouse(
      deliveryId: deliveryId,
      returnQuantities: returnQuantities,
      returnGpsLat: returnGpsLat,
      returnGpsLng: returnGpsLng,
      returnReason: returnReason,
    );
  }

  @override
  Future<Map<String, dynamic>> deliverOrder({
    required int orderId,
    required String status,
    double? deliveryGpsLat,
    double? deliveryGpsLng,
    String? deliveryRemarks,
    List<String>? deliveryImages,
  }) async {
    return _api.deliverOrder(
      orderId: orderId,
      status: status,
      deliveryGpsLat: deliveryGpsLat,
      deliveryGpsLng: deliveryGpsLng,
      deliveryRemarks: deliveryRemarks,
      deliveryImages: deliveryImages,
    );
  }
}
