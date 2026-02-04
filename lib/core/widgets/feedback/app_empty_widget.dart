import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_order_booker/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_order_booker/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_order_booker/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_order_booker/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_order_booker/core/utils/app_texts/app_texts.dart';

class AppEmptyWidget extends StatelessWidget {
  const AppEmptyWidget({
    super.key,
    this.message = AppTexts.noDataYet,
    this.icon,
  });

  final String message;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppSpacing.symmetric(context, h: 0.08, v: 0.05),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon ?? Iconsax.box_1,
              size: AppResponsive.emptyIconSize(context),
              color: AppColors.grey,
            ),
            AppSpacing.vertical(context, 0.02),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyText(
                context,
              ).copyWith(color: AppColors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
