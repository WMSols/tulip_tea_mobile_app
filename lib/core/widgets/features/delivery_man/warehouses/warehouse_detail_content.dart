import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_formatter/app_formatter.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_images/app_images.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_detail_row.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_status_chip.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/delivery_man/warehouses/warehouse_inventory_table.dart';
import 'package:tulip_tea_mobile_app/core/widgets/feedback/app_empty_widget.dart';
import 'package:tulip_tea_mobile_app/data/models/warehouse/warehouse_model.dart';

/// Scrollable content for warehouse details: name, zone, address, status,
/// total items in stock, contact, and inventory table.
class WarehouseDetailContent extends StatelessWidget {
  const WarehouseDetailContent({super.key, required this.warehouse});

  final WarehouseModel warehouse;

  @override
  Widget build(BuildContext context) {
    final name = warehouse.name ?? '–';
    final zoneName = warehouse.zoneName?.isNotEmpty == true
        ? warehouse.zoneName!
        : '–';
    final address = warehouse.address?.isNotEmpty == true
        ? warehouse.address!
        : '–';
    final statusStr = warehouse.isActive == true ? 'Active' : 'Inactive';
    final statusColor = AppStatusChip.statusColor(statusStr);
    final totalItems =
        warehouse.totalItemsInStock ??
        warehouse.inventory?.fold<int>(
          0,
          (sum, item) => sum + (item.quantity ?? item.availableQuantity ?? 0),
        ) ??
        0;
    final contactPerson = warehouse.contactPerson?.isNotEmpty == true
        ? warehouse.contactPerson!
        : '–';
    final contactPhone = warehouse.contactPhone?.isNotEmpty == true
        ? warehouse.contactPhone!
        : '–';
    final createdAt = warehouse.createdAt != null
        ? AppFormatter.dateTime(warehouse.createdAt!)
        : '–';
    final inventory = warehouse.inventory ?? [];

    return SingleChildScrollView(
      padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppDetailRow(
            icon: Iconsax.building,
            label: AppTexts.warehouseName,
            value: name,
          ),
          AppSpacing.vertical(context, 0.01),
          AppDetailRow(
            icon: Iconsax.location,
            label: AppTexts.zone,
            value: zoneName,
          ),
          AppSpacing.vertical(context, 0.01),
          AppDetailRow(
            icon: Iconsax.location,
            label: AppTexts.address,
            value: address,
          ),
          AppSpacing.vertical(context, 0.01),
          AppDetailRow(
            icon: Iconsax.verify,
            label: AppTexts.status,
            value: statusStr,
            valueColor: statusColor,
          ),
          AppSpacing.vertical(context, 0.01),
          AppDetailRow(
            icon: Iconsax.box_1,
            label: AppTexts.totalItemsInStock,
            value: '$totalItems',
          ),
          AppSpacing.vertical(context, 0.01),
          AppDetailRow(
            icon: Iconsax.user,
            label: AppTexts.contactPerson,
            value: contactPerson,
          ),
          AppSpacing.vertical(context, 0.01),
          AppDetailRow(
            icon: Iconsax.call,
            label: AppTexts.contactPhone,
            value: contactPhone,
          ),
          AppSpacing.vertical(context, 0.01),
          AppDetailRow(
            icon: Iconsax.calendar_1,
            label: AppTexts.created,
            value: createdAt,
          ),
          AppSpacing.vertical(context, 0.01),
          Divider(height: 1, color: AppColors.primary.withValues(alpha: 0.3)),
          AppSpacing.vertical(context, 0.01),
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
                    Iconsax.box,
                    size: AppResponsive.iconSize(context),
                    color: AppColors.white,
                  ),
                ),
              ),
              AppSpacing.horizontal(context, 0.02),
              Text(
                '${AppTexts.warehouseInventory} (${inventory.length} ${inventory.length == 1 ? 'item' : 'items'})',
                style: AppTextStyles.bodyText(
                  context,
                ).copyWith(fontWeight: FontWeight.w800),
              ),
            ],
          ),
          AppSpacing.vertical(context, 0.015),
          if (inventory.isEmpty)
            Center(
              child: AppEmptyWidget(
                message: AppTexts.noInventoryYet,
                imagePath: AppImages.noDataYet,
              ),
            )
          else
            WarehouseInventoryTable(items: inventory),
          AppSpacing.vertical(context, 0.04),
        ],
      ),
    );
  }
}
