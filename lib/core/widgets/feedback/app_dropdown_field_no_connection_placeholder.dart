import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/form/app_form_field_label/app_form_field_label.dart';
import 'package:tulip_tea_mobile_app/core/widgets/form/app_input_decoration/app_input_decoration.dart';

/// Disabled dropdown-style placeholder shown when offline.
/// Use for API-backed dropdowns when connectivity is lost—shows short "No Connection" text.
class AppDropdownFieldNoConnectionPlaceholder extends StatelessWidget {
  const AppDropdownFieldNoConnectionPlaceholder({
    super.key,
    required this.label,
    this.required = false,
    this.prefixIcon,
  });

  final String label;
  final bool required;
  final IconData? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        AppFormFieldLabel(label: label, required: required),
        InputDecorator(
          decoration: AppInputDecoration.decoration(
            context,
            prefixIcon: prefixIcon ?? Iconsax.wifi_square,
          ).copyWith(enabled: false),
          child: Text(
            AppTexts.noConnection,
            style: AppTextStyles.hintText(
              context,
            ).copyWith(color: AppColors.error),
          ),
        ),
      ],
    );
  }
}
