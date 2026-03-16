import 'package:flutter/material.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/domain/entities/order_entity.dart';
import 'package:tulip_tea_mobile_app/domain/entities/order_for_delivery_man.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/delivery_man/orders/delivery_man_order_detail_controller.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/delivery_man/orders/order_detail/order_detail_actions_section.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/delivery_man/orders/order_detail/order_detail_delivery_section.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/delivery_man/orders/order_detail/order_detail_info_section.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/delivery_man/orders/order_detail/order_detail_order_items_section.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/delivery_man/orders/order_detail/order_detail_subsidy_section.dart';

/// Scrollable order detail body composed of reusable sections.
class OrderDetailContent extends StatelessWidget {
  const OrderDetailContent({
    super.key,
    required this.order,
    required this.controller,
  });

  final OrderForDeliveryMan order;
  final DeliveryManOrderDetailController controller;

  @override
  Widget build(BuildContext context) {
    final orderItemsTitle = _orderItemsSectionTitle(order.orderItems);

    return SingleChildScrollView(
      padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          OrderDetailInfoSection(order: order),
          AppSpacing.vertical(context, 0.02),
          OrderDetailOrderItemsSection(order: order, title: orderItemsTitle),
          if (OrderDetailSubsidySection.shouldShow(order))
            OrderDetailSubsidySection(order: order),
          if (controller.delivery != null) ...[
            AppSpacing.vertical(context, 0.02),
            OrderDetailDeliverySection(delivery: controller.delivery!),
          ],
          AppSpacing.vertical(context, 0.03),
          OrderDetailActionsSection(order: order, controller: controller),
        ],
      ),
    );
  }

  static String _orderItemsSectionTitle(List<OrderItem>? items) {
    final count = items?.length ?? 0;
    if (count == 0) return AppTexts.orderItemsDuringVisit;
    return '${AppTexts.orderItemsDuringVisit} ($count)';
  }
}
