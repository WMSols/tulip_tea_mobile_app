import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/data/models/delivery/delivery_model.dart';
import 'package:tulip_tea_mobile_app/data/models/warehouse/warehouse_model.dart';
import 'package:tulip_tea_mobile_app/domain/entities/order_for_delivery_man.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/auth_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/delivery_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/warehouse_use_case.dart';

class DeliveryManPickupController extends GetxController {
  DeliveryManPickupController(
    this._deliveryUseCase,
    this._warehouseUseCase,
    this._authUseCase,
  );

  final DeliveryUseCase _deliveryUseCase;
  final WarehouseUseCase _warehouseUseCase;
  final AuthUseCase _authUseCase;

  OrderForDeliveryMan? order;
  final delivery = Rxn<DeliveryModel>();
  final warehouses = <WarehouseModel>[].obs;
  final selectedWarehouseId = Rxn<int>();
  final pickupQuantities = <int, int>{}.obs; // productId -> quantity
  final pickupQuantitiesByName =
      <String, int>{}.obs; // when no delivery: productName -> quantity
  final isLoading = false.obs;
  final isSubmitting = false.obs;

  @override
  void onInit() {
    super.onInit();
    _parseArgs();
  }

  @override
  void onReady() {
    _loadWarehouses();
    super.onReady();
  }

  void _parseArgs() {
    final args = Get.arguments;
    if (args is Map) {
      order = args['order'] as OrderForDeliveryMan?;
      final d = args['delivery'] as DeliveryModel?;
      if (d != null) {
        delivery.value = d;
        _initQuantitiesFromDelivery(d);
      } else {
        _initQuantitiesFromOrder();
      }
    }
  }

  void _initQuantitiesFromOrder() {
    final items = order?.orderItems;
    if (items == null) return;
    for (final e in items) {
      final name = e.productName?.trim();
      if (name != null && name.isNotEmpty) {
        pickupQuantitiesByName[name] = e.quantity ?? 0;
      }
    }
    pickupQuantitiesByName.refresh();
  }

  void _initQuantitiesFromDelivery(DeliveryModel d) {
    final items = d.deliveryItems;
    if (items != null) {
      for (final item in items) {
        final pid = item.productId;
        if (pid != null) {
          pickupQuantities[pid] = item.quantity ?? 0;
        }
      }
    }
  }

  Future<void> _loadWarehouses() async {
    final user = await _authUseCase.getCurrentUser();
    if (user == null) return;
    try {
      final list = await _warehouseUseCase.getWarehousesByDeliveryMan(user.id);
      warehouses.assignAll(list);
    } catch (_) {
      warehouses.clear();
    }
  }

  /// Creates delivery (A1). Does not manage [isSubmitting]; caller should show loading for full flow.
  Future<bool> createDelivery() async {
    final o = order;
    final wid = selectedWarehouseId.value;
    if (o == null || wid == null) return false;
    try {
      final d = await _deliveryUseCase.createDelivery(
        orderId: o.id,
        warehouseId: wid,
      );
      delivery.value = d;
      _initQuantitiesFromDelivery(d);
      return true;
    } catch (_) {
      rethrow;
    }
  }

  void setQuantity(int productId, int value) {
    pickupQuantities[productId] = value;
    pickupQuantities.refresh();
  }

  void setQuantityByName(String productName, int value) {
    final key = productName.trim();
    if (key.isEmpty) return;
    pickupQuantitiesByName[key] = value;
    pickupQuantitiesByName.refresh();
  }

  void _mapQuantitiesByNameToIds() {
    final d = delivery.value;
    final items = d?.deliveryItems;
    if (items != null && items.isNotEmpty) {
      pickupQuantities.clear();
      for (final item in items) {
        final pid = item.productId;
        final name = item.productName?.trim();
        if (pid != null && name != null && name.isNotEmpty) {
          final qty = pickupQuantitiesByName[name] ?? item.quantity ?? 0;
          if (qty > 0) pickupQuantities[pid] = qty;
        }
      }
      pickupQuantities.refresh();
    }
  }

  /// Build pickup quantities map: from delivery items (product_id) when available,
  /// otherwise from order items + pickupQuantitiesByName (order_item_id as key for backend).
  Map<String, int> _buildPickupQuantitiesMap(DeliveryModel d) {
    final fromDelivery = <String, int>{};
    final items = d.deliveryItems;
    if (items != null && items.isNotEmpty) {
      for (final item in items) {
        final pid = item.productId;
        final name = item.productName?.trim();
        if (pid != null && name != null && name.isNotEmpty) {
          final qty =
              pickupQuantitiesByName[name] ??
              pickupQuantities[pid] ??
              item.quantity ??
              0;
          if (qty > 0) fromDelivery['$pid'] = qty;
        }
      }
      if (fromDelivery.isNotEmpty) return fromDelivery;
    }
    final fromOrder = <String, int>{};
    final orderItems = order?.orderItems;
    if (orderItems != null) {
      for (final o in orderItems) {
        final name = o.productName?.trim();
        if (name == null || name.isEmpty) continue;
        final qty = pickupQuantitiesByName[name] ?? o.quantity ?? 0;
        if (qty > 0 && o.id != null) fromOrder['${o.id}'] = qty;
      }
    }
    return fromOrder;
  }

  /// Returns the delivery from the **record pickup** API (A2), which has status in_transit.
  /// Shows loading from tap until pickup (A2) response; hits create delivery (A1) then pickup (A2).
  Future<DeliveryModel?> submitPickup({double? lat, double? lng}) async {
    isSubmitting.value = true;
    try {
      DeliveryModel? d = delivery.value;
      if (d == null) {
        final created = await createDelivery();
        if (!created) return null;
        d = delivery.value;
        if (d == null) return null;
        _mapQuantitiesByNameToIds();
      }
      final map = _buildPickupQuantitiesMap(d);
      if (map.isEmpty) return null;
      final updated = await _deliveryUseCase.pickupFromWarehouse(
        deliveryId: d.id,
        pickupQuantities: map,
        pickupGpsLat: lat,
        pickupGpsLng: lng,
      );
      delivery.value = updated;
      return updated;
    } catch (_) {
      return null;
    } finally {
      isSubmitting.value = false;
    }
  }
}
