import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_formatter/app_formatter.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_info_card.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_section_card.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_message_banner.dart';
import 'package:tulip_tea_mobile_app/domain/entities/shop_credit_info.dart';

/// Shop credit info: limit, outstanding, available + remark banner.
class ShopCreditInfoCard extends StatelessWidget {
  const ShopCreditInfoCard({super.key, required this.info});

  final ShopCreditInfo info;

  @override
  Widget build(BuildContext context) {
    final creditLimit = info.creditLimit ?? 0.0;
    final outstanding = info.outstandingBalance ?? 0.0;
    final available =
        info.availableCredit ??
        (creditLimit - outstanding).clamp(0.0, double.infinity);
    return AppSectionCard(
      icon: Iconsax.wallet_money,
      title: AppTexts.shopCreditInformation,
      titleColor: AppColors.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppInfoRow(
            label: AppTexts.creditLimit,
            value: AppFormatter.formatCurrency(creditLimit),
            showDivider: true,
          ),
          AppInfoRow(
            label: AppTexts.outstandingBalance,
            value: AppFormatter.formatCurrency(outstanding),
            showDivider: true,
          ),
          AppInfoRow(
            label: AppTexts.availableCredit,
            value: AppFormatter.formatCurrency(available),
            showDivider: false,
          ),
          AppSpacing.vertical(context, 0.01),
          AppMessageBanner(
            message:
                '${AppTexts.remarks}: ${AppTexts.noteOrderUpToAvailableCredit}',
            type: AppMessageBannerType.warning,
            showBorder: false,
          ),
        ],
      ),
    );
  }
}
