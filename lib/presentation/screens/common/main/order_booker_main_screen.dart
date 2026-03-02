import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/common/account/account_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/order_booker/credit_limits/credit_limits_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/order_booker/dashboard/order_booker_dashboard_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/order_booker/shops/shops_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/order_booker/visits/visits_screen.dart';

class OrderBookerMainScreen extends StatelessWidget {
  const OrderBookerMainScreen({super.key});

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
        screen: const OrderBookerDashboardScreen(),
        // screen: Placeholder(),
        item: ItemConfig(
          activeForegroundColor: AppColors.primary,
          icon: const Icon(Iconsax.element_3),
          title: AppTexts.dashboard,
        ),
      ),
      PersistentTabConfig(
        screen: const OrderBookerShopsScreen(),
        item: ItemConfig(
          activeForegroundColor: AppColors.primary,
          icon: const Icon(Iconsax.shop),
          title: AppTexts.shops,
        ),
      ),
      PersistentTabConfig(
        screen: const VisitsScreen(),
        item: ItemConfig(
          activeForegroundColor: AppColors.primary,
          icon: const Icon(Iconsax.location),
          title: AppTexts.visits,
        ),
      ),
      PersistentTabConfig(
        screen: const CreditLimitsScreen(),
        item: ItemConfig(
          activeForegroundColor: AppColors.primary,
          icon: const Icon(Iconsax.wallet_3),
          title: AppTexts.creditLimits,
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
