import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_formatter/app_formatter.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_detail_row.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_section_card.dart';
import 'package:tulip_tea_mobile_app/domain/entities/order_entity.dart';
import 'package:tulip_tea_mobile_app/domain/entities/order_for_delivery_man.dart';

/// Order items section: one AppSectionCard with separate AppDetailRow per field per item.
class OrderDetailOrderItemsSection extends StatelessWidget {
  const OrderDetailOrderItemsSection({
    super.key,
    required this.order,
    required this.title,
  });

  final OrderForDeliveryMan order;
  final String title;

  @override
  Widget build(BuildContext context) {
    final items = order.orderItems;
    return AppSectionCard(
      icon: Iconsax.box_1,
      title: title,
      child: (items == null || items.isEmpty)
          ? Text(
              AppTexts.noOrderItemsRecorded,
              style: AppTextStyles.hintText(context),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < items.length; i++) ...[
                  ..._itemRows(context, items[i]),
                  if (i < items.length - 1) AppSpacing.vertical(context, 0.01),
                  Divider(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    height: 1,
                  ),
                  AppSpacing.vertical(context, 0.01),
                ],
              ],
            ),
    );
  }

  List<Widget> _itemRows(BuildContext context, OrderItem e) {
    final name = e.productName ?? AppTexts.productFallbackLabel;
    final qty = e.quantity ?? 0;
    final unit = e.unitPrice ?? 0.0;
    final total = e.totalPrice ?? (qty * unit);
    return [
      AppDetailRow(
        icon: Iconsax.box_1,
        label: AppTexts.productName,
        value: name,
      ),
      AppSpacing.vertical(context, 0.008),
      AppDetailRow(
        icon: Iconsax.hashtag,
        label: AppTexts.quantity,
        value: '$qty',
      ),
      AppSpacing.vertical(context, 0.008),
      AppDetailRow(
        icon: Iconsax.money_recive,
        label: AppTexts.unitPrice,
        value: AppFormatter.formatCurrency(unit),
      ),
      AppSpacing.vertical(context, 0.008),
      AppDetailRow(
        icon: Iconsax.money_tick,
        label: AppTexts.total,
        value: AppFormatter.formatCurrency(total),
      ),
    ];
  }
}
