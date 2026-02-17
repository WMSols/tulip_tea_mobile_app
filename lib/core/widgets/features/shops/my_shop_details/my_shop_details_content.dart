import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_formatter/app_formatter.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_detail_row.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_status_chip.dart';
import 'package:tulip_tea_mobile_app/domain/entities/shop.dart';

/// Scrollable content for shop details: account-style rows (name, owner, credit, status, created).
class MyShopDetailsContent extends StatelessWidget {
  const MyShopDetailsContent({super.key, required this.shop});

  final Shop shop;

  @override
  Widget build(BuildContext context) {
    final creditStr = shop.creditLimit != null
        ? '${AppTexts.rupeeSymbol} ${shop.creditLimit!.toStringAsFixed(0)}'
        : '–';
    final availableStr = shop.availableCredit != null
        ? '${AppTexts.rupeeSymbol} ${shop.availableCredit!.toStringAsFixed(0)}'
        : '–';
    final outstandingStr = shop.outstandingBalance != null
        ? '${AppTexts.rupeeSymbol} ${shop.outstandingBalance!.toStringAsFixed(0)}'
        : '–';
    final statusStr = shop.registrationStatus ?? '–';
    final createdStr = AppFormatter.dateTimeFromString(shop.createdAt);

    return SingleChildScrollView(
      padding: AppSpacing.symmetric(context, h: 0.05, v: 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppDetailRow(
            icon: Iconsax.shop,
            label: AppTexts.shopName,
            value: shop.name,
          ),
          AppSpacing.vertical(context, 0.01),
          AppDetailRow(
            icon: Iconsax.user,
            label: AppTexts.ownerName,
            value: shop.ownerName.isNotEmpty ? shop.ownerName : '–',
          ),
          AppSpacing.vertical(context, 0.01),
          AppDetailRow(
            icon: Iconsax.call,
            label: AppTexts.ownerPhone,
            value: shop.ownerPhone.isNotEmpty ? shop.ownerPhone : '–',
          ),
          AppSpacing.vertical(context, 0.01),
          AppDetailRow(
            icon: Iconsax.wallet_3,
            label: AppTexts.creditLimit,
            value: creditStr,
          ),
          AppSpacing.vertical(context, 0.01),
          AppDetailRow(
            icon: Iconsax.wallet_check,
            label: AppTexts.availableCredit,
            value: availableStr,
          ),
          AppSpacing.vertical(context, 0.01),
          AppDetailRow(
            icon: Iconsax.receipt_item,
            label: AppTexts.outstandingBalance,
            value: outstandingStr,
          ),
          AppSpacing.vertical(context, 0.01),
          AppDetailRow(
            icon: Iconsax.verify,
            label: AppTexts.registrationStatus,
            value: statusStr.toUpperCase(),
            valueColor: AppStatusChip.statusColor(statusStr),
          ),
          AppSpacing.vertical(context, 0.01),
          AppDetailRow(
            icon: Iconsax.calendar_1,
            label: AppTexts.created,
            value: createdStr,
          ),
          AppSpacing.vertical(context, 0.04),
        ],
      ),
    );
  }
}
