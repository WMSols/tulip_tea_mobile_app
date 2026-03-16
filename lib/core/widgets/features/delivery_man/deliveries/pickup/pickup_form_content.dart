import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/buttons/app_button.dart';
import 'package:tulip_tea_mobile_app/core/widgets/feedback/app_toast.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/delivery_man/deliveries/pickup/pickup_order_items_section.dart';
import 'package:tulip_tea_mobile_app/presentation/routes/app_routes.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/delivery_man/deliveries/pickup/pickup_quantities_section.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/delivery_man/deliveries/pickup/pickup_warehouse_section.dart';
import 'package:tulip_tea_mobile_app/core/widgets/form/app_location_picker/app_location_picker.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/delivery_man/deliveries/delivery_man_pickup_controller.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/delivery_man/orders/delivery_man_orders_controller.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/delivery_man/orders/delivery_man_order_detail_controller.dart';

/// Pickup flow: Order Items (always), Select Warehouse when no delivery, quantities when delivery exists, GPS (AppLocationPicker), Confirm.
class PickupFormContent extends StatefulWidget {
  const PickupFormContent({super.key, required this.controller});

  final DeliveryManPickupController controller;

  @override
  State<PickupFormContent> createState() => _PickupFormContentState();
}

class _PickupFormContentState extends State<PickupFormContent> {
  final gpsLat = ''.obs;
  final gpsLng = ''.obs;

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;
    final order = controller.order;
    if (order == null) return const SizedBox.shrink();

    return SingleChildScrollView(
      padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
      child: Obx(() {
        final d = controller.delivery.value;
        final selectedWarehouse = controller.warehouses
            .where((w) => w.id == controller.selectedWarehouseId.value)
            .firstOrNull;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (d == null)
              PickupOrderItemsSection(
                order: order,
                selectedWarehouse: selectedWarehouse,
                controller: controller,
              )
            else
              PickupQuantitiesSection(
                order: order,
                selectedWarehouse: selectedWarehouse,
                deliveryItems: d.deliveryItems ?? [],
                controller: controller,
              ),
            AppSpacing.vertical(context, 0.02),
            if (d == null) PickupWarehouseSection(controller: controller),
            if (d == null) AppSpacing.vertical(context, 0.02),
            Obx(
              () => AppLocationPicker(
                label: AppTexts.gpsLocationOptional,
                required: false,
                lat: gpsLat.value,
                lng: gpsLng.value,
                onLocationSelected: (lat, lng) {
                  gpsLat.value = lat.toString();
                  gpsLng.value = lng.toString();
                },
                onLocationCleared: () {
                  gpsLat.value = '';
                  gpsLng.value = '';
                },
              ),
            ),
            AppSpacing.vertical(context, 0.02),
            Obx(
              () => AppButton(
                icon: Iconsax.tick_circle,
                label: AppTexts.confirmPickup,
                isLoading: controller.isSubmitting.value,
                onPressed: () => _submitPickup(context),
              ),
            ),
          ],
        );
      }),
    );
  }

  Future<void> _submitPickup(BuildContext context) async {
    final lat = double.tryParse(gpsLat.value.trim());
    final lng = double.tryParse(gpsLng.value.trim());
    try {
      final deliveryAfterPickup = await widget.controller.submitPickup(
        lat: lat,
        lng: lng,
      );
      if (deliveryAfterPickup == null) return;

      // Keep any existing order-detail screen in sync with latest delivery status.
      if (Get.isRegistered<DeliveryManOrderDetailController>()) {
        final detailController = Get.find<DeliveryManOrderDetailController>();
        detailController.delivery = deliveryAfterPickup;
        detailController.update();
      }

      // Navigate via main delivery-man shell so bottom navigation is visible, focusing Orders tab.
      Get.offAllNamed(AppRoutes.dmMain, arguments: {'initialIndex': 1});
      Future.microtask(() {
        if (Get.isRegistered<DeliveryManOrdersController>()) {
          Get.find<DeliveryManOrdersController>().loadOrders();
        }
      });
    } catch (_) {
      AppToast.showError(AppTexts.error, AppTexts.requestFailedTryAgain);
    }
  }
}
