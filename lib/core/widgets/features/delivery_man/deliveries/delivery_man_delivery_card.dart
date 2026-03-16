import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_formatter/app_formatter.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_fonts/app_fonts.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_info_card.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_status_chip.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/delivery_man/deliveries/delivery_man_deliveries_controller.dart';
import 'package:tulip_tea_mobile_app/presentation/routes/app_routes.dart';

/// Card for one delivery in the Deliveries tab (completed deliveries).
class DeliveryManDeliveryCard extends StatelessWidget {
  const DeliveryManDeliveryCard({super.key, required this.item});

  final DeliveryListItem item;

  @override
  Widget build(BuildContext context) {
    final order = item.order;
    final delivery = item.delivery;
    final shopName = order.shopName ?? '${AppTexts.shopName} #${order.id}';
    final amount =
        order.finalTotalAmount ??
        order.calculatedTotalAmount ??
        order.totalAmount ??
        0.0;
    final status = delivery.status ?? order.status ?? AppTexts.dateTimeUnset;

    return AppInfoCard(
      onTap: () => Get.toNamed(AppRoutes.dmDeliveryDetail, arguments: item),
      padding: AppSpacing.symmetric(context, h: 0.02, v: 0.01),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        shopName,
                        style: AppTextStyles.bodyText(context).copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                          fontFamily: AppFonts.primaryFont,
                        ),
                      ),
                    ),
                    AppStatusChip(status: status),
                  ],
                ),
                AppSpacing.vertical(context, 0.004),
                Text(
                  AppFormatter.formatCurrency(amount),
                  style: AppTextStyles.bodyText(context).copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
                if (delivery.pickupDate != null)
                  Text(
                    '${AppTexts.pickupAtLabel}: ${AppFormatter.dateTime(delivery.pickupDate!)}',
                    style: AppTextStyles.hintText(
                      context,
                    ).copyWith(fontSize: AppResponsive.scaleSize(context, 12)),
                  ),
                if (delivery.deliveryDate != null)
                  Text(
                    '${AppTexts.deliveredAtLabel}: ${AppFormatter.dateTime(delivery.deliveryDate!)}',
                    style: AppTextStyles.hintText(
                      context,
                    ).copyWith(fontSize: AppResponsive.scaleSize(context, 12)),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
