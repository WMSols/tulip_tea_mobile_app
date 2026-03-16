import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_formatter/app_formatter.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_detail_row.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_status_chip.dart';
import 'package:tulip_tea_mobile_app/domain/entities/order_for_delivery_man.dart';

/// Reusable subsidy and discount section for delivery detail.
class DeliveryDetailSubsidySection extends StatelessWidget {
  const DeliveryDetailSubsidySection({super.key, required this.order});

  final OrderForDeliveryMan order;

  @override
  Widget build(BuildContext context) {
    final calculated = order.calculatedTotalAmount ?? order.totalAmount;
    final finalTotal = order.finalTotalAmount ?? calculated;
    final discount = (calculated != null && finalTotal != null)
        ? (calculated - finalTotal)
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (calculated != null)
          AppDetailRow(
            icon: Iconsax.money_recive,
            label: AppTexts.calculatedTotal,
            value:
                '${AppTexts.rupeeSymbol} ${AppFormatter.formatCurrency(calculated)}',
          ),
        if (finalTotal != null) ...[
          if (calculated != null) AppSpacing.vertical(context, 0.008),
          AppDetailRow(
            icon: Iconsax.discount_shape,
            label: AppTexts.finalTotalAmount,
            value:
                '${AppTexts.rupeeSymbol} ${AppFormatter.formatCurrency(finalTotal)}',
            valueColor: AppColors.success,
          ),
        ],
        if (discount != null && discount > 0) ...[
          AppSpacing.vertical(context, 0.008),
          AppDetailRow(
            icon: Iconsax.money_tick,
            label: AppTexts.discountAmount,
            value:
                '${AppTexts.rupeeSymbol} ${AppFormatter.formatCurrency(discount)}',
            valueColor: AppColors.success,
          ),
        ],
        if (order.subsidyStatus != null) ...[
          AppSpacing.vertical(context, 0.008),
          AppDetailRow(
            icon: Iconsax.verify,
            label: AppTexts.subsidyLabel,
            value: order.subsidyStatus!,
            valueChild: AppStatusChip(status: order.subsidyStatus!),
          ),
        ],
        if (order.subsidyApprovedAt != null) ...[
          AppSpacing.vertical(context, 0.008),
          AppDetailRow(
            icon: Iconsax.calendar_tick,
            label: AppTexts.approvedAt,
            value: AppFormatter.dateTimeFromString(order.subsidyApprovedAt!),
          ),
        ],
      ],
    );
  }
}
