import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_section_card.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/delivery_man/deliveries/delivery_detail/delivery_detail_subsidy_section.dart';
import 'package:tulip_tea_mobile_app/domain/entities/order_for_delivery_man.dart';

/// Subsidy & Discount Information card when order has subsidy/discount data.
class OrderDetailSubsidySection extends StatelessWidget {
  const OrderDetailSubsidySection({super.key, required this.order});

  final OrderForDeliveryMan order;

  static bool shouldShow(OrderForDeliveryMan order) {
    if (order.subsidyStatus != null &&
        order.subsidyStatus!.toLowerCase() != 'none') {
      return true;
    }
    final calculated = order.calculatedTotalAmount ?? order.totalAmount;
    final finalTotal = order.finalTotalAmount ?? calculated;
    if (calculated != null && finalTotal != null && calculated > finalTotal) {
      return true;
    }
    if (order.calculatedTotalAmount != null ||
        order.finalTotalAmount != null ||
        order.totalAmount != null) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppSpacing.vertical(context, 0.02),
        AppSectionCard(
          icon: Iconsax.discount_shape,
          title: AppTexts.subsidyAndDiscountInfo,
          child: DeliveryDetailSubsidySection(order: order),
        ),
      ],
    );
  }
}
