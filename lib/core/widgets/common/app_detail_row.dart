import 'package:flutter/material.dart';
import 'package:tulip_tea_order_booker/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_order_booker/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_order_booker/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_order_booker/core/utils/app_styles/app_text_styles.dart';

/// Reusable detail row: icon in primary container, label and value (e.g. Account, Shop Details).
class AppDetailRow extends StatelessWidget {
  const AppDetailRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppResponsive.radius(context)),
            color: AppColors.primary,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.hintText(context).copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
              ),
              Text(value, style: AppTextStyles.bodyText(context)),
            ],
          ),
        ),
      ],
    );
  }
}
