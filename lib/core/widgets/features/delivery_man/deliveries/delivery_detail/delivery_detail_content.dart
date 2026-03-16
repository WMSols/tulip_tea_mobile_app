import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_formatter/app_formatter.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_detail_row.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_section_card.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_status_chip.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/delivery_man/deliveries/delivery_detail/delivery_detail_subsidy_section.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/delivery_man/deliveries/delivery_detail/delivery_detail_timeline.dart';
import 'package:tulip_tea_mobile_app/data/models/delivery/delivery_model.dart';
import 'package:tulip_tea_mobile_app/domain/entities/order_entity.dart';
import 'package:tulip_tea_mobile_app/domain/entities/order_for_delivery_man.dart';

/// Full delivery detail body: order info, timeline, delivery/order items tables, subsidy.
class DeliveryDetailContent extends StatelessWidget {
  const DeliveryDetailContent({
    super.key,
    required this.order,
    required this.delivery,
  });

  final OrderForDeliveryMan order;
  final DeliveryModel delivery;

  @override
  Widget build(BuildContext context) {
    final shopName =
        order.shopName ?? '${AppTexts.shopName} #${order.shopId ?? order.id}';
    final amount =
        order.finalTotalAmount ??
        order.calculatedTotalAmount ??
        order.totalAmount ??
        0.0;
    final status = delivery.status ?? order.status ?? AppTexts.dateTimeUnset;
    final deliveryItems = delivery.deliveryItems ?? [];

    return SingleChildScrollView(
      padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppSectionCard(
            icon: Iconsax.document_text,
            title: AppTexts.orderDetails,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppDetailRow(
                  icon: Iconsax.shop,
                  label: AppTexts.shopName,
                  value: shopName,
                ),
                AppSpacing.vertical(context, 0.01),
                AppDetailRow(
                  icon: Iconsax.money_recive,
                  label: AppTexts.finalTotalAmount,
                  value:
                      '${AppTexts.rupeeSymbol} ${AppFormatter.formatCurrency(amount)}',
                ),
                AppSpacing.vertical(context, 0.01),
                AppDetailRow(
                  icon: Iconsax.info_circle,
                  label: AppTexts.status,
                  value: status,
                  valueChild: AppStatusChip(status: status),
                ),
              ],
            ),
          ),
          AppSpacing.vertical(context, 0.02),
          AppSectionCard(
            icon: Iconsax.clock,
            title: AppTexts.completeDeliveryTimeline,
            child: DeliveryDetailTimeline(delivery: delivery),
          ),
          // Delivery items — separate AppDetailRow per field per item
          AppSpacing.vertical(context, 0.02),
          AppSectionCard(
            icon: Iconsax.box_1,
            title: deliveryItems.isEmpty
                ? AppTexts.deliveryItemsDetails
                : '${AppTexts.deliveryItemsDetails} (${deliveryItems.length})',
            child: deliveryItems.isEmpty
                ? Text(
                    AppTexts.noDeliveryItemsRecorded,
                    style: AppTextStyles.hintText(context),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var i = 0; i < deliveryItems.length; i++) ...[
                        if (i > 0) ...[
                          AppSpacing.vertical(context, 0.01),
                          Divider(
                            color: AppColors.primary.withValues(alpha: 0.3),
                            height: 1,
                          ),
                          AppSpacing.vertical(context, 0.01),
                        ],
                        AppDetailRow(
                          icon: Iconsax.box_1,
                          label: AppTexts.itemColumn,
                          value: _deliveryItemLabel(deliveryItems[i]),
                        ),
                        AppSpacing.vertical(context, 0.008),
                        AppDetailRow(
                          icon: Iconsax.hashtag,
                          label: AppTexts.quantity,
                          value: '${_deliveryItemQty(deliveryItems[i])}',
                        ),
                      ],
                    ],
                  ),
          ),
          // Order items — separate AppDetailRow per field per item
          AppSpacing.vertical(context, 0.02),
          AppSectionCard(
            icon: Iconsax.box_1,
            title: _orderItemsSectionTitle(order.orderItems),
            child: (order.orderItems == null || order.orderItems!.isEmpty)
                ? Text(
                    AppTexts.noOrderItemsRecorded,
                    style: AppTextStyles.hintText(context),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var i = 0; i < order.orderItems!.length; i++) ...[
                        if (i > 0) ...[
                          AppSpacing.vertical(context, 0.01),
                          Divider(
                            color: AppColors.primary.withValues(alpha: 0.3),
                            height: 1,
                          ),
                          AppSpacing.vertical(context, 0.01),
                        ],
                        AppDetailRow(
                          icon: Iconsax.box_1,
                          label: AppTexts.productName,
                          value:
                              order.orderItems![i].productName ??
                              AppTexts.productFallbackLabel,
                        ),
                        AppSpacing.vertical(context, 0.008),
                        AppDetailRow(
                          icon: Iconsax.hashtag,
                          label: AppTexts.quantity,
                          value: '${order.orderItems![i].quantity ?? 0}',
                        ),
                        AppSpacing.vertical(context, 0.008),
                        AppDetailRow(
                          icon: Iconsax.money_recive,
                          label: AppTexts.unitPrice,
                          value: AppFormatter.formatCurrency(
                            order.orderItems![i].unitPrice ?? 0,
                          ),
                        ),
                        AppSpacing.vertical(context, 0.008),
                        AppDetailRow(
                          icon: Iconsax.money_tick,
                          label: AppTexts.total,
                          value: AppFormatter.formatCurrency(
                            order.orderItems![i].totalPrice ??
                                (order.orderItems![i].quantity ?? 0) *
                                    (order.orderItems![i].unitPrice ?? 0),
                          ),
                        ),
                      ],
                    ],
                  ),
          ),
          if (order.subsidyStatus != null &&
              order.subsidyStatus!.toLowerCase() != 'none') ...[
            AppSpacing.vertical(context, 0.02),
            AppSectionCard(
              icon: Iconsax.discount_shape,
              title: AppTexts.subsidyAndDiscountInfo,
              child: DeliveryDetailSubsidySection(order: order),
            ),
          ],
        ],
      ),
    );
  }

  static String _orderItemsSectionTitle(List<OrderItem>? items) {
    final count = items?.length ?? 0;
    if (count == 0) return AppTexts.orderItemsDuringVisit;
    return '${AppTexts.orderItemsDuringVisit} ($count)';
  }

  String _deliveryItemLabel(DeliveryItemModel e) {
    if (e.productName != null && e.productName!.isNotEmpty) {
      return e.productName!;
    }
    final orderItems = order.orderItems;
    if (e.orderItemId != null && orderItems != null) {
      for (final o in orderItems) {
        if (o.id == e.orderItemId && o.productName != null) {
          return o.productName!;
        }
      }
    }
    return '${AppTexts.productFallbackLabel} #${e.orderItemId ?? e.id}';
  }

  static int _deliveryItemQty(DeliveryItemModel e) {
    return e.quantity ?? e.quantityDelivered ?? e.quantityPickedUp ?? 0;
  }
}
