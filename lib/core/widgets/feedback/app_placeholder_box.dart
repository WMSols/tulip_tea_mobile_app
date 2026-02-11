import 'package:flutter/material.dart';
import 'package:tulip_tea_order_booker/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_order_booker/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_order_booker/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_order_booker/core/utils/app_texts/app_texts.dart';

/// Placeholder box when no image or content is available.
class AppPlaceholderBox extends StatelessWidget {
  const AppPlaceholderBox({super.key, this.label, this.heightFactor = 0.25});

  final String? label;
  final double heightFactor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppResponsive.screenHeight(context) * heightFactor,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppResponsive.radius(context)),
        color: AppColors.lightGrey,
        border: Border.all(color: AppColors.lightGrey),
      ),
      alignment: Alignment.center,
      child: Text(
        label ?? AppTexts.notAvailable,
        style: AppTextStyles.hintText(context).copyWith(color: AppColors.grey),
      ),
    );
  }
}
