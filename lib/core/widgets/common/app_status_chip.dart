import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_fonts/app_fonts.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_styles/app_text_styles.dart';

/// Chip showing status with icon and text. Background and icon vary by status.
/// Optionally pass [backgroundColor] and [icon] to override (e.g. for visit type chips).
class AppStatusChip extends StatelessWidget {
  const AppStatusChip({
    super.key,
    required this.status,
    this.text,
    this.backgroundColor,
    this.icon,
  });

  final String status;

  /// If null, [status] is displayed (with optional capitalization).
  final String? text;

  /// When set, used instead of status-derived color (e.g. for visit types).
  final Color? backgroundColor;

  /// When set, used instead of status-derived icon (e.g. for visit types).
  final IconData? icon;

  /// Status color for use in details screens (value text only, no chip).
  /// Check reject/disapprove before approve so "disapproved" gets error (red), not success (green).
  static Color statusColor(String status) {
    final s = status.toLowerCase();
    if (s.contains('reject') || s.contains('disapprov') || s.contains('denied') || s == 'inactive') {
      return AppColors.error;
    }
    if (s.contains('approv') || s == 'verified' || s == 'active') {
      return AppColors.success;
    }
    if (s.contains('pending') ||
        s.contains('waiting') ||
        s.contains('review')) {
      return AppColors.warning;
    }
    return AppColors.grey;
  }

  static Color _backgroundColor(String status) => statusColor(status);

  /// Check reject/disapprove before approve so "disapproved" gets close_circle (red), not tick_circle (green).
  static IconData _icon(String status) {
    final s = status.toLowerCase();
    if (s.contains('reject') || s.contains('disapprov') || s.contains('denied') || s == 'inactive') {
      return Iconsax.close_circle;
    }
    if (s.contains('approv') || s == 'verified' || s == 'active') {
      return Iconsax.tick_circle;
    }
    if (s.contains('pending') ||
        s.contains('waiting') ||
        s.contains('review')) {
      return Iconsax.clock;
    }
    return Iconsax.info_circle;
  }

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? _backgroundColor(status);
    final iconData = icon ?? _icon(status);
    final label = text ?? (status.isEmpty ? '–' : status);

    return Container(
      padding: AppSpacing.symmetric(context, h: 0.02, v: 0.005),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppResponsive.radius(context)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            iconData,
            size: AppResponsive.iconSize(context, factor: 0.9),
            color: AppColors.white,
          ),
          AppSpacing.horizontal(context, 0.015),
          Text(
            label.toUpperCase(),
            style: AppTextStyles.hintText(context).copyWith(
              color: AppColors.white,
              fontFamily: AppFonts.primaryFont,
              fontWeight: FontWeight.w600,
              fontSize: AppResponsive.screenWidth(context) * 0.025,
            ),
          ),
        ],
      ),
    );
  }
}
