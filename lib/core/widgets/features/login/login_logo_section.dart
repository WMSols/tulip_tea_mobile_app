import 'package:flutter/material.dart';

import 'package:tulip_tea_order_booker/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_order_booker/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_order_booker/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_order_booker/core/utils/app_styles/app_text_styles.dart';

/// Reusable logo section for login/auth screens: title and image.
class LoginLogoSection extends StatelessWidget {
  const LoginLogoSection({
    super.key,
    required this.title,
    required this.imagePath,
  });

  final String title;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppSpacing.vertical(context, 0.025),
        Text(
          title,
          style: AppTextStyles.headline(
            context,
          ).copyWith(color: AppColors.primary),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: AppResponsive.screenHeight(context) * 0.3,
          child: Image.asset(imagePath, fit: BoxFit.contain),
        ),
      ],
    );
  }
}
