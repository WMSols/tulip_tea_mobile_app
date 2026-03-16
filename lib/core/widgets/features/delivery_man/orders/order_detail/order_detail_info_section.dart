import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_formatter/app_formatter.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_detail_row.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_section_card.dart';
import 'package:tulip_tea_mobile_app/domain/entities/order_for_delivery_man.dart';

/// Order detail info card: Order ID, Order Booker, Address, Owner, Final Total Amount.
class OrderDetailInfoSection extends StatelessWidget {
  const OrderDetailInfoSection({super.key, required this.order});

  final OrderForDeliveryMan order;

  @override
  Widget build(BuildContext context) {
    final amount =
        order.finalTotalAmount ??
        order.calculatedTotalAmount ??
        order.totalAmount ??
        0.0;
    return AppSectionCard(
      icon: Iconsax.document_text,
      title: AppTexts.orderDetails,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppDetailRow(
            icon: Iconsax.hashtag,
            label: AppTexts.orderId,
            value: '${order.id}',
          ),
          if (order.orderBookerName != null)
            AppDetailRow(
              icon: Iconsax.user,
              label: AppTexts.orderBookerLabel,
              value: order.orderBookerName!,
            ),
          if (order.shopAddress != null && order.shopAddress!.isNotEmpty)
            AppDetailRow(
              icon: Iconsax.location,
              label: AppTexts.address,
              value: order.shopAddress!,
            ),
          if (order.shopOwner != null && order.shopOwner!.isNotEmpty)
            AppDetailRow(
              icon: Iconsax.user,
              label: AppTexts.owner,
              value: order.shopOwner!,
            ),
          AppDetailRow(
            icon: Iconsax.money_recive,
            label: AppTexts.finalTotalAmount,
            value:
                '${AppTexts.rupeeSymbol} ${AppFormatter.formatCurrency(amount)}',
          ),
        ],
      ),
    );
  }
}
