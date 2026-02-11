import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_order_booker/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_order_booker/core/widgets/common/app_custom_app_bar.dart';
import 'package:tulip_tea_order_booker/core/widgets/common/app_tab_bar.dart';

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
      appBar: const AppCustomAppBar(title: AppTexts.visits),
      body: Column(
        children: [
          Obx(
            () => AppTabBar(
              selectedIndex: c.selectedTabIndex.value,
              onTabChanged: c.setTab,
              tabs: const [
                AppTabBarItem(
                  icon: Iconsax.add_circle,
                  label: AppTexts.registerVisit,
                ),
                AppTabBarItem(icon: Iconsax.box_1, label: AppTexts.createOrder),
                AppTabBarItem(
                  icon: Iconsax.wallet_money,
                  label: AppTexts.submitCollection,
                ),
                AppTabBarItem(
                  icon: Iconsax.calendar_1,
                  label: AppTexts.visitHistory,
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
