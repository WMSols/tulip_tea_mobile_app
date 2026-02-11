import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_lotties/app_lotties.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_mobile_app/core/widgets/form/app_form_field_label/app_form_field_label.dart';
import 'package:tulip_tea_mobile_app/core/widgets/form/app_input_decoration/app_input_decoration.dart';

/// Non-interactive placeholder shown while dropdown items are loading.
/// Use wherever [AppDropdown] would be shown with async data so the dropdown
/// is never built with empty items (which can make it untappable).
class AppDropdownFieldLoadingPlaceholder extends StatelessWidget {
  const AppDropdownFieldLoadingPlaceholder({
    super.key,
    required this.label,
    required this.hint,
    this.required = false,
    required this.prefixIcon,
  });

  final String label;
  final String hint;
  final bool required;
  final IconData prefixIcon;

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
            prefixIcon: prefixIcon,
          ),
          child: Row(
            children: [
              SizedBox(
                width: AppResponsive.scaleSize(context, 18),
                height: AppResponsive.scaleSize(context, 18),
                child: Lottie.asset(AppLotties.loadingPrimary),
              ),
              AppSpacing.horizontal(context, 0.02),
              Expanded(
                child: Text(hint, style: AppTextStyles.hintText(context)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
