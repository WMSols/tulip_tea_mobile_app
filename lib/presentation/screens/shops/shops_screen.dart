import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_custom_app_bar.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_tab_bar.dart';

import 'package:tulip_tea_mobile_app/presentation/controllers/shops/shops_controller.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/shops/my_shops_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/shops/shop_register_screen.dart';

class ShopsScreen extends StatefulWidget {
  const ShopsScreen({super.key});

  @override
  State<ShopsScreen> createState() => _ShopsScreenState();
}

class _ShopsScreenState extends State<ShopsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    final shopsController = Get.find<ShopsController>();
    shopsController.switchToMyShopsTab = () {
      if (_tabController.index != 1) _tabController.animateTo(1);
    };
  }

  @override
  void dispose() {
    Get.find<ShopsController>().switchToMyShopsTab = null;
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Get.find<ShopsController>();
    return Scaffold(
      appBar: AppCustomAppBar(
        title: AppTexts.shops,
        bottom: AppTabBar(
          controller: _tabController,
          tabs: const [
            AppTabBarItem(icon: Iconsax.shop_add, label: AppTexts.registerShop),
            AppTabBarItem(icon: Iconsax.shop, label: AppTexts.myShops),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [ShopRegisterScreen(), MyShopsScreen()],
      ),
    );
  }
}
