import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_order_booker/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_order_booker/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_order_booker/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_order_booker/core/utils/app_styles/app_text_styles.dart';

class AppDropdown<T> extends StatelessWidget {
  const AppDropdown({
    super.key,
    this.label,
    this.hint,
    this.value,
    required this.items,
    required this.onChanged,
    this.validator,
    this.getLabel,
  });

  final String? label;
  final String? hint;
  final T? value;
  final List<T> items;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final String Function(T)? getLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: AppTextStyles.bodyText(
              context,
            ).copyWith(fontWeight: FontWeight.w600, color: AppColors.black),
          ),
          AppSpacing.vertical(context, 0.008),
        ],
        DropdownButtonFormField<T>(
          // ignore: deprecated_member_use
          value: value,
          hint: hint != null
              ? Text(hint!, style: AppTextStyles.hintText(context))
              : null,
          items: items
              .map(
                (e) => DropdownMenuItem<T>(
                  value: e,
                  child: Text(
                    getLabel != null ? getLabel!(e) : e.toString(),
                    style: AppTextStyles.bodyText(context),
                  ),
                ),
              )
              .toList(),
          onChanged: onChanged,
          validator: validator,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.lightGrey,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AppResponsive.radius(context),
              ),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AppResponsive.radius(context),
              ),
              borderSide: const BorderSide(color: AppColors.error),
            ),
          ),
          icon: Icon(
            Iconsax.arrow_down_1,
            size: AppResponsive.iconSize(context, factor: 0.9),
            color: AppColors.grey,
          ),
        ),
      ],
    );
  }
}
