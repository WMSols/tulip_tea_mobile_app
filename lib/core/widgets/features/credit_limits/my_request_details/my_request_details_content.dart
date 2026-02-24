import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_formatter/app_formatter.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_detail_row.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_status_chip.dart';
import 'package:tulip_tea_mobile_app/domain/entities/credit_limit_request.dart';

/// Scrollable content for credit limit request details: account-style rows (shop, limits, status, dates, etc.).
class MyRequestDetailsContent extends StatelessWidget {
  const MyRequestDetailsContent({super.key, required this.request});

  final CreditLimitRequest request;

  @override
  Widget build(BuildContext context) {
    final oldStr = request.oldCreditLimit != null
        ? AppFormatter.formatCurrency(request.oldCreditLimit!)
        : AppTexts.notAvailable;
    final requestedStr = AppFormatter.formatCurrency(
      request.requestedCreditLimit,
    );
    final statusStr = request.status ?? AppTexts.notAvailable;
    final createdStr = AppFormatter.dateTimeFromString(request.createdAt);
    final approvedStr = AppFormatter.dateTimeFromString(request.approvedAt);

    return SingleChildScrollView(
      padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (request.isActive == false) ...[
            Text(
              AppTexts.requestDeletedByDistributor.toUpperCase(),
              style: AppTextStyles.hintText(context).copyWith(
                color: AppColors.error,
                fontWeight: FontWeight.w800,
                fontSize: AppResponsive.screenWidth(context) * 0.035,
              ),
            ),
          ],
          AppSpacing.vertical(context, 0.01),
          AppDetailRow(
            icon: Iconsax.shop,
            label: AppTexts.shopName,
            value:
                request.shopName ?? '${AppTexts.shopName} #${request.shopId}',
          ),
          AppSpacing.vertical(context, 0.01),
          AppDetailRow(
            icon: Iconsax.wallet_3,
            label: AppTexts.currentLimit,
            value: oldStr,
          ),
          AppSpacing.vertical(context, 0.01),
          AppDetailRow(
            icon: Iconsax.wallet_add,
            label: AppTexts.requestedLimit,
            value: requestedStr,
          ),
          AppSpacing.vertical(context, 0.01),
          AppDetailRow(
            icon: Iconsax.verify,
            label: AppTexts.status,
            value: statusStr.toUpperCase(),
            valueColor: AppStatusChip.statusColor(statusStr),
          ),
          if (request.requestedByRole != null &&
              request.requestedByRole!.isNotEmpty) ...[
            AppSpacing.vertical(context, 0.01),
            AppDetailRow(
              icon: Iconsax.user,
              label: AppTexts.requestedBy,
              value: request.requestedByRole!,
            ),
          ],
          if (request.approvedByDistributorName != null &&
              request.approvedByDistributorName!.isNotEmpty) ...[
            AppSpacing.vertical(context, 0.01),
            AppDetailRow(
              icon: Iconsax.user_tick,
              label: AppTexts.approvedBy,
              value: request.approvedByDistributorName!,
            ),
          ],
          if (request.remarks != null &&
              request.remarks!.trim().isNotEmpty) ...[
            AppSpacing.vertical(context, 0.01),
            AppDetailRow(
              icon: Iconsax.note,
              label: AppTexts.remarks,
              value: request.remarks!,
            ),
          ],
          AppSpacing.vertical(context, 0.01),
          AppDetailRow(
            icon: Iconsax.calendar_1,
            label: AppTexts.created,
            value: createdStr,
          ),
          if (approvedStr != AppTexts.dateTimeUnset) ...[
            AppSpacing.vertical(context, 0.01),
            AppDetailRow(
              icon: Iconsax.calendar_tick,
              label: AppTexts.reviewed,
              value: approvedStr,
            ),
          ],
          AppSpacing.vertical(context, 0.04),
        ],
      ),
    );
  }
}
