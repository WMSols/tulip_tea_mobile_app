import 'package:tulip_tea_mobile_app/data/models/delivery/delivery_model.dart';
import 'package:tulip_tea_mobile_app/domain/repositories/delivery_repository.dart';

class DeliveryUseCase {
  DeliveryUseCase(this._repo);
  final DeliveryRepository _repo;

  Future<DeliveryModel> createDelivery({
    required int orderId,
    required int warehouseId,
  }) => _repo.createDelivery(orderId: orderId, warehouseId: warehouseId);

  Future<DeliveryModel?> getDeliveryByOrder(int orderId) =>
      _repo.getDeliveryByOrder(orderId);

  Future<List<DeliveryModel>> getDeliveriesByDeliveryMan(int deliveryManId) =>
      _repo.getDeliveriesByDeliveryMan(deliveryManId);

  Future<DeliveryModel> pickupFromWarehouse({
    required int deliveryId,
    required Map<String, int> pickupQuantities,
    double? pickupGpsLat,
    double? pickupGpsLng,
  }) => _repo.pickupFromWarehouse(
    deliveryId: deliveryId,
    pickupQuantities: pickupQuantities,
    pickupGpsLat: pickupGpsLat,
    pickupGpsLng: pickupGpsLng,
  );

  Future<DeliveryModel> deliverToShop({
    required int deliveryId,
    required Map<String, int> deliveryQuantities,
    double? deliveryGpsLat,
    double? deliveryGpsLng,
    String? deliveryRemarks,
    List<String>? deliveryImages,
  }) => _repo.deliverToShop(
    deliveryId: deliveryId,
    deliveryQuantities: deliveryQuantities,
    deliveryGpsLat: deliveryGpsLat,
    deliveryGpsLng: deliveryGpsLng,
    deliveryRemarks: deliveryRemarks,
    deliveryImages: deliveryImages,
  );

  Future<DeliveryModel> returnToWarehouse({
    required int deliveryId,
    required Map<String, int> returnQuantities,
    double? returnGpsLat,
    double? returnGpsLng,
    String? returnReason,
  }) => _repo.returnToWarehouse(
    deliveryId: deliveryId,
    returnQuantities: returnQuantities,
    returnGpsLat: returnGpsLat,
    returnGpsLng: returnGpsLng,
    returnReason: returnReason,
  );

  Future<Map<String, dynamic>> deliverOrder({
    required int orderId,
    required String status,
    double? deliveryGpsLat,
    double? deliveryGpsLng,
    String? deliveryRemarks,
    List<String>? deliveryImages,
  }) => _repo.deliverOrder(
    orderId: orderId,
    status: status,
    deliveryGpsLat: deliveryGpsLat,
    deliveryGpsLng: deliveryGpsLng,
    deliveryRemarks: deliveryRemarks,
    deliveryImages: deliveryImages,
  );
}
