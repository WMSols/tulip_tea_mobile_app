import 'package:flutter/material.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_fonts/app_fonts.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_info_card.dart';

/// Reusable bottom bar for dashboard section cards: primary background,
/// label and icon on the right, no padding (flush with card edges).
/// Use with [DashboardSectionCard.expandedBottom] for alignment.
class DashboardSectionCardExpandedBottom extends StatelessWidget {
  const DashboardSectionCardExpandedBottom({
    super.key,
    required this.label,
    required this.icon,
    this.onTap,
    this.borderRadius,
  });

  final String label;
  final IconData icon;
  final VoidCallback? onTap;

  /// When used at bottom of a card, pass the card's bottom border radius.
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final radius =
        borderRadius ??
        BorderRadius.vertical(
          bottom: Radius.circular(AppResponsive.radius(context)),
        );
    final content = Material(
      color: AppColors.primary,
      borderRadius: radius,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Padding(
          padding: AppSpacing.symmetric(context, h: 0.04, v: 0.001),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                label,
                style: AppTextStyles.hintText(context).copyWith(
                  color: AppColors.white,
                  fontFamily: AppFonts.primaryFont,
                ),
              ),
              AppSpacing.horizontal(context, 0.01),
              Icon(
                icon,
                size: AppResponsive.iconSize(context, factor: 0.95),
                color: AppColors.white,
              ),
            ],
          ),
        ),
      ),
    );
    return content;
  }
}

/// Dashboard section card with optional illustration on the right.
/// Uses [AppInfoCard]; [child] is the main content, [illustrationPath] shows an image on the right.
/// Optional [expandedBottom] is drawn at the bottom with no padding (flush with card edges).
class DashboardSectionCard extends StatelessWidget {
  const DashboardSectionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.child,
    this.titleColor,
    this.illustrationPath,
    this.expandedBottom,
  });

  final IconData icon;
  final String title;
  final Widget child;
  final Color? titleColor;
  final String? illustrationPath;

  /// Shown at bottom of card with no padding; use [DashboardSectionCardExpandedBottom].
  final Widget? expandedBottom;

  @override
  Widget build(BuildContext context) {
    final color = titleColor ?? AppColors.primary;
    final radius = AppResponsive.radius(context);
    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: AppResponsive.iconSize(context, factor: 1.1),
              color: color,
            ),
            AppSpacing.horizontal(context, 0.02),
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.bodyText(context).copyWith(
                  fontWeight: FontWeight.w800,
                  fontFamily: AppFonts.primaryFont,
                  color: color,
                  height: 1.1,
                ),
              ),
            ),
          ],
        ),
        AppSpacing.vertical(context, 0.01),
        child,
      ],
    );

    Widget cardChild;
    if (illustrationPath == null || illustrationPath!.isEmpty) {
      cardChild = content;
    } else {
      cardChild = Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: content),
          AppSpacing.horizontal(context, 0.005),
          ClipRRect(
            borderRadius: BorderRadius.circular(
              AppResponsive.radius(context, factor: 0.8),
            ),
            child: Image.asset(
              illustrationPath!,
              width: AppResponsive.scaleSize(context, 120),
              height: AppResponsive.scaleSize(context, 120),
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => const SizedBox.shrink(),
            ),
          ),
        ],
      );
    }

    if (expandedBottom == null) {
      return AppInfoCard(child: cardChild);
    }

    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        side: BorderSide(color: AppColors.primary.withValues(alpha: 0.3)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: AppSpacing.symmetric(
              context,
              h: 0.04,
              v: 0.02,
            ).copyWith(bottom: 0),
            child: cardChild,
          ),
          expandedBottom!,
        ],
      ),
    );
  }
}
