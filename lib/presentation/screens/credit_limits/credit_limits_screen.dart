import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_order_booker/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_order_booker/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_order_booker/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_order_booker/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_order_booker/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_order_booker/presentation/controllers/credit_limits/credit_limits_controller.dart';
import 'package:tulip_tea_order_booker/presentation/screens/credit_limits/credit_limit_request_screen.dart';
import 'package:tulip_tea_order_booker/presentation/screens/credit_limits/my_requests_screen.dart';

class CreditLimitsScreen extends StatelessWidget {
  const CreditLimitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<CreditLimitsController>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppTexts.creditLimits,
          style: AppTextStyles.heading(
            context,
          ).copyWith(color: AppColors.white),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      body: Column(
        children: [
          Container(
            color: AppColors.lightGrey,
            child: Row(
              children: [
                Expanded(
                  child: Obx(
                    () => _TabButton(
                      label: AppTexts.requestChange,
                      icon: Iconsax.add_circle,
                      selected: c.selectedTabIndex.value == 0,
                      onTap: () => c.setTab(0),
                    ),
                  ),
                ),
                Expanded(
                  child: Obx(
                    () => _TabButton(
                      label: AppTexts.myRequests,
                      icon: Iconsax.document_text,
                      selected: c.selectedTabIndex.value == 1,
                      onTap: () => c.setTab(1),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(
              () => IndexedStack(
                index: c.selectedTabIndex.value,
                children: const [
                  CreditLimitRequestScreen(),
                  MyRequestsScreen(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: AppSpacing.symmetric(context, v: 0.015),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: AppResponsive.iconSize(context),
              color: selected ? AppColors.primary : AppColors.grey,
            ),
            AppSpacing.horizontal(context, 0.02),
            Flexible(
              child: Text(
                label,
                style: AppTextStyles.bodyText(context).copyWith(
                  color: selected ? AppColors.primary : AppColors.grey,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
