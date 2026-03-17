import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_lotties/app_lotties.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/buttons/app_button.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_section_card.dart';
import 'package:tulip_tea_mobile_app/core/widgets/feedback/app_toast.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/delivery_man/deliveries/deliver/deliver_quantities_section.dart';
import 'package:tulip_tea_mobile_app/core/widgets/form/app_location_picker/app_location_picker.dart';
import 'package:tulip_tea_mobile_app/core/widgets/form/app_text_field/app_text_field.dart';
import 'package:tulip_tea_mobile_app/core/widgets/form/app_image_picker/app_image_picker.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/delivery_man/deliveries/delivery_man_deliver_controller.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/delivery_man/orders/delivery_man_orders_controller.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/delivery_man/orders/delivery_man_order_detail_controller.dart';
import 'package:tulip_tea_mobile_app/presentation/routes/app_routes.dart';

/// Deliver flow: Order Items, GPS (AppLocationPicker), Delivery Proof (AppImagePicker), Remarks (AppTextField), Confirm.
class DeliverFormContent extends StatefulWidget {
  const DeliverFormContent({super.key, required this.controller});

  final DeliveryManDeliverController controller;

  @override
  State<DeliverFormContent> createState() => _DeliverFormContentState();
}

class _DeliverFormContentState extends State<DeliverFormContent> {
  late final TextEditingController _remarksController;
  final gpsLat = ''.obs;
  final gpsLng = ''.obs;
  final deliveryProofPath = Rxn<String>();

  @override
  void initState() {
    super.initState();
    _remarksController = TextEditingController();
  }

  @override
  void dispose() {
    _remarksController.dispose();
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
              title: AppTexts.orderItemsSection,
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
            DeliverQuantitiesSection(
              deliveryItems: items,
              controller: widget.controller,
              order: widget.controller.order,
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
          AppSectionCard(
            icon: Iconsax.gallery,
            title: AppTexts.deliveryProofImagesOptional,
            child: Obx(
              () => AppImagePicker(
                label: AppTexts.deliveryProof,
                required: false,
                currentPath: deliveryProofPath.value,
                onPicked: (path) => deliveryProofPath.value = path,
                onRemove: () => deliveryProofPath.value = null,
              ),
            ),
          ),
          AppSpacing.vertical(context, 0.02),
          AppSectionCard(
            icon: Iconsax.note_text,
            title: AppTexts.deliveryRemarksOptional,
            child: AppTextField(
              label: AppTexts.remarks,
              hint: AppTexts.addNotesAboutDelivery,
              maxLines: 3,
              prefixIcon: Iconsax.note,
              controller: _remarksController,
            ),
          ),
          AppSpacing.vertical(context, 0.02),
          Obx(() {
            final order = widget.controller.order;
            final isPaymentBeforeDelivery =
                (order?.orderResolutionType ?? '').toLowerCase() ==
                'payment_before_delivery';
            final hasCollected =
                order?.paymentCollectedBeforeDelivery == true ||
                order?.paymentCollectedAt != null ||
                (order?.paymentCollectedAmount != null &&
                    order!.paymentCollectedAmount! > 0);
            final confirmDeliveryDisabled =
                isPaymentBeforeDelivery && !hasCollected;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (isPaymentBeforeDelivery) ...[
                  AppButton(
                    icon: Iconsax.wallet_3,
                    label: AppTexts.dailyCollectionLabel,
                    onPressed: hasCollected
                        ? null
                        : () => Get.toNamed(
                            AppRoutes.dmDailyCollection,
                            arguments: {
                              'order': order,
                              'delivery': widget.controller.delivery,
                              'fromDeliverFlow': true,
                            },
                          ),
                  ),
                  AppSpacing.vertical(context, 0.01),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          hasCollected
                              ? Iconsax.tick_circle
                              : Iconsax.warning_2,
                          size: AppResponsive.iconSize(context),
                          color: hasCollected
                              ? AppColors.success
                              : AppColors.error,
                        ),
                        AppSpacing.horizontal(context, 0.01),
                        Expanded(
                          child: Text(
                            hasCollected
                                ? AppTexts.dailyCollectionDoneProceedDelivery
                                : AppTexts.recordDailyCollectionFirst,
                            style: AppTextStyles.hintText(context).copyWith(
                              color: hasCollected
                                  ? AppColors.success
                                  : AppColors.error,
                              height: 1.1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                AppButton(
                  icon: Iconsax.tick_circle,
                  label: AppTexts.confirmDelivery,
                  isLoading: widget.controller.isSubmitting.value,
                  onPressed: confirmDeliveryDisabled
                      ? null
                      : () => _submitDeliver(context),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Future<void> _submitDeliver(BuildContext context) async {
    final lat = double.tryParse(gpsLat.value.trim());
    final lng = double.tryParse(gpsLng.value.trim());
    final remarks = _remarksController.text.trim();
    final images = <String>[];
    if (deliveryProofPath.value != null &&
        deliveryProofPath.value!.isNotEmpty) {
      images.add(deliveryProofPath.value!);
    }
    try {
      final updated = await widget.controller.submitDeliver(
        lat: lat,
        lng: lng,
        remarks: remarks.isEmpty ? null : remarks,
        imageUrls: images.isEmpty ? null : images,
      );
      if (updated == null) return;

      // Keep any existing order-detail screen in sync with latest delivery status.
      if (Get.isRegistered<DeliveryManOrderDetailController>()) {
        final detailController = Get.find<DeliveryManOrderDetailController>();
        detailController.delivery = updated;
        detailController.update();
      }

      final order = widget.controller.order;
      if (order != null) {
        // From Orders flow: go back to main shell with Orders tab selected.
        Get.offAllNamed(AppRoutes.dmMain, arguments: {'initialIndex': 1});
      } else {
        Get.back(result: true);
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
