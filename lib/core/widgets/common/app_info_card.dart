import 'package:flutter/material.dart';

import 'package:tulip_tea_order_booker/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_order_booker/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_order_booker/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_order_booker/core/utils/app_styles/app_text_styles.dart';

/// Card with optional title and content. Uses [AppSpacing], [AppTextStyles], [AppColors].
class AppInfoCard extends StatelessWidget {
  const AppInfoCard({super.key, this.title, required this.child});

  final String? title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppResponsive.radius(context)),
        side: BorderSide(color: AppColors.lightGrey),
      ),
      child: Padding(
        padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title != null && title!.isNotEmpty) ...[
              Text(
                title!,
                style: AppTextStyles.heading(context).copyWith(
                  color: AppColors.primary,
                  fontSize: AppResponsive.screenWidth(context) * 0.045,
                ),
              ),
              AppSpacing.vertical(context, 0.015),
            ],
            child,
          ],
        ),
      ),
    );
  }
}

/// A row with label and value. Uses [AppTextStyles]. Optional bottom divider.
class AppInfoRow extends StatelessWidget {
  const AppInfoRow({
    super.key,
    required this.label,
    required this.value,
    this.showDivider = true,
  });

  final String label;
  final String value;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: AppResponsive.screenWidth(context) * 0.35,
              child: Text(
                label,
                style: AppTextStyles.hintText(
                  context,
                ).copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(
              child: Text(value, style: AppTextStyles.bodyText(context)),
            ),
          ],
        ),
        if (showDivider) ...[
          AppSpacing.vertical(context, 0.008),
          Divider(height: 1, color: AppColors.lightGrey),
          AppSpacing.vertical(context, 0.008),
        ],
      ],
    );
  }
}
