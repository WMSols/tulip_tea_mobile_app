import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_formatter/app_formatter.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_fonts/app_fonts.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_helper/app_helper.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_info_card.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_status_chip.dart';
import 'package:tulip_tea_mobile_app/data/models/delivery/delivery_model.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/delivery_man/orders/delivery_man_orders_controller.dart';
import 'package:tulip_tea_mobile_app/presentation/routes/app_routes.dart';

/// Card for one active order in delivery man Orders tab. Taps to order detail.
class DeliveryManOrderCard extends StatelessWidget {
  const DeliveryManOrderCard({super.key, required this.item});

  final OrderWithDeliveryItem item;

  static String _orderTypeLabel(String? resolutionType) {
    if (resolutionType == null || resolutionType.isEmpty) return 'Normal';
    final s = resolutionType.toLowerCase();
    if (s == 'payment_before_delivery') {
      return AppTexts.paymentBeforeDeliveryTag;
    }
    if (s.contains('subsidy')) return AppTexts.subsidyLabel;
    return AppHelper.snakeToTitle(resolutionType);
  }

  static Color _resolutionChipColor(String? resolutionType) {
    if (resolutionType == null || resolutionType.isEmpty) return AppColors.grey;
    final s = resolutionType.toLowerCase();
    if (s == 'payment_before_delivery') return AppColors.warning;
    if (s == 'normal') return AppColors.success;
    if (s.contains('subsidy')) return AppColors.information;
    return AppColors.grey;
  }

  static IconData _resolutionChipIcon(String? resolutionType) {
    if (resolutionType == null || resolutionType.isEmpty) return Iconsax.box;
    final s = resolutionType.toLowerCase();
    if (s == 'payment_before_delivery') return Iconsax.wallet_money;
    if (s.contains('subsidy')) return Iconsax.discount_shape;
    return Iconsax.box;
  }

  @override
  Widget build(BuildContext context) {
    final order = item.order;
    final shopName = order.shopName ?? '${AppTexts.shopName} #${order.id}';
    final amount =
        order.finalTotalAmount ??
        order.calculatedTotalAmount ??
        order.totalAmount ??
        0.0;
    final delivery = item.delivery;
    final hasTimeline =
        delivery?.pickupDate != null ||
        delivery?.deliveryDate != null ||
        delivery?.returnDate != null;

    return AppInfoCard(
      onTap: () => Get.toNamed(
        AppRoutes.dmOrderDetail,
        arguments: {'order': order, 'delivery': item.delivery},
      ),
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
                    AppStatusChip(
                      status: item.deliveryStatus,
                      text: AppHelper.dmDeliveryStatusLabel(
                        item.deliveryStatus,
                      ),
                      backgroundColor: AppHelper.dmDeliveryStatusChipColor(
                        item.deliveryStatus,
                      ),
                      icon: AppHelper.dmDeliveryStatusChipIcon(
                        item.deliveryStatus,
                      ),
                    ),
                  ],
                ),
                if (order.orderBookerName != null &&
                    order.orderBookerName!.isNotEmpty) ...[
                  AppSpacing.vertical(context, 0.004),
                  Text(
                    '${AppTexts.orderBookerLabel}: ${order.orderBookerName}',
                    style: AppTextStyles.hintText(
                      context,
                    ).copyWith(fontSize: AppResponsive.scaleSize(context, 12)),
                  ),
                ],
                if (hasTimeline && delivery != null) ...[
                  AppSpacing.vertical(context, 0.002),
                  Text(
                    _timelineSummary(delivery),
                    style: AppTextStyles.hintText(
                      context,
                    ).copyWith(fontSize: AppResponsive.scaleSize(context, 11)),
                  ),
                ],
                Text(
                  AppFormatter.formatCurrency(amount),
                  style: AppTextStyles.bodyText(context).copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
                if (order.orderResolutionType != null &&
                    order.orderResolutionType!.isNotEmpty) ...[
                  AppSpacing.vertical(context, 0.004),
                  AppStatusChip(
                    status: order.orderResolutionType ?? '',
                    text: _orderTypeLabel(order.orderResolutionType),
                    backgroundColor: _resolutionChipColor(
                      order.orderResolutionType,
                    ),
                    icon: _resolutionChipIcon(order.orderResolutionType),
                  ),
                ],
              ],
            ),
          ),
          Icon(
            Iconsax.arrow_right_3,
            size: AppResponsive.iconSize(context, factor: 1.1),
            color: AppColors.primary,
          ),
        ],
      ),
    );
  }

  static String _timelineSummary(DeliveryModel delivery) {
    if (delivery.returnDate != null) {
      return '${AppTexts.returnedAtLabel}: ${AppFormatter.dateTime(delivery.returnDate!)}';
    }
    if (delivery.deliveryDate != null) {
      return '${AppTexts.deliveredAtLabel}: ${AppFormatter.dateTime(delivery.deliveryDate!)}';
    }
    if (delivery.pickupDate != null) {
      return '${AppTexts.pickupAtLabel}: ${AppFormatter.dateTime(delivery.pickupDate!)}';
    }
    return '';
  }
}
