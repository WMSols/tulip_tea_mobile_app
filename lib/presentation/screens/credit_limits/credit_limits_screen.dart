import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_custom_app_bar.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_tab_bar.dart';

import 'package:tulip_tea_mobile_app/presentation/controllers/credit_limits/credit_limits_controller.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/credit_limits/credit_limit_request_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/credit_limits/my_requests_screen.dart';

class CreditLimitsScreen extends StatefulWidget {
  const CreditLimitsScreen({super.key});

  @override
  State<CreditLimitsScreen> createState() => _CreditLimitsScreenState();
}

class _CreditLimitsScreenState extends State<CreditLimitsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    final creditLimitsController = Get.find<CreditLimitsController>();
    creditLimitsController.switchToMyRequestsTab = () {
      if (_tabController.index != 1) _tabController.animateTo(1);
    };
  }

  @override
  void dispose() {
    Get.find<CreditLimitsController>().switchToMyRequestsTab = null;
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Get.find<CreditLimitsController>();
    return Scaffold(
      appBar: AppCustomAppBar(
        title: AppTexts.creditLimits,
        bottom: AppTabBar(
          controller: _tabController,
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
      body: TabBarView(
        controller: _tabController,
        children: const [
          CreditLimitRequestScreen(),
          MyRequestsScreen(),
        ],
      ),
    );
  }
}
