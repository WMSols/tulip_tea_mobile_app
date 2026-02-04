import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_order_booker/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_order_booker/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_order_booker/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_order_booker/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_order_booker/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_order_booker/presentation/controllers/visits/visits_controller.dart';
import 'package:tulip_tea_order_booker/presentation/screens/visits/daily_collection_screen.dart';
import 'package:tulip_tea_order_booker/presentation/screens/visits/order_create_screen.dart';
import 'package:tulip_tea_order_booker/presentation/screens/visits/visit_history_screen.dart';
import 'package:tulip_tea_order_booker/presentation/screens/visits/visit_register_screen.dart';

class VisitsScreen extends StatelessWidget {
  const VisitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<VisitsController>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppTexts.visits,
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
                      label: AppTexts.registerVisit,
                      icon: Iconsax.add_circle,
                      selected: c.selectedTabIndex.value == 0,
                      onTap: () => c.setTab(0),
                    ),
                  ),
                ),
                Expanded(
                  child: Obx(
                    () => _TabButton(
                      label: AppTexts.createOrder,
                      icon: Iconsax.box_1,
                      selected: c.selectedTabIndex.value == 1,
                      onTap: () => c.setTab(1),
                    ),
                  ),
                ),
                Expanded(
                  child: Obx(
                    () => _TabButton(
                      label: AppTexts.submitCollection,
                      icon: Iconsax.wallet_money,
                      selected: c.selectedTabIndex.value == 2,
                      onTap: () => c.setTab(2),
                    ),
                  ),
                ),
                Expanded(
                  child: Obx(
                    () => _TabButton(
                      label: AppTexts.visitHistory,
                      icon: Iconsax.calendar_1,
                      selected: c.selectedTabIndex.value == 3,
                      onTap: () => c.setTab(3),
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
                  VisitRegisterScreen(),
                  OrderCreateScreen(),
                  DailyCollectionScreen(),
                  VisitHistoryScreen(),
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
            AppSpacing.horizontal(context, 0.01),
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
