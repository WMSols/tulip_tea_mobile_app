import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/common/account/account_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/delivery_man/dashboard/delivery_man_dashboard_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/delivery_man/orders/orders_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/delivery_man/deliveries/deliveries_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/delivery_man/warehouses/warehouses_screen.dart';

class DeliveryManMainScreen extends StatelessWidget {
  const DeliveryManMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      tabs: _buildTabs(),
      navBarBuilder: (navBarConfig) => Style4BottomNavBar(
        navBarConfig: navBarConfig,
        navBarDecoration: NavBarDecoration(color: AppColors.white),
      ),
    );
  }

  List<PersistentTabConfig> _buildTabs() {
    return [
      PersistentTabConfig(
        screen: const DeliveryManDashboardScreen(),
        item: ItemConfig(
          activeForegroundColor: AppColors.primary,
          icon: const Icon(Iconsax.element_3),
          title: AppTexts.dashboard,
        ),
      ),
      PersistentTabConfig(
        screen: const DeliveryManOrdersScreen(),
        item: ItemConfig(
          activeForegroundColor: AppColors.primary,
          icon: const Icon(Iconsax.document_text),
          title: AppTexts.orders,
        ),
      ),
      PersistentTabConfig(
        screen: const DeliveryManDeliveriesScreen(),
        item: ItemConfig(
          activeForegroundColor: AppColors.primary,
          icon: const Icon(Iconsax.truck),
          title: AppTexts.deliveries,
        ),
      ),
      PersistentTabConfig(
        screen: const DeliveryManWarehousesScreen(),
        item: ItemConfig(
          activeForegroundColor: AppColors.primary,
          icon: const Icon(Iconsax.building),
          title: AppTexts.warehouses,
        ),
      ),
      PersistentTabConfig(
        screen: const AccountScreen(),
        item: ItemConfig(
          activeForegroundColor: AppColors.primary,
          icon: const Icon(Iconsax.user),
          title: AppTexts.account,
        ),
      ),
    ];
  }
}
