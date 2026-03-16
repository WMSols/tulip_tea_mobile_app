import 'package:flutter/material.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_styles/app_text_styles.dart';

/// Reusable table/section title: icon in colored box + title text.
/// Use for warehouse inventory header, delivery items, order items, etc.
class AppTableTitle extends StatelessWidget {
  const AppTableTitle({
    super.key,
    required this.icon,
    required this.title,
    this.iconColor,
    this.titleColor,
  });

  final IconData icon;
  final String title;

  /// Background and icon color for the icon container. Defaults to [AppColors.primary].
  final Color? iconColor;

  /// Text color for the title. Defaults to theme/default.
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    final color = iconColor ?? AppColors.primary;
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppResponsive.radius(context)),
            color: color,
          ),
          child: Padding(
            padding: AppSpacing.all(context) * 0.8,
            child: Icon(
              icon,
              size: AppResponsive.iconSize(context),
              color: AppColors.white,
            ),
          ),
        ),
        AppSpacing.horizontal(context, 0.02),
        Expanded(
          child: Text(
            title,
            style: AppTextStyles.bodyText(
              context,
            ).copyWith(fontWeight: FontWeight.w800, color: titleColor),
          ),
        ),
      ],
    );
  }
}
