import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_detail_row.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_section_card.dart';
import 'package:tulip_tea_mobile_app/core/widgets/form/app_form_section_text/app_form_section_text.dart';
import 'package:tulip_tea_mobile_app/core/widgets/form/app_text_field/app_text_field.dart';
import 'package:tulip_tea_mobile_app/data/models/warehouse/warehouse_model.dart';
import 'package:tulip_tea_mobile_app/domain/entities/order_for_delivery_man.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/delivery_man/deliveries/delivery_man_pickup_controller.dart';

/// Order items on pickup (no delivery): separate AppDetailRow per field, then AppTextField for pickup qty.
class PickupOrderItemsSection extends StatefulWidget {
  const PickupOrderItemsSection({
    super.key,
    required this.order,
    required this.selectedWarehouse,
    required this.controller,
  });

  final OrderForDeliveryMan order;
  final WarehouseModel? selectedWarehouse;
  final DeliveryManPickupController controller;

  @override
  State<PickupOrderItemsSection> createState() =>
      _PickupOrderItemsSectionState();
}

class _PickupOrderItemsSectionState extends State<PickupOrderItemsSection> {
  final Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  void _initControllers() {
    final items = widget.order.orderItems ?? [];
    for (var i = 0; i < items.length; i++) {
      final e = items[i];
      final name = e.productName?.trim() ?? '';
      if (name.isEmpty) continue;
      final ordered = e.quantity ?? 0;
      final available = _availableForProduct(e.productName);
      final current = available != null && available == 0
          ? 0
          : (widget.controller.pickupQuantitiesByName[name] ?? ordered);
      if (current == 0 && available == 0) {
        widget.controller.setQuantityByName(name, 0);
      }
      _controllers['${name}_$i'] = TextEditingController(text: '$current');
    }
  }

  @override
  void didUpdateWidget(covariant PickupOrderItemsSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedWarehouse != widget.selectedWarehouse ||
        oldWidget.order != widget.order) {
      final items = widget.order.orderItems ?? [];
      for (var i = 0; i < items.length; i++) {
        final e = items[i];
        final name = e.productName?.trim() ?? '';
        if (name.isEmpty) continue;
        final available = _availableForProduct(e.productName);
        if (available != null && available == 0) {
          widget.controller.setQuantityByName(name, 0);
          _controllers['${name}_$i']?.text = '0';
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

  int? _availableForProduct(String? productName) {
    if (productName == null || productName.isEmpty) return null;
    final inv = widget.selectedWarehouse?.inventory;
    if (inv == null) return null;
    for (final e in inv) {
      final invName = (e.productName ?? '').trim().toLowerCase();
      final orderName = productName.trim().toLowerCase();
      if (invName.isNotEmpty && orderName.isNotEmpty && invName == orderName) {
        return e.availableQuantity ?? e.quantity ?? 0;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.order.orderItems ?? [];
    if (items.isEmpty) {
      return AppSectionCard(
        icon: Iconsax.box_1,
        title: AppTexts.orderItemsSection,
        child: Text(
          AppTexts.noOrderItemsRecorded,
          style: AppTextStyles.hintText(context),
        ),
      );
    }
    return AppSectionCard(
      icon: Iconsax.box_1,
      title: AppTexts.orderItemsSection,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppFormSectionText(AppTexts.pickupNoteSelectWarehouseFirst),
          AppSpacing.vertical(context, 0.015),
          ...items
              .asMap()
              .entries
              .map((entry) {
                final i = entry.key;
                final e = entry.value;
                final name =
                    e.productName?.trim() ?? AppTexts.productFallbackLabel;
                final ordered = e.quantity ?? 0;
                final available = _availableForProduct(e.productName);
                final tc = _controllers['${name}_$i'];
                final maxQty = available != null
                    ? (ordered < available ? ordered : available)
                    : ordered;
                if (available != null &&
                    available == 0 &&
                    tc != null &&
                    tc.text != '0') {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (!mounted) return;
                    widget.controller.setQuantityByName(name, 0);
                    tc.text = '0';
                    setState(() {});
                  });
                }
                return [
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
                    value: name,
                  ),
                  AppSpacing.vertical(context, 0.008),
                  AppDetailRow(
                    icon: Iconsax.hashtag,
                    label: AppTexts.orderedQty,
                    value: '$ordered',
                  ),
                  AppSpacing.vertical(context, 0.008),
                  AppDetailRow(
                    icon: Iconsax.box_tick,
                    label: AppTexts.availableInWarehouse,
                    value: available != null ? '$available' : '–',
                    valueColor: available != null && available == 0
                        ? AppColors.error
                        : null,
                  ),
                  AppSpacing.vertical(context, 0.008),
                  if (tc != null)
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
                              Iconsax.hashtag,
                              size: AppResponsive.iconSize(context),
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        AppSpacing.horizontal(context, 0.02),
                        Text(
                          AppTexts.pickupQuantity,
                          style: AppTextStyles.hintText(context).copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.primary,
                          ),
                        ),
                        AppSpacing.horizontal(context, 0.01),
                        Expanded(
                          child: AbsorbPointer(
                            absorbing: available != null && available == 0,
                            child: Opacity(
                              opacity: available != null && available == 0
                                  ? 0.5
                                  : 1.0,
                              child: AppTextField(
                                controller: tc,
                                keyboardType: TextInputType.number,
                                hint: AppTexts.pickupQuantity,
                                onChanged: (v) {
                                  final val = int.tryParse(v) ?? 0;
                                  final clamped = val.clamp(0, maxQty);
                                  widget.controller.setQuantityByName(
                                    name,
                                    clamped,
                                  );
                                  if (val != clamped && tc.text != '$clamped') {
                                    tc.text = '$clamped';
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  if (available != null && available == 0) ...[
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
