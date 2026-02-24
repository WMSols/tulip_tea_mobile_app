import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_custom_app_bar.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_tab_bar.dart';

import 'package:tulip_tea_mobile_app/presentation/controllers/visits/visits_controller.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/visits/visit_history_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/visits/visit_register_screen.dart';

class VisitsScreen extends StatefulWidget {
  const VisitsScreen({super.key});

  @override
  State<VisitsScreen> createState() => _VisitsScreenState();
}

class _VisitsScreenState extends State<VisitsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    final visitsController = Get.find<VisitsController>();
    visitsController.switchToVisitHistoryTab = () {
      if (_tabController.index != 1) _tabController.animateTo(1);
    };
  }

  @override
  void dispose() {
    Get.find<VisitsController>().switchToVisitHistoryTab = null;
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Get.find<VisitsController>();
    return Scaffold(
      appBar: AppCustomAppBar(
        title: AppTexts.visits,
        bottom: AppTabBar(
          controller: _tabController,
          tabs: const [
            AppTabBarItem(
              icon: Iconsax.add_circle,
              label: AppTexts.registerVisit,
            ),
            AppTabBarItem(
              icon: Iconsax.calendar_1,
              label: AppTexts.visitHistory,
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [VisitRegisterScreen(), VisitHistoryScreen()],
      ),
    );
  }
}
