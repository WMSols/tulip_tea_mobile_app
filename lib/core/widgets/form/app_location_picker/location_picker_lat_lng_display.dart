import 'package:flutter/material.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_fonts/app_fonts.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';

/// Displays latitude and longitude labels with values.
class LocationPickerLatLngDisplay extends StatelessWidget {
  const LocationPickerLatLngDisplay({
    super.key,
    required this.lat,
    required this.lng,
  });

  final String lat;
  final String lng;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '${AppTexts.latitude}: ${lat.isEmpty ? '—' : lat}',
          style: AppTextStyles.bodyText(
            context,
          ).copyWith(fontFamily: AppFonts.primaryFont, color: AppColors.black),
        ),
        AppSpacing.vertical(context, 0.004),
        Text(
          '${AppTexts.longitude}: ${lng.isEmpty ? '—' : lng}',
          style: AppTextStyles.bodyText(
            context,
          ).copyWith(fontFamily: AppFonts.primaryFont, color: AppColors.black),
        ),
      ],
    );
  }
}
