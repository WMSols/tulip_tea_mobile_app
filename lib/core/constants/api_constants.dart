/// API base URL and path segments. Base URL loaded from env in [EnvConfig].
class ApiConstants {
  ApiConstants._();

  static const int connectTimeoutMs = 100000;
  static const int receiveTimeoutMs = 100000;

  // Auth
  static const String loginOrderBooker = '/auth/login/order-booker';

  // Zones
  static const String zones = '/zones/';

  // Routes
  static const String routesByOrderBooker = '/routes/order-booker';
  static const String routesByZone = '/routes/zone';

  // Weekly Route Schedules (order booker's route schedule by day)
  static String weeklyRouteSchedulesByOrderBooker(int orderBookerId) =>
      '/weekly-route-schedules/order-booker/$orderBookerId';

  // Shops
  static const String shopsByOrderBooker = '/shops/order-booker';
  static String shopCreditInfo(int shopId) => '/shops/$shopId/credit-info';
  static String shopResubmit(int shopId) => '/shops/$shopId/resubmit';

  // Visit Tasks (today's scheduled shops for order booker)
  static String visitTasksToday(int orderBookerId) =>
      '/visit-tasks/order-booker/$orderBookerId/today';

  // Shop Visits
  static const String shopVisitsByOrderBooker = '/shop-visits/order-booker';

  // Orders
  static const String ordersByOrderBooker = '/orders/order-booker';

  // Daily Collections
  static const String dailyCollectionsByOrderBooker =
      '/daily-collections/order-booker';

  // Credit Limit Requests
  static const String creditLimitRequestsByOrderBooker =
      '/credit-limit-requests/order-booker';
  static const String creditLimitRequestsPending =
      '/credit-limit-requests/pending';

  // Products
  static const String productsActive = '/products/active';

  // Warehouses
  static const String warehouses = '/warehouses';
  static const String warehouseInventory = '/inventory';
}
