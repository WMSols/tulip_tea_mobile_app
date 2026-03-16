import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_lotties/app_lotties.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/buttons/app_button.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_section_card.dart';
import 'package:tulip_tea_mobile_app/core/widgets/feedback/app_toast.dart';
import 'package:tulip_tea_mobile_app/core/widgets/form/app_location_picker/app_location_picker.dart';
import 'package:tulip_tea_mobile_app/core/widgets/form/app_text_field/app_text_field.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/delivery_man/deliveries/return/return_quantities_section.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/delivery_man/deliveries/delivery_man_return_controller.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/delivery_man/orders/delivery_man_order_detail_controller.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/delivery_man/orders/delivery_man_orders_controller.dart';
import 'package:tulip_tea_mobile_app/presentation/routes/app_routes.dart';

/// Return flow: quantities section, reason field, GPS (AppLocationPicker), confirm.
class ReturnFormContent extends StatefulWidget {
  const ReturnFormContent({super.key, required this.controller});

  final DeliveryManReturnController controller;

  @override
  State<ReturnFormContent> createState() => _ReturnFormContentState();
}

class _ReturnFormContentState extends State<ReturnFormContent> {
  late final TextEditingController _reasonController;
  final gpsLat = ''.obs;
  final gpsLng = ''.obs;

  @override
  void initState() {
    super.initState();
    _reasonController = TextEditingController();
  }

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final delivery = widget.controller.delivery;
    if (delivery == null) return const SizedBox.shrink();

    final isLoadingItems = widget.controller.isLoadingItems;
    final items = delivery.deliveryItems ?? [];
    final showItemsLoading = isLoadingItems && items.isEmpty;

    return SingleChildScrollView(
      padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (showItemsLoading)
            AppSectionCard(
              icon: Iconsax.box_1,
              title: AppTexts.itemsToReturnTitle,
              child: Center(
                child: Padding(
                  padding: AppSpacing.symmetric(context, v: 0.03),
                  child: SizedBox(
                    width: AppResponsive.scaleSize(context, 36),
                    height: AppResponsive.scaleSize(context, 36),
                    child: Lottie.asset(AppLotties.loadingPrimary),
                  ),
                ),
              ),
            )
          else
            ReturnQuantitiesSection(
              deliveryItems: items,
              controller: widget.controller,
              order: widget.controller.order,
            ),
          AppSpacing.vertical(context, 0.02),
          AppSectionCard(
            icon: Iconsax.note_text,
            title: AppTexts.returnReasonLabel,
            child: AppTextField(
              label: AppTexts.returnReasonLabel,
              hint: AppTexts.returnReasonHint,
              required: true,
              prefixIcon: Iconsax.note,
              maxLines: 3,
              controller: _reasonController,
            ),
          ),
          AppSpacing.vertical(context, 0.02),
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
              icon: Iconsax.arrow_left,
              label: AppTexts.confirmReturn,
              isLoading: widget.controller.isSubmitting.value,
              onPressed: () => _submitReturn(context),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submitReturn(BuildContext context) async {
    final reason = _reasonController.text.trim();
    if (reason.isEmpty) {
      AppToast.showWarning(AppTexts.warning, AppTexts.pleaseEnterReturnReason);
      return;
    }
    final lat = double.tryParse(gpsLat.value.trim());
    final lng = double.tryParse(gpsLng.value.trim());
    try {
      final updated = await widget.controller.submitReturn(
        lat: lat,
        lng: lng,
        reason: reason,
      );
      if (updated == null) return;
      final order = widget.controller.order;
      if (order != null) {
        // Keep any existing order-detail screen in sync with latest delivery status.
        if (Get.isRegistered<DeliveryManOrderDetailController>()) {
          final detailController = Get.find<DeliveryManOrderDetailController>();
          detailController.delivery = updated;
          detailController.update();
        }

        // From Orders flow: go back to main shell with Orders tab selected.
        Get.offAllNamed(AppRoutes.dmMain, arguments: {'initialIndex': 1});
      } else {
        Get.back(result: true);
      }
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
