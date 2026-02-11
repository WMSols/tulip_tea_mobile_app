import 'package:flutter/material.dart';

import 'package:tulip_tea_order_booker/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_order_booker/core/utils/app_fonts/app_fonts.dart';
import 'package:tulip_tea_order_booker/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_order_booker/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_order_booker/core/utils/app_styles/app_text_styles.dart';

/// Reusable "Remember Me" checkbox row. Label uses [AppColors.primary] when checked.
class AppRememberMe extends StatelessWidget {
  const AppRememberMe({
    super.key,
    required this.value,
    required this.onChanged,
    required this.label,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final String label;

  @override
  Widget build(BuildContext context) {
    final textColor = value ? AppColors.primary : AppColors.black;

    return InkWell(
      onTap: () => onChanged(!value),
      borderRadius: BorderRadius.circular(AppResponsive.radius(context)),
      child: Row(
        children: [
          SizedBox(
            width: AppResponsive.iconSize(context),
            height: AppResponsive.iconSize(context),
            child: Checkbox(
              value: value,
              onChanged: (_) => onChanged(!value),
              activeColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  AppResponsive.radius(context) * 0.5,
                ),
              ),
            ),
          ),
          AppSpacing.horizontal(context, 0.02),
          Text(
            label,
            style: AppTextStyles.bodyText(context).copyWith(
              fontWeight: FontWeight.w500,
              fontFamily: AppFonts.primaryFont,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
