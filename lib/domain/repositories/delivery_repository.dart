import 'package:tulip_tea_mobile_app/data/models/delivery/delivery_model.dart';

abstract class DeliveryRepository {
  /// Create a delivery record for an order
  Future<DeliveryModel> createDelivery({
    required int orderId,
    required int warehouseId,
  });

  /// Get delivery by order ID
  Future<DeliveryModel?> getDeliveryByOrder(int orderId);

  /// Get all deliveries for a delivery man
  Future<List<DeliveryModel>> getDeliveriesByDeliveryMan(int deliveryManId);

  /// Record warehouse pickup
  Future<DeliveryModel> pickupFromWarehouse({
    required int deliveryId,
    required Map<String, int> pickupQuantities,
    double? pickupGpsLat,
    double? pickupGpsLng,
  });

  /// Record shop delivery
  Future<DeliveryModel> deliverToShop({
    required int deliveryId,
    required Map<String, int> deliveryQuantities,
    double? deliveryGpsLat,
    double? deliveryGpsLng,
    String? deliveryRemarks,
    List<String>? deliveryImages,
  });

  /// Record return to warehouse
  Future<DeliveryModel> returnToWarehouse({
    required int deliveryId,
    required Map<String, int> returnQuantities,
    double? returnGpsLat,
    double? returnGpsLng,
    String? returnReason,
  });

  /// Mark order as delivered or disapproved
  Future<Map<String, dynamic>> deliverOrder({
    required int orderId,
    required String status,
    double? deliveryGpsLat,
    double? deliveryGpsLng,
    String? deliveryRemarks,
    List<String>? deliveryImages,
  });
}
