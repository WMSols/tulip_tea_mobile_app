import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_lotties/app_lotties.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/buttons/app_button.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_section_card.dart';
import 'package:tulip_tea_mobile_app/core/widgets/feedback/app_toast.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/order_booker/visits/visit_register/shop_credit_info_card.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/order_booker/visits/visit_register/impact_preview.dart';
import 'package:tulip_tea_mobile_app/core/widgets/form/app_text_field/app_text_field.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/delivery_man/daily_collection_controller.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/delivery_man/orders/delivery_man_orders_controller.dart';
import 'package:tulip_tea_mobile_app/presentation/routes/app_routes.dart';

/// Daily Collection screen body: Shop Credit Information, Collection Amount, Remarks, Submit.
class DailyCollectionContent extends StatefulWidget {
  const DailyCollectionContent({super.key, required this.controller});

  final DailyCollectionController controller;

  @override
  State<DailyCollectionContent> createState() => _DailyCollectionContentState();
}

class _DailyCollectionContentState extends State<DailyCollectionContent> {
  late final TextEditingController _amountController;
  late final TextEditingController _remarksController;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController(text: '');
    // Seed controller with initial amount so impact preview can reflect it.
    widget.controller.setCollectionAmount(_amountController.text);
    _remarksController = TextEditingController();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;
    return SingleChildScrollView(
      padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Obx(() {
            if (controller.isLoadingCredit.value) {
              return AppSectionCard(
                icon: Iconsax.wallet_money,
                title: AppTexts.shopCreditInformation,
                titleColor: AppColors.primary,
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
              );
            }
            final info = controller.creditInfo.value;
            if (info == null) {
              return AppSectionCard(
                icon: Iconsax.wallet_money,
                title: AppTexts.shopCreditInformation,
                child: const Center(child: Text(AppTexts.notAvailable)),
              );
            }
            return ShopCreditInfoCard(info: info, showRemarkBanner: false);
          }),
          AppSpacing.vertical(context, 0.02),
          AppSectionCard(
            icon: Iconsax.wallet_3,
            title: AppTexts.collectionDetails,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppTextField(
                  label: AppTexts.collectionAmountRs,
                  required: true,
                  prefixIcon: Iconsax.wallet_money,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  controller: _amountController,
                  onChanged: controller.setCollectionAmount,
                ),
                AppSpacing.vertical(context, 0.015),
                Obx(() {
                  if (controller.isLoadingCredit.value) {
                    return const SizedBox.shrink();
                  }
                  final info = controller.creditInfo.value;
                  final amountStr = controller.collectionAmount.value;
                  return ImpactPreview(
                    info: info,
                    collectionAmountStr: amountStr,
                  );
                }),
                AppSpacing.vertical(context, 0.015),
                AppTextField(
                  label: AppTexts.remarks,
                  hint: AppTexts.addNotesAboutCollection,
                  prefixIcon: Iconsax.note,
                  maxLines: 3,
                  controller: _remarksController,
                ),
              ],
            ),
          ),
          AppSpacing.vertical(context, 0.02),
          Obx(
            () => AppButton(
              icon: Iconsax.tick_circle,
              label: AppTexts.submitCollection,
              isLoading: controller.isSubmitting.value,
              onPressed: controller.isSubmitting.value
                  ? null
                  : () => _submit(context),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submit(BuildContext context) async {
    final amountVal = double.tryParse(_amountController.text.trim()) ?? 0.0;
    final remarks = _remarksController.text.trim();
    try {
      final ok = await widget.controller.submit(
        amount: amountVal,
        remarks: remarks.isEmpty ? null : remarks,
      );
      if (ok) {
        final args = Get.arguments;
        if (args is Map && args['fromDeliverFlow'] == true) {
          // From Deliver flow: go straight to Deliver screen for this order.
          Get.offNamed(
            AppRoutes.dmDeliveryDeliver,
            arguments: {'order': args['order'], 'delivery': args['delivery']},
          );
        } else {
          // Default: navigate via main shell to Orders tab and refresh orders.
          Get.offAllNamed(AppRoutes.dmMain, arguments: {'initialIndex': 1});
          Future.microtask(() {
            if (Get.isRegistered<DeliveryManOrdersController>()) {
              Get.find<DeliveryManOrdersController>().loadOrders();
            }
          });
        }
      }
    } catch (_) {
      AppToast.showError(AppTexts.error, AppTexts.requestFailedTryAgain);
    }
  }
}
