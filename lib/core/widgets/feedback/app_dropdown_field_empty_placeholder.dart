import 'package:flutter/material.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_mobile_app/core/widgets/form/app_form_field_label/app_form_field_label.dart';
import 'package:tulip_tea_mobile_app/core/widgets/form/app_input_decoration/app_input_decoration.dart';

/// Disabled dropdown-style placeholder when there is no data (e.g. no shops, no routes).
/// Shows [message] as hint text without a loading indicator.
class AppDropdownFieldEmptyPlaceholder extends StatelessWidget {
  const AppDropdownFieldEmptyPlaceholder({
    super.key,
    required this.label,
    required this.message,
    this.required = false,
    this.prefixIcon,
  });

  final String label;
  final String message;
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
            prefixIcon: prefixIcon,
          ).copyWith(enabled: false),
          child: Text(
            message,
            style: AppTextStyles.hintText(context),
          ),
        ),
      ],
    );
  }
}
