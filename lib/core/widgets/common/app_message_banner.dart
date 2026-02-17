import 'package:flutter/material.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_styles/app_text_styles.dart';

/// Banner style: [info], [warning], [success]. Shows optional [icon] and [message].
class AppMessageBanner extends StatelessWidget {
  const AppMessageBanner({
    super.key,
    required this.message,
    this.type = AppMessageBannerType.info,
    this.icon,
    this.showBorder = true,
  });

  final String message;
  final AppMessageBannerType type;
  final IconData? icon;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    final (bgColor, borderColor, iconColor, defaultIcon) = _colorsForType(type);
    final effectiveIcon = icon ?? defaultIcon;
    return Container(
      padding: AppSpacing.symmetric(context, h: 0.02, v: 0.012),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        border: showBorder && borderColor != null
            ? Border.all(color: borderColor)
            : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(effectiveIcon, size: 20, color: iconColor),
          AppSpacing.horizontal(context, 0.02),
          Expanded(
            child: Text(
              message,
              style: AppTextStyles.hintText(context).copyWith(
                fontSize: AppResponsive.screenWidth(context) * 0.03,
                color: type == AppMessageBannerType.warning
                    ? AppColors.warning
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  (Color, Color?, Color, IconData) _colorsForType(AppMessageBannerType t) {
    switch (t) {
      case AppMessageBannerType.info:
        return (
          AppColors.information.withValues(alpha: 0.1),
          AppColors.information.withValues(alpha: 0.5),
          AppColors.information,
          Icons.info_outline_rounded,
        );
      case AppMessageBannerType.warning:
        return (
          AppColors.warning.withValues(alpha: 0.1),
          AppColors.warning.withValues(alpha: 0.5),
          AppColors.warning,
          Icons.warning_amber_rounded,
        );
      case AppMessageBannerType.success:
        return (
          AppColors.success.withValues(alpha: 0.15),
          AppColors.success.withValues(alpha: 0.5),
          AppColors.success,
          Icons.check_circle_outline,
        );
    }
  }
}

enum AppMessageBannerType { info, warning, success }
