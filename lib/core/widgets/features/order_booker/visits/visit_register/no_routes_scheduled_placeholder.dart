import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/buttons/app_icon_button.dart';
import 'package:tulip_tea_mobile_app/core/widgets/form/app_form_field_label/app_form_field_label.dart';
import 'package:tulip_tea_mobile_app/core/widgets/form/app_input_decoration/app_input_decoration.dart';

/// Disabled dropdown-style box showing warning when no routes are scheduled for today.
class NoRoutesScheduledPlaceholder extends StatelessWidget {
  const NoRoutesScheduledPlaceholder({
    super.key,
    required this.message,
    this.onRetry,
  });

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        AppFormFieldLabel(label: AppTexts.selectShopOptional, required: false),
        InputDecorator(
          decoration: AppInputDecoration.decoration(
            context,
            prefixIcon: Iconsax.shop,
          ).copyWith(enabled: false),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  message,
                  style: AppTextStyles.hintText(
                    context,
                  ).copyWith(color: AppColors.error),
                ),
              ),
              if (onRetry != null)
                AppIconButton(
                  icon: Iconsax.refresh,
                  backgroundColor: AppColors.error,
                  color: AppColors.white,
                  onPressed: onRetry,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
