import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/data/models/delivery/delivery_model.dart';
import 'package:tulip_tea_mobile_app/domain/entities/order_for_delivery_man.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/auth_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/order_use_case.dart';

/// Single active order row for delivery man: order + optional delivery + status.
class OrderWithDeliveryItem {
  OrderWithDeliveryItem({
    required this.order,
    this.delivery,
    required this.deliveryStatus,
  });
  final OrderForDeliveryMan order;
  final DeliveryModel? delivery;
  final String deliveryStatus;
}

class DeliveryManOrdersController extends GetxController {
  DeliveryManOrdersController(this._authUseCase, this._orderUseCase);

  final AuthUseCase _authUseCase;
  final OrderUseCase _orderUseCase;

  final activeOrders = <OrderWithDeliveryItem>[].obs;
  final isLoading = true.obs;

  @override
  void onReady() {
    loadOrders();
    super.onReady();
  }

  Future<void> loadOrders() async {
    final user = await _authUseCase.getCurrentUser();
    if (user == null) {
      activeOrders.clear();
      isLoading.value = false;
      return;
    }
    isLoading.value = true;
    try {
      // Single call: GET /orders/delivery-man/{id}?pending=true — backend returns only pending/active with delivery embedded
      final list = await _orderUseCase
          .getPendingOrdersWithDeliveryByDeliveryMan(user.id);
      final active = list.map((item) {
        final delivery = item.delivery as DeliveryModel?;
        final deliveryStatus = delivery?.status?.toLowerCase() ?? 'not_started';
        return OrderWithDeliveryItem(
          order: item.order,
          delivery: delivery,
          deliveryStatus: deliveryStatus,
        );
      }).toList();
      activeOrders.assignAll(active);
    } catch (_) {
      activeOrders.clear();
    } finally {
      isLoading.value = false;
    }
  }
}
