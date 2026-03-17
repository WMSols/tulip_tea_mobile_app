/// API base URL and path segments. Base URL loaded from env in [EnvConfig].
class ApiConstants {
  ApiConstants._();

  static const int connectTimeoutMs = 100000;
  static const int receiveTimeoutMs = 100000;

  // Auth
  static const String loginOrderBooker = '/auth/login/order-booker';
  static const String loginDeliveryMan = '/auth/login/delivery-man';

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
  static String ordersByDeliveryMan(int deliveryManId) =>
      '/orders/delivery-man/$deliveryManId';

  /// Pending/active orders only (backend returns list with delivery embedded).
  static String ordersByDeliveryManPending(int deliveryManId) =>
      '/orders/delivery-man/$deliveryManId?pending=true';

  /// Deliveries-screen orders only (completed; backend returns with full delivery).
  static String ordersByDeliveryManDeliveries(int deliveryManId) =>
      '/orders/delivery-man/$deliveryManId?deliveries=true';
  static String orderById(int orderId) => '/orders/$orderId';
  static String orderCollectPayment(int orderId) =>
      '/orders/$orderId/collect-payment';

  // Deliveries (by delivery man)
  static String deliveriesByDeliveryMan(int deliveryManId) =>
      '/deliveries/delivery-man/$deliveryManId';

  // Daily Collections
  static const String dailyCollectionsByOrderBooker =
      '/daily-collections/order-booker';
  static String dailyCollectionsByDeliveryMan(int deliveryManId) =>
      '/daily-collections/delivery-man/$deliveryManId';

  // Credit Limit Requests
  static const String creditLimitRequestsByOrderBooker =
      '/credit-limit-requests/order-booker';

  /// GET my credit limit requests for order booker (all requests for this order booker, no filtering).
  static String creditLimitRequestsMyRequests(int orderBookerId) =>
      '/credit-limit-requests/order-booker/$orderBookerId/my-requests';

  /// PUT resubmit disapproved credit limit request (order booker): requested_credit_limit, remarks.
  static String creditLimitRequestResubmit(int requestId) =>
      '/credit-limit-requests/$requestId/resubmit';

  // Products
  static const String productsActive = '/products/active';

  // Warehouses
  static const String warehouses = '/warehouses';
  static const String warehouseInventory = '/inventory';

  // Wallets (user_type: distributor | order_booker | delivery_man)
  static String walletBalance(String userType, int userId) =>
      '/wallets/$userType/$userId/balance';
  static String walletTransactions(
    String userType,
    int userId, {
    int limit = 100,
  }) => '/wallets/$userType/$userId/transactions?limit=$limit';
}
