import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/buttons/app_button.dart';
import 'package:tulip_tea_mobile_app/domain/entities/order_for_delivery_man.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/delivery_man/orders/delivery_man_order_detail_controller.dart';
import 'package:tulip_tea_mobile_app/presentation/routes/app_routes.dart';

/// Order detail action buttons by delivery status.
class OrderDetailActionsSection extends StatelessWidget {
  const OrderDetailActionsSection({
    super.key,
    required this.order,
    required this.controller,
  });

  final OrderForDeliveryMan order;
  final DeliveryManOrderDetailController controller;

  @override
  Widget build(BuildContext context) {
    final isPaymentBeforeDelivery =
        (order.orderResolutionType ?? '').toLowerCase() ==
        'payment_before_delivery';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (controller.canOnboardStock)
          AppButton(
            icon: Iconsax.box_tick,
            label: AppTexts.onboardStockLabel,
            onPressed: () => Get.toNamed(
              AppRoutes.dmDeliveryPickup,
              arguments: {'order': order, 'delivery': controller.delivery},
            ),
          ),
        if (controller.canDeliverToShop) ...[
          AppSpacing.vertical(context, 0.01),
          if (!isPaymentBeforeDelivery) ...[
            AppButton(
              icon: Iconsax.wallet_3,
              label: AppTexts.dailyCollectionLabel,
              onPressed: () =>
                  Get.toNamed(AppRoutes.dmDailyCollection, arguments: order),
            ),
            AppSpacing.vertical(context, 0.01),
          ],
          AppButton(
            icon: Iconsax.truck,
            label: AppTexts.deliverToShop,
            onPressed: () => Get.toNamed(
              AppRoutes.dmDeliveryDeliver,
              arguments: {'order': order, 'delivery': controller.delivery},
            ),
          ),
        ],
        if (controller.canUpdateDelivery)
          AppButton(
            icon: Iconsax.truck,
            label: AppTexts.updateDeliveryLabel,
            onPressed: () => Get.toNamed(
              AppRoutes.dmDeliveryDeliver,
              arguments: {'order': order, 'delivery': controller.delivery},
            ),
          ),
        AppSpacing.vertical(context, 0.01),
        if (controller.canReturnRemainingStock)
          AppButton(
            icon: Iconsax.arrow_left,
            label: AppTexts.returnRemainingStockLabel,
            onPressed: () => Get.toNamed(
              AppRoutes.dmDeliveryReturn,
              arguments: {'order': order, 'delivery': controller.delivery},
            ),
          ),
        if (controller.isFullyDelivered) ...[
          AppSpacing.vertical(context, 0.01),
          Text(
            AppTexts.orderFullyDeliveredMessage,
            style: AppTextStyles.bodyText(
              context,
            ).copyWith(color: AppColors.success, fontWeight: FontWeight.w500),
          ),
        ],
      ],
    );
  }

  // static bool _deliverDisabled(OrderForDeliveryMan order) {
  //   // Temporary relaxation: treat payment_before_delivery same as normal,
  //   // never disable Deliver to Shop based on payment collection.
  //   return false;
  // }
}
