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
import 'package:tulip_tea_mobile_app/data/models/warehouse/warehouse_model.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/delivery_man/deliveries/delivery_man_pickup_controller.dart';

/// Pickup quantities (delivery exists): separate AppDetailRow per field, then AppTextField for pickup qty.
class PickupQuantitiesSection extends StatefulWidget {
  const PickupQuantitiesSection({
    super.key,
    required this.order,
    required this.selectedWarehouse,
    required this.deliveryItems,
    required this.controller,
  });

  final OrderForDeliveryMan? order;
  final WarehouseModel? selectedWarehouse;
  final List<DeliveryItemModel> deliveryItems;
  final DeliveryManPickupController controller;

  @override
  State<PickupQuantitiesSection> createState() =>
      _PickupQuantitiesSectionState();
}

class _PickupQuantitiesSectionState extends State<PickupQuantitiesSection> {
  final Map<int, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    for (final item in widget.deliveryItems) {
      final pid = item.productId;
      if (pid != null) {
        final availableQty = _availableQtyFromWarehouse(pid);
        final qty = availableQty != null && availableQty == 0
            ? 0
            : (widget.controller.pickupQuantities[pid] ?? item.quantity ?? 0);
        if (availableQty == 0) widget.controller.setQuantity(pid, 0);
        _controllers[pid] = TextEditingController(text: '$qty');
      }
    }
  }

  @override
  void didUpdateWidget(covariant PickupQuantitiesSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedWarehouse != widget.selectedWarehouse) {
      for (final item in widget.deliveryItems) {
        final pid = item.productId;
        if (pid != null) {
          final availableQty = _availableQtyFromWarehouse(pid);
          if (availableQty != null && availableQty == 0) {
            widget.controller.setQuantity(pid, 0);
            _controllers[pid]?.text = '0';
          }
        }
      }
    }
  }

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  int? _orderedQtyFromOrderByName(String? productName) {
    if (productName == null || productName.isEmpty) return null;
    final items = widget.order?.orderItems;
    if (items == null) return null;
    for (final e in items) {
      if ((e.productName ?? '').trim().toLowerCase() ==
          productName.trim().toLowerCase()) {
        return e.quantity;
      }
    }
    return null;
  }

  int? _availableQtyFromWarehouse(int productId) {
    final inv = widget.selectedWarehouse?.inventory;
    if (inv == null) return null;
    for (final e in inv) {
      if (e.productId == productId) {
        return e.availableQuantity ?? e.quantity ?? 0;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AppSectionCard(
      icon: Iconsax.box_1,
      title: AppTexts.orderItemsSection,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppTexts.pickupNoteSelectWarehouseFirst,
            style: AppTextStyles.hintText(
              context,
            ).copyWith(fontSize: AppResponsive.scaleSize(context, 12)),
          ),
          AppSpacing.vertical(context, 0.015),
          ...widget.deliveryItems
              .asMap()
              .entries
              .map((entry) {
                final index = entry.key;
                final item = entry.value;
                final pid = item.productId;
                if (pid == null) return <Widget>[];
                final tc = _controllers[pid];
                if (tc == null) return <Widget>[];
                final orderedQty =
                    _orderedQtyFromOrderByName(item.productName) ?? 0;
                final availableQty = _availableQtyFromWarehouse(pid);
                final maxQty = orderedQty < (availableQty ?? orderedQty)
                    ? orderedQty
                    : (availableQty ?? orderedQty);
                if (availableQty != null &&
                    availableQty == 0 &&
                    tc.text != '0') {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (!mounted) return;
                    widget.controller.setQuantity(pid, 0);
                    tc.text = '0';
                    setState(() {});
                  });
                }
                final productLabel =
                    item.productName ??
                    '${AppTexts.productFallbackLabel} #$pid';
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
                    icon: Iconsax.hashtag,
                    label: AppTexts.orderedQty,
                    value: '$orderedQty',
                  ),
                  AppSpacing.vertical(context, 0.008),
                  AppDetailRow(
                    icon: Iconsax.box_tick,
                    label: AppTexts.availableInWarehouse,
                    value: availableQty != null ? '$availableQty' : '–',
                    valueColor: availableQty != null && availableQty == 0
                        ? AppColors.error
                        : null,
                  ),
                  AppSpacing.vertical(context, 0.008),
                  AppTextField(
                    controller: tc,
                    keyboardType: TextInputType.number,
                    hint: AppTexts.pickupQuantity,
                    onChanged: (v) {
                      final val = int.tryParse(v) ?? 0;
                      final clamped = val.clamp(0, maxQty);
                      widget.controller.setQuantity(pid, clamped);
                      if (val != clamped && tc.text != '$clamped') {
                        tc.text = '$clamped';
                      }
                    },
                  ),
                  if (availableQty != null && availableQty == 0) ...[
                    AppSpacing.vertical(context, 0.006),
                    Text(
                      AppTexts.productNotAvailableInWarehouse,
                      style: AppTextStyles.hintText(
                        context,
                      ).copyWith(color: AppColors.error, fontSize: 12),
                    ),
                  ],
                ];
              })
              .expand((e) => e),
        ],
      ),
    );
  }
}
