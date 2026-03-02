/// Route name constants. Use with Get.toNamed(AppRoutes.xyz).
abstract class AppRoutes {
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String loginOrderBooker = '/login-order-booker';
  static const String loginDeliveryMan = '/login-delivery-man';
  static const String selectRole = '/select-role';
  static const String obMain = '/ob-main';
  static const String dmMain = '/dm-main';
  static const String dashboard = '/main/dashboard';
  static const String dmDashboard = '/dm-main/dashboard';
  static const String shops = '/main/shops';
  static const String shopRegister = '/main/shops/register';
  static const String myShops = '/main/shops/my-shops';
  static const String myShopDetails = '/main/shops/my-shops/details';
  static const String shopEdit = '/main/shops/edit';
  static const String visits = '/main/visits';
  static const String visitRegister = '/main/visits/register';
  static const String visitHistory = '/main/visits/history';
  static const String visitDetails = '/main/visits/history/details';
  static const String creditLimits = '/main/credit-limits';
  static const String creditLimitRequest = '/main/credit-limits/request';
  static const String myRequests = '/main/credit-limits/my-requests';
  static const String myRequestDetails =
      '/main/credit-limits/my-requests/details';
  static const String requestAgain =
      '/main/credit-limits/my-requests/request-again';
  static const String account = '/main/account';

  // Delivery Man Routes
  static const String dmOrders = '/dm-main/orders';
  static const String dmOrderDetail = '/dm-main/orders/detail';
  static const String dmDeliveries = '/dm-main/deliveries';
  static const String dmDeliveryPickup = '/dm-main/deliveries/pickup';
  static const String dmDeliveryDeliver = '/dm-main/deliveries/deliver';
  static const String dmDeliveryReturn = '/dm-main/deliveries/return';
  static const String dmWarehouses = '/dm-main/warehouses';
  static const String dmWarehouseDetail = '/dm-main/warehouses/detail';
}
