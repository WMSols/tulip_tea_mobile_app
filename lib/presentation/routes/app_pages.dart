import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/presentation/bindings/common/account_binding.dart';
import 'package:tulip_tea_mobile_app/presentation/bindings/common/auth_binding.dart';
import 'package:tulip_tea_mobile_app/presentation/bindings/delivery_man/delivery_man_deliver_binding.dart';
import 'package:tulip_tea_mobile_app/presentation/bindings/delivery_man/delivery_man_order_detail_binding.dart';
import 'package:tulip_tea_mobile_app/presentation/bindings/delivery_man/delivery_man_pickup_binding.dart';
import 'package:tulip_tea_mobile_app/presentation/bindings/delivery_man/delivery_man_delivery_detail_binding.dart';
import 'package:tulip_tea_mobile_app/presentation/bindings/delivery_man/daily_collection_binding.dart';
import 'package:tulip_tea_mobile_app/presentation/bindings/delivery_man/delivery_man_return_binding.dart';
import 'package:tulip_tea_mobile_app/presentation/bindings/order_booker/credit_limits_binding.dart';
import 'package:tulip_tea_mobile_app/presentation/bindings/order_booker/dashboard_binding.dart';
import 'package:tulip_tea_mobile_app/presentation/bindings/common/main_binding.dart';
import 'package:tulip_tea_mobile_app/presentation/bindings/common/onboarding_binding.dart';
import 'package:tulip_tea_mobile_app/presentation/bindings/order_booker/shop_edit_binding.dart';
import 'package:tulip_tea_mobile_app/presentation/bindings/order_booker/shops_binding.dart';
import 'package:tulip_tea_mobile_app/presentation/bindings/order_booker/visits_binding.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/common/account/account_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/common/auth/login_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/common/auth/select_role_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/order_booker/credit_limits/credit_limit_request_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/order_booker/credit_limits/credit_limits_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/order_booker/credit_limits/my_request_details_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/order_booker/credit_limits/my_requests_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/order_booker/credit_limits/request_again_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/order_booker/dashboard/order_booker_dashboard_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/common/main/order_booker_main_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/common/main/delivery_man_main_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/common/onboarding/onboarding_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/order_booker/shops/my_shop_details_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/order_booker/shops/my_shops_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/order_booker/shops/shop_edit_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/order_booker/shops/shop_register_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/order_booker/shops/shops_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/order_booker/visits/visit_details_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/order_booker/visits/visit_history_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/order_booker/visits/visit_register_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/order_booker/visits/visits_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/delivery_man/daily_collection/daily_collection_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/delivery_man/dashboard/delivery_man_dashboard_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/delivery_man/orders/order_detail_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/delivery_man/orders/orders_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/delivery_man/deliveries/delivery_detail_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/delivery_man/deliveries/deliver_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/delivery_man/deliveries/deliveries_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/delivery_man/deliveries/pickup_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/delivery_man/deliveries/return_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/delivery_man/warehouses/warehouse_detail_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/screens/delivery_man/warehouses/warehouses_screen.dart';
import 'package:tulip_tea_mobile_app/presentation/routes/app_routes.dart';

class AppPages {
  static const String initial = AppRoutes.selectRole;

  static final List<GetPage<dynamic>> routes = [
    GetPage(name: AppRoutes.selectRole, page: () => const SelectRoleScreen()),
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
      name: AppRoutes.obMain,
      page: () => const OrderBookerMainScreen(),
      binding: MainBinding(),
    ),
    GetPage(
      name: AppRoutes.dashboard,
      page: () => const OrderBookerDashboardScreen(),
      binding: OrderBookerDashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.shops,
      page: () => const OrderBookerShopsScreen(),
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
      name: AppRoutes.visitDetails,
      page: () => const VisitDetailsScreen(),
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
      name: AppRoutes.myRequestDetails,
      page: () => const MyRequestDetailsScreen(),
    ),
    GetPage(
      name: AppRoutes.requestAgain,
      page: () => const RequestAgainScreen(),
    ),
    GetPage(
      name: AppRoutes.account,
      page: () => const AccountScreen(),
      binding: AccountBinding(),
    ),

    // ==================== Delivery Man Routes ====================
    GetPage(
      name: AppRoutes.dmMain,
      page: () => const DeliveryManMainScreen(),
      binding: MainBinding(),
    ),
    GetPage(
      name: AppRoutes.dmDashboard,
      page: () => const DeliveryManDashboardScreen(),
    ),
    GetPage(
      name: AppRoutes.dmOrders,
      page: () => const DeliveryManOrdersScreen(),
    ),
    GetPage(
      name: AppRoutes.dmOrderDetail,
      page: () => const DeliveryManOrderDetailScreen(),
      binding: DeliveryManOrderDetailBinding(),
    ),
    GetPage(
      name: AppRoutes.dmDeliveries,
      page: () => const DeliveryManDeliveriesScreen(),
    ),
    GetPage(
      name: AppRoutes.dmDeliveryDetail,
      page: () => const DeliveryManDeliveryDetailScreen(),
      binding: DeliveryManDeliveryDetailBinding(),
    ),
    GetPage(
      name: AppRoutes.dmDeliveryPickup,
      page: () => const DeliveryManPickupScreen(),
      binding: DeliveryManPickupBinding(),
    ),
    GetPage(
      name: AppRoutes.dmDeliveryDeliver,
      page: () => const DeliveryManDeliverScreen(),
      binding: DeliveryManDeliverBinding(),
    ),
    GetPage(
      name: AppRoutes.dmDeliveryReturn,
      page: () => const DeliveryManReturnScreen(),
      binding: DeliveryManReturnBinding(),
    ),
    GetPage(
      name: AppRoutes.dmDailyCollection,
      page: () => const DailyCollectionScreen(),
      binding: DailyCollectionBinding(),
    ),
    GetPage(
      name: AppRoutes.dmWarehouses,
      page: () => const DeliveryManWarehousesScreen(),
    ),
    GetPage(
      name: AppRoutes.dmWarehouseDetail,
      page: () => const DeliveryManWarehouseDetailScreen(),
    ),
  ];
}
