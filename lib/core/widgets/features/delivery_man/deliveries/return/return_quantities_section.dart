import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_responsive/app_responsive.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_detail_row.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_section_card.dart';
import 'package:tulip_tea_mobile_app/core/widgets/form/app_text_field/app_text_field.dart';
import 'package:tulip_tea_mobile_app/data/models/delivery/delivery_model.dart';
import 'package:tulip_tea_mobile_app/domain/entities/order_for_delivery_man.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/delivery_man/deliveries/delivery_man_return_controller.dart';

/// Return quantities: AppSectionCard + AppDetailRow + AppTextField for return qty.
class ReturnQuantitiesSection extends StatefulWidget {
  const ReturnQuantitiesSection({
    super.key,
    required this.deliveryItems,
    required this.controller,
    this.order,
  });

  final List<DeliveryItemModel> deliveryItems;
  final DeliveryManReturnController controller;
  final OrderForDeliveryMan? order;

  @override
  State<ReturnQuantitiesSection> createState() =>
      _ReturnQuantitiesSectionState();
}

class _ReturnQuantitiesSectionState extends State<ReturnQuantitiesSection> {
  final Map<int, TextEditingController> _controllers = {};

  static int _itemKey(DeliveryItemModel item) =>
      item.productId ?? item.orderItemId ?? item.id;

  @override
  void initState() {
    super.initState();
    for (final item in widget.deliveryItems) {
      final key = _itemKey(item);
      final picked = item.quantityPickedUp ?? item.quantity ?? 0;
      final delivered = item.quantityDelivered ?? 0;
      final availableToReturn = (picked - delivered).clamp(0, picked);
      final qty = widget.controller.returnQuantities[key] ?? availableToReturn;
      _controllers[key] = TextEditingController(text: '$qty');
    }
  }

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  String _productDisplayName(DeliveryItemModel item, int index) {
    if (item.productName != null && item.productName!.isNotEmpty) {
      return item.productName!;
    }
    final orderItems = widget.order?.orderItems;
    if (orderItems != null && orderItems.isNotEmpty) {
      if (item.orderItemId != null) {
        for (final o in orderItems) {
          if (o.id == item.orderItemId && o.productName != null) {
            return o.productName!;
          }
        }
      }
      if (index >= 0 && index < orderItems.length) {
        final name = orderItems[index].productName;
        if (name != null && name.isNotEmpty) return name;
      }
    }
    return '${AppTexts.productFallbackLabel} #${item.productId ?? item.orderItemId ?? item.id}';
  }

  @override
  Widget build(BuildContext context) {
    return AppSectionCard(
      icon: Iconsax.box_1,
      title: AppTexts.itemsToReturnTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...widget.deliveryItems
              .asMap()
              .entries
              .map((entry) {
                final index = entry.key;
                final item = entry.value;
                final key = _itemKey(item);
                final tc = _controllers[key];
                if (tc == null) return <Widget>[];
                final pickedUp = item.quantityPickedUp ?? item.quantity ?? 0;
                final delivered = item.quantityDelivered ?? 0;
                final availableToReturn = (pickedUp - delivered).clamp(
                  0,
                  pickedUp,
                );
                final productLabel = _productDisplayName(item, index);
                return [
                  if (index > 0) ...[
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
                    value: productLabel,
                  ),
                  AppSpacing.vertical(context, 0.008),
                  AppDetailRow(
                    icon: Iconsax.box_tick,
                    label: AppTexts.pickedUpLabel,
                    value: '$pickedUp',
                  ),
                  AppSpacing.vertical(context, 0.008),
                  AppDetailRow(
                    icon: Iconsax.truck,
                    label: AppTexts.deliveredColumn,
                    value: '$delivered',
                  ),
                  AppSpacing.vertical(context, 0.008),
                  AppDetailRow(
                    icon: Iconsax.box_1,
                    label: AppTexts.availableToReturnLabel,
                    value: '$availableToReturn',
                  ),
                  AppSpacing.vertical(context, 0.008),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            AppResponsive.radius(context),
                          ),
                          color: AppColors.primary,
                        ),
                        child: Padding(
                          padding: AppSpacing.all(context) * 0.8,
                          child: Icon(
                            Iconsax.arrow_left,
                            size: AppResponsive.iconSize(context),
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      AppSpacing.horizontal(context, 0.02),
                      Text(
                        AppTexts.returnQuantity,
                        style: AppTextStyles.hintText(context).copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary,
                        ),
                      ),
                      AppSpacing.horizontal(context, 0.01),
                      Expanded(
                        child: AppTextField(
                          controller: tc,
                          keyboardType: TextInputType.number,
                          hint: AppTexts.returnQuantity,
                          onChanged: (v) {
                            final val = int.tryParse(v) ?? 0;
                            final clamped = val.clamp(0, availableToReturn);
                            widget.controller.setQuantity(key, clamped);
                            if (val != clamped && tc.text != '$clamped') {
                              tc.text = '$clamped';
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ];
              })
              .expand((e) => e),
        ],
      ),
    );
  }
}
