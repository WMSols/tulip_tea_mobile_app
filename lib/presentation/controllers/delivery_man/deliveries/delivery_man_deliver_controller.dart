import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/data/models/delivery/delivery_model.dart';
import 'package:tulip_tea_mobile_app/domain/entities/order_for_delivery_man.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/delivery_use_case.dart';

class DeliveryManDeliverController extends GetxController {
  DeliveryManDeliverController(this._deliveryUseCase);

  final DeliveryUseCase _deliveryUseCase;

  OrderForDeliveryMan? order;
  DeliveryModel? delivery;

  /// Key = productId ?? orderItemId ?? deliveryItem.id (so items with product_id null still work).
  final deliveryQuantities = <int, int>{}.obs;
  final isSubmitting = false.obs;

  /// True while fetching delivery items (e.g. via getDeliveryByOrder). Used to show loading in the form.
  bool isLoadingItems = false;

  static int _itemKey(DeliveryItemModel item) =>
      item.productId ?? item.orderItemId ?? item.id;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is Map) {
      order = args['order'] as OrderForDeliveryMan?;
      delivery = args['delivery'] as DeliveryModel?;
      _fillQuantitiesFromDelivery();
    }
  }

  @override
  void onReady() {
    super.onReady();
    _ensureDeliveryItems();
  }

  void _fillQuantitiesFromDelivery() {
    final d = delivery;
    if (d?.deliveryItems == null) return;
    for (final item in d!.deliveryItems!) {
      final picked = item.quantityPickedUp ?? item.quantity ?? 0;
      final alreadyDelivered = item.quantityDelivered ?? 0;
      final remainingToDeliver = (picked - alreadyDelivered).clamp(0, picked);
      deliveryQuantities[_itemKey(item)] = remainingToDeliver;
    }
  }

  /// If delivery has no items (e.g. from list API), fetch full delivery by order so order items show.
  Future<void> _ensureDeliveryItems() async {
    final o = order;
    final d = delivery;
    if (o == null || d == null) return;
    final items = d.deliveryItems;
    if (items != null && items.isNotEmpty) return;
    isLoadingItems = true;
    update();
    try {
      final full = await _deliveryUseCase.getDeliveryByOrder(o.id);
      if (full != null && (full.deliveryItems?.isNotEmpty ?? false)) {
        delivery = full;
        _fillQuantitiesFromDelivery();
      }
      update();
    } catch (_) {
      update();
    } finally {
      isLoadingItems = false;
      update();
    }
  }

  void setQuantity(int key, int value) {
    deliveryQuantities[key] = value;
    deliveryQuantities.refresh();
  }

  /// Returns the updated [DeliveryModel] on success, null on failure.
  Future<DeliveryModel?> submitDeliver({
    double? lat,
    double? lng,
    String? remarks,
    List<String>? imageUrls,
  }) async {
    final d = delivery;
    if (d == null) return null;
    final map = <String, int>{};
    for (final e in deliveryQuantities.entries) {
      if (e.value > 0) map['${e.key}'] = e.value;
    }
    if (map.isEmpty) return null;
    isSubmitting.value = true;
    try {
      final updated = await _deliveryUseCase.deliverToShop(
        deliveryId: d.id,
        deliveryQuantities: map,
        deliveryGpsLat: lat,
        deliveryGpsLng: lng,
        deliveryRemarks: remarks,
        deliveryImages: imageUrls,
      );
      delivery = updated;
      return updated;
    } catch (_) {
      return null;
    } finally {
      isSubmitting.value = false;
    }
  }
}
