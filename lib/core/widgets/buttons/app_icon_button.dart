import 'package:flutter/material.dart';

import 'package:tulip_tea_order_booker/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_order_booker/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_order_booker/core/utils/app_spacing/app_spacing.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.size,
    this.color,
    this.backgroundColor,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final double? size;
  final Color? color;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final iconSize = size ?? AppResponsive.iconSize(context);
    return Material(
      color: backgroundColor ?? Colors.transparent,
      borderRadius: BorderRadius.circular(AppResponsive.radius(context)),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(AppResponsive.radius(context)),
        child: Padding(
          padding: AppSpacing.all(context),
          child: Icon(icon, size: iconSize, color: color ?? AppColors.primary),
        ),
      ),
    );
  }
}
