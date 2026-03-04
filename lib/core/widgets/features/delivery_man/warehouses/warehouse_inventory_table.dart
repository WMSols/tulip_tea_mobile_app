import 'package:flutter/material.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_status_chip.dart';
import 'package:tulip_tea_mobile_app/data/models/warehouse/warehouse_model.dart';

/// Reusable table for warehouse inventory: Product, Quantity, Unit, Status.
/// Code column is omitted. Use inside horizontal scroll if needed.
class WarehouseInventoryTable extends StatelessWidget {
  const WarehouseInventoryTable({super.key, required this.items});

  final List<WarehouseInventoryItem> items;

  @override
  Widget build(BuildContext context) {
    final headerStyle = AppTextStyles.hintText(
      context,
    ).copyWith(fontWeight: FontWeight.w800, color: AppColors.white);
    final cellStyle = AppTextStyles.hintText(
      context,
    ).copyWith(fontWeight: FontWeight.w500, color: AppColors.black);

    return Table(
      border: TableBorder.all(color: AppColors.primary.withValues(alpha: 0.3)),
      columnWidths: const {
        0: FlexColumnWidth(1), // Product – more space for names
        1: FlexColumnWidth(0.7), // Quantity + unit
        2: FlexColumnWidth(
          0.7,
        ), // Status chip – enough for "Available", not dominant
      },
      children: [
        TableRow(
          decoration: BoxDecoration(color: AppColors.primary),
          children: [
            _tableCell(context, AppTexts.productName, headerStyle),
            _tableCell(context, AppTexts.quantity, headerStyle),
            _tableCell(context, AppTexts.status, headerStyle),
          ],
        ),
        ...items.map((item) {
          final qty = item.quantity ?? item.availableQuantity ?? 0;
          final status = item.status?.isNotEmpty == true
              ? item.status!
              : (qty > 0 ? AppTexts.available : '–');
          return TableRow(
            children: [
              _tableCell(context, item.productName ?? '–', cellStyle),
              _tableCell(
                context,
                '${item.quantity} ${item.unit ?? '–'}',
                cellStyle.copyWith(color: AppColors.success),
              ),
              _tableCellWithChip(context, status),
            ],
          );
        }),
      ],
    );
  }

  Widget _tableCell(BuildContext context, String text, TextStyle style) {
    return Container(
      padding: AppSpacing.symmetric(context, h: 0.02, v: 0.01),
      alignment: Alignment.center,
      child: Text(text, style: style, overflow: TextOverflow.ellipsis),
    );
  }

  Widget _tableCellWithChip(BuildContext context, String status) {
    final isAvailable =
        status.toLowerCase().contains('available') ||
        status == AppTexts.available;
    return Container(
      padding: AppSpacing.symmetric(context, h: 0.02, v: 0.01),
      alignment: Alignment.center,
      child: AppStatusChip(
        status: status,
        backgroundColor: isAvailable ? AppColors.success : null,
      ),
    );
  }
}
