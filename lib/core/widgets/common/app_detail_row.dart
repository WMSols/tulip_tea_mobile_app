import 'package:flutter/material.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_fonts/app_fonts.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_styles/app_text_styles.dart';

/// Reusable detail row: icon in primary container, label and value (e.g. Account, Shop Details).
/// Use [valueColor] to tint the value text, or [valueChild] for custom value widget (e.g. multi-colored text).
class AppDetailRow extends StatelessWidget {
  const AppDetailRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
    this.valueChild,
  });

  final IconData icon;
  final String label;
  final String value;

  /// When set, value text uses this color (e.g. status colors in details).
  final Color? valueColor;

  /// When set, used instead of [value] text (e.g. visit types with multiple colors).
  final Widget? valueChild;

  @override
  Widget build(BuildContext context) {
    final baseStyle = AppTextStyles.bodyText(context);
    final valueWidget =
        valueChild ??
        Text(
          value,
          style: valueColor != null
              ? baseStyle.copyWith(
                  color: valueColor,
                  fontWeight: FontWeight.w800,
                  fontFamily: AppFonts.primaryFont,
                )
              : baseStyle,
        );

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
              valueWidget,
            ],
          ),
        ),
      ],
    );
  }
}
