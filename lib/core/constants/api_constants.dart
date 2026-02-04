/// API base URL and path segments. Base URL loaded from env in [EnvConfig].
class ApiConstants {
  ApiConstants._();

  static const int connectTimeoutMs = 30000;
  static const int receiveTimeoutMs = 30000;

  // Auth
  static const String loginOrderBooker = '/auth/login/order-booker';

  // Zones
  static const String zones = '/zones/';

  // Routes
  static const String routesByOrderBooker = '/routes/order-booker';
  static const String routesByZone = '/routes/zone';

  // Shops
  static const String shopsByOrderBooker = '/shops/order-booker';

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
  static const String creditLimitRequestsAll = '/credit-limit-requests/all';

  // Products
  static const String productsActive = '/products/active';

  // Warehouses
  static const String warehouses = '/warehouses';
  static const String warehouseInventory = '/inventory';
}
