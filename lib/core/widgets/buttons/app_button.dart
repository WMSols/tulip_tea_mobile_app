import 'package:flutter/material.dart';

import 'package:tulip_tea_order_booker/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_order_booker/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_order_booker/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_order_booker/core/utils/app_styles/app_text_styles.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.primary = true,
    this.icon,
    this.iconPosition = IconPosition.left,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool primary;
  final IconData? icon;
  final IconPosition iconPosition;

  @override
  Widget build(BuildContext context) {
    final child = isLoading
        ? SizedBox(
            height: AppResponsive.buttonLoaderSize(context),
            width: AppResponsive.buttonLoaderSize(context),
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                primary ? AppColors.white : AppColors.primary,
              ),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null && iconPosition == IconPosition.left) ...[
                Icon(
                  icon,
                  size: AppResponsive.iconSize(context),
                  color: primary ? AppColors.white : AppColors.primary,
                ),
                AppSpacing.horizontal(context, 0.01),
              ],
              Text(
                label,
                style: AppTextStyles.buttonText(context).copyWith(
                  color: primary ? AppColors.white : AppColors.primary,
                ),
              ),
              if (icon != null && iconPosition == IconPosition.right) ...[
                AppSpacing.horizontal(context, 0.01),
                Icon(
                  icon,
                  size: AppResponsive.iconSize(context),
                  color: primary ? AppColors.white : AppColors.primary,
                ),
              ],
            ],
          );

    return Material(
      color: primary ? AppColors.primary : AppColors.white,
      borderRadius: BorderRadius.circular(AppResponsive.radius(context)),
      child: InkWell(
        onTap: isLoading ? null : onPressed,
        borderRadius: BorderRadius.circular(AppResponsive.radius(context)),
        child: Container(
          padding: AppSpacing.symmetric(context, h: 0.06, v: 0.012),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppResponsive.radius(context)),
            border: primary ? null : Border.all(color: AppColors.primary),
          ),
          child: child,
        ),
      ),
    );
  }
}

enum IconPosition { left, right }
