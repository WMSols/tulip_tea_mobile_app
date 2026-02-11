import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/presentation/bindings/account_binding.dart';
import 'package:tulip_tea_mobile_app/presentation/bindings/auth_binding.dart';
import 'package:tulip_tea_mobile_app/presentation/bindings/credit_limits_binding.dart';
import 'package:tulip_tea_mobile_app/presentation/bindings/dashboard_binding.dart';
import 'package:tulip_tea_mobile_app/presentation/bindings/main_binding.dart';
import 'package:tulip_tea_mobile_app/presentation/bindings/onboarding_binding.dart';
import 'package:tulip_tea_mobile_app/presentation/bindings/shop_edit_binding.dart';
import 'package:tulip_tea_mobile_app/presentation/bindings/shops_binding.dart';
import 'package:tulip_tea_mobile_app/presentation/bindings/visits_binding.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/account/account_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/auth/login_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/credit_limits/credit_limit_request_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/credit_limits/credit_limits_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/credit_limits/my_requests_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/dashboard/dashboard_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/main/main_shell_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/shops/my_shop_details_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/shops/my_shops_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/shops/shop_edit_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/shops/shop_register_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/shops/shops_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/visits/visit_history_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/visits/visit_register_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/visits/visits_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/routes/app_routes.dart';

class AppPages {
  static const String initial = AppRoutes.login;

  static final List<GetPage<dynamic>> routes = [
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingScreen(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.main,
      page: () => const MainShellScreen(),
      binding: MainBinding(),
    ),
    GetPage(
      name: AppRoutes.dashboard,
      page: () => const DashboardScreen(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.shops,
      page: () => const ShopsScreen(),
      binding: ShopsBinding(),
    ),
    GetPage(
      name: AppRoutes.shopRegister,
      page: () => const ShopRegisterScreen(),
    ),
    GetPage(name: AppRoutes.myShops, page: () => const MyShopsScreen()),
    GetPage(
      name: AppRoutes.myShopDetails,
      page: () => const MyShopDetailsScreen(),
    ),
    GetPage(
      name: AppRoutes.shopEdit,
      page: () => const ShopEditScreen(),
      binding: ShopEditBinding(),
    ),
    GetPage(
      name: AppRoutes.visits,
      page: () => const VisitsScreen(),
      binding: VisitsBinding(),
    ),
    GetPage(
      name: AppRoutes.visitRegister,
      page: () => const VisitRegisterScreen(),
    ),
    GetPage(
      name: AppRoutes.visitHistory,
      page: () => const VisitHistoryScreen(),
    ),
    GetPage(
      name: AppRoutes.creditLimits,
      page: () => const CreditLimitsScreen(),
      binding: CreditLimitsBinding(),
    ),
    GetPage(
      name: AppRoutes.creditLimitRequest,
      page: () => const CreditLimitRequestScreen(),
    ),
    GetPage(name: AppRoutes.myRequests, page: () => const MyRequestsScreen()),
    GetPage(
      name: AppRoutes.account,
      page: () => const AccountScreen(),
      binding: AccountBinding(),
    ),
  ];
}
