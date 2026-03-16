import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/data/models/delivery/delivery_model.dart';
import 'package:tulip_tea_mobile_app/domain/entities/order_for_delivery_man.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/delivery_use_case.dart';

class DeliveryManOrderDetailController extends GetxController {
  DeliveryManOrderDetailController(this._deliveryUseCase);

  final DeliveryUseCase _deliveryUseCase;

  OrderForDeliveryMan? order;
  DeliveryModel? delivery;

  bool get hasDelivery => delivery != null;
  String get deliveryStatus => delivery?.status?.toLowerCase() ?? 'not_started';

  /// Not started or Pending pickup: show Onboard stock, Daily collection, View details
  bool get canOnboardStock =>
      !hasDelivery ||
      deliveryStatus == 'not_started' ||
      deliveryStatus == 'pending_pickup';
  bool get canDailyCollection => canOnboardStock;

  /// Picked up or In transit: show Deliver to shop, View details
  bool get canDeliverToShop =>
      deliveryStatus == 'picked_up' || deliveryStatus == 'in_transit';

  /// Partially delivered: show Update delivery, Return remaining stock, View details
  bool get canUpdateDelivery => deliveryStatus == 'partially_delivered';
  bool get canReturnRemainingStock => deliveryStatus == 'partially_delivered';

  /// Delivered: only View details + message
  bool get isFullyDelivered => deliveryStatus == 'delivered';

  /// Payment before delivery: daily collection must be recorded before delivering
  bool get isPaymentBeforeDelivery =>
      (order?.orderResolutionType ?? '').toLowerCase() ==
      'payment_before_delivery';

  /// Legacy / internal
  bool get canPickup => canOnboardStock;
  bool get canDeliver => canDeliverToShop;
  bool get canReturn =>
      deliveryStatus == 'picked_up' || deliveryStatus == 'in_transit';
  bool get canMarkOrderDelivered => canDeliverToShop;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is Map) {
      order = args['order'] as OrderForDeliveryMan?;
      delivery = args['delivery'] as DeliveryModel?;
    }
  }

  @override
  void onReady() {
    super.onReady();
    _refreshDelivery();
  }

  /// Fetch latest delivery by order id so buttons (Deliver to shop, Daily collection, etc.) match current status.
  Future<void> _refreshDelivery() async {
    final o = order;
    if (o == null) return;
    try {
      final latest = await _deliveryUseCase.getDeliveryByOrder(o.id);
      if (latest != null) {
        delivery = latest;
        update();
      }
    } catch (_) {
      // Keep existing delivery from arguments
    }
  }

  Future<void> markOrderDelivered({
    required String status,
    double? lat,
    double? lng,
    String? remarks,
    List<String>? imageUrls,
  }) async {
    final o = order;
    if (o == null) return;
    await _deliveryUseCase.deliverOrder(
      orderId: o.id,
      status: status,
      deliveryGpsLat: lat,
      deliveryGpsLng: lng,
      deliveryRemarks: remarks,
      deliveryImages: imageUrls,
    );
  }
}
