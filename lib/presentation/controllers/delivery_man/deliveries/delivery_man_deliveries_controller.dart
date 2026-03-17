import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/data/models/delivery/delivery_model.dart';
import 'package:tulip_tea_mobile_app/domain/entities/order_for_delivery_man.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/auth_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/order_use_case.dart';

/// One row for Deliveries tab: order + delivery (required) for completed/filtered list.
class DeliveryListItem {
  DeliveryListItem({required this.order, required this.delivery});
  final OrderForDeliveryMan order;
  final DeliveryModel delivery;
}

class DeliveryManDeliveriesController extends GetxController {
  DeliveryManDeliveriesController(this._authUseCase, this._orderUseCase);

  final AuthUseCase _authUseCase;
  final OrderUseCase _orderUseCase;

  final items = <DeliveryListItem>[].obs;
  final isLoading = true.obs;

  /// Optional filter: null = all, 'confirmed', 'delivered', 'cancelled' — filters before grouping.
  final statusFilter = Rxn<String>();

  @override
  void onReady() {
    loadDeliveries();
    super.onReady();
  }

  Future<void> loadDeliveries() async {
    final user = await _authUseCase.getCurrentUser();
    if (user == null) {
      items.clear();
      isLoading.value = false;
      return;
    }
    isLoading.value = true;
    try {
      // Single call: GET /orders/delivery-man/{id}?deliveries=true — backend returns deliveries-screen list with full delivery embedded
      final withDeliveries = await _orderUseCase
          .getOrdersWithDeliveriesByDeliveryMan(user.id);
      final list = <DeliveryListItem>[];
      for (final item in withDeliveries) {
        final delivery = item.delivery as DeliveryModel?;
        if (delivery == null) continue;
        list.add(DeliveryListItem(order: item.order, delivery: delivery));
      }
      items.assignAll(list);
    } catch (_) {
      items.clear();
    } finally {
      isLoading.value = false;
    }
  }

  List<DeliveryListItem> get _filteredItems {
    // Requirement: Deliveries tab should show only DELIVERED items.
    return items.where(_isDeliveredOnly).toList();
  }

  static bool _isDeliveredOnly(DeliveryListItem e) {
    final os = (e.order.status ?? '').toUpperCase();
    final ds = (e.delivery.status ?? '').toLowerCase();
    return os == 'DELIVERED' || ds == 'delivered';
  }

  /// List filtered by status dropdown (All / Confirmed / Delivered / Cancelled).
  List<DeliveryListItem> get filteredItems => _filteredItems;

  void setStatusFilter(String? value) {
    statusFilter.value = value?.isEmpty == true ? null : value;
  }
}
