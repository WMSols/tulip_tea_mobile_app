import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import 'package:tulip_tea_order_booker/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_order_booker/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_order_booker/presentation/screens/account/account_screen.dart';
import 'package:tulip_tea_order_booker/presentation/screens/credit_limits/credit_limits_screen.dart';
import 'package:tulip_tea_order_booker/presentation/screens/dashboard/dashboard_screen.dart';
import 'package:tulip_tea_order_booker/presentation/screens/shops/shops_screen.dart';
import 'package:tulip_tea_order_booker/presentation/screens/visits/visits_screen.dart';

class MainShellScreen extends StatelessWidget {
  const MainShellScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      tabs: _buildTabs(),
      navBarBuilder: (navBarConfig) => Style1BottomNavBar(
        navBarConfig: navBarConfig,
        navBarDecoration: NavBarDecoration(color: AppColors.white),
      ),
    );
  }

  List<PersistentTabConfig> _buildTabs() {
    return [
      PersistentTabConfig(
        screen: const DashboardScreen(),
        item: ItemConfig(
          icon: const Icon(Iconsax.element_3),
          title: AppTexts.dashboard,
        ),
      ),
      PersistentTabConfig(
        screen: const ShopsScreen(),
        item: ItemConfig(icon: const Icon(Iconsax.shop), title: AppTexts.shops),
      ),
      PersistentTabConfig(
        screen: const VisitsScreen(),
        item: ItemConfig(
          icon: const Icon(Iconsax.location),
          title: AppTexts.visits,
        ),
      ),
      PersistentTabConfig(
        screen: const CreditLimitsScreen(),
        item: ItemConfig(
          icon: const Icon(Iconsax.wallet_3),
          title: AppTexts.creditLimits,
        ),
      ),
      PersistentTabConfig(
        screen: const AccountScreen(),
        item: ItemConfig(
          icon: const Icon(Iconsax.user),
          title: AppTexts.account,
        ),
      ),
    ];
  }
}
