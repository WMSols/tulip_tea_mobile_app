import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_formatter/app_formatter.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/domain/entities/shop_credit_info.dart';

/// Collection impact preview: current/new outstanding, new available credit.
class ImpactPreview extends StatelessWidget {
  const ImpactPreview({
    super.key,
    this.info,
    required this.collectionAmountStr,
  });

  final ShopCreditInfo? info;
  final String collectionAmountStr;

  @override
  Widget build(BuildContext context) {
    final amount = double.tryParse(collectionAmountStr.trim());
    if (info == null || amount == null || amount < 0) {
      return const SizedBox.shrink();
    }
    final creditInfo = info!;
    final currentOut = creditInfo.outstandingBalance ?? 0.0;
    final limit = creditInfo.creditLimit ?? 0.0;
    final newOut = (currentOut - amount).clamp(0.0, double.infinity);
    final newAvail = (limit - newOut).clamp(0.0, double.infinity);
    final isPerfect = newOut <= 0;
    return Container(
      padding: AppSpacing.symmetric(context, h: 0.02, v: 0.015),
      decoration: BoxDecoration(
        color: AppColors.success.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.success.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Iconsax.chart_21, size: 18, color: AppColors.success),
              AppSpacing.horizontal(context, 0.02),
              Text(
                AppTexts.impactPreview,
                style: AppTextStyles.bodyText(
                  context,
                ).copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          AppSpacing.vertical(context, 0.01),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${AppTexts.currentOutstanding}: ${AppFormatter.formatCurrency(currentOut)}',
                      style: AppTextStyles.hintText(context).copyWith(
                        color: currentOut > 0 ? AppColors.error : null,
                      ),
                    ),
                    Text(
                      '${AppTexts.newOutstanding}: ${AppFormatter.formatCurrency(newOut)}',
                      style: AppTextStyles.hintText(
                        context,
                      ).copyWith(color: newOut <= 0 ? AppColors.success : null),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${AppTexts.collectionAmount}: ${AppFormatter.formatCurrency(amount)}',
                      style: AppTextStyles.hintText(
                        context,
                      ).copyWith(color: AppColors.success),
                    ),
                    Text(
                      '${AppTexts.newAvailableCredit}: ${AppFormatter.formatCurrency(newAvail)}',
                      style: AppTextStyles.hintText(
                        context,
                      ).copyWith(color: AppColors.success),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (isPerfect) ...[
            AppSpacing.vertical(context, 0.01),
            Row(
              children: [
                Icon(Iconsax.tick_circle, size: 18, color: AppColors.success),
                AppSpacing.horizontal(context, 0.02),
                Expanded(
                  child: Text(
                    AppTexts.perfectShopFullCredit,
                    style: AppTextStyles.hintText(context).copyWith(
                      color: AppColors.success,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
