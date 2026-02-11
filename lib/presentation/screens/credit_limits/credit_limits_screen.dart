import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_order_booker/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_order_booker/core/widgets/common/app_custom_app_bar.dart';
import 'package:tulip_tea_order_booker/core/widgets/common/app_tab_bar.dart';

import 'package:tulip_tea_order_booker/presentation/controllers/credit_limits/credit_limits_controller.dart';
import 'package:tulip_tea_order_booker/presentation/screens/credit_limits/credit_limit_request_screen.dart';
import 'package:tulip_tea_order_booker/presentation/screens/credit_limits/my_requests_screen.dart';

class CreditLimitsScreen extends StatelessWidget {
  const CreditLimitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<CreditLimitsController>();
    return Scaffold(
      appBar: const AppCustomAppBar(title: AppTexts.creditLimits),
      body: Column(
        children: [
          Obx(
            () => AppTabBar(
              selectedIndex: c.selectedTabIndex.value,
              onTabChanged: c.setTab,
              tabs: const [
                AppTabBarItem(
                  icon: Iconsax.add_circle,
                  label: AppTexts.requestChange,
                ),
                AppTabBarItem(
                  icon: Iconsax.document_text,
                  label: AppTexts.myRequests,
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
