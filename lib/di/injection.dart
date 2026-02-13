import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/core/network/connectivity_service.dart';
import 'package:tulip_tea_mobile_app/core/network/dio_client.dart';
import 'package:tulip_tea_mobile_app/data/data_sources/local/auth_token_holder.dart';
import 'package:tulip_tea_mobile_app/data/data_sources/local/secure_storage_source.dart';
import 'package:tulip_tea_mobile_app/data/data_sources/remote/auth_api.dart';
import 'package:tulip_tea_mobile_app/data/data_sources/remote/credit_limit_requests_api.dart';
import 'package:tulip_tea_mobile_app/data/data_sources/remote/daily_collections_api.dart';
import 'package:tulip_tea_mobile_app/data/data_sources/remote/orders_api.dart';
import 'package:tulip_tea_mobile_app/data/data_sources/remote/products_api.dart';
import 'package:tulip_tea_mobile_app/data/data_sources/remote/routes_api.dart';
import 'package:tulip_tea_mobile_app/data/data_sources/remote/shop_visits_api.dart';
import 'package:tulip_tea_mobile_app/data/data_sources/remote/shops_api.dart';
import 'package:tulip_tea_mobile_app/data/data_sources/remote/visit_tasks_api.dart';
import 'package:tulip_tea_mobile_app/data/data_sources/remote/zones_api.dart';
import 'package:tulip_tea_mobile_app/data/repositories/auth_repository_impl.dart';
import 'package:tulip_tea_mobile_app/data/repositories/credit_limit_request_repository_impl.dart';
import 'package:tulip_tea_mobile_app/data/repositories/daily_collection_repository_impl.dart';
import 'package:tulip_tea_mobile_app/data/repositories/order_repository_impl.dart';
import 'package:tulip_tea_mobile_app/data/repositories/product_repository_impl.dart';
import 'package:tulip_tea_mobile_app/data/repositories/route_repository_impl.dart';
import 'package:tulip_tea_mobile_app/data/repositories/shop_repository_impl.dart';
import 'package:tulip_tea_mobile_app/data/repositories/shop_visit_repository_impl.dart';
import 'package:tulip_tea_mobile_app/data/repositories/visit_task_repository_impl.dart';
import 'package:tulip_tea_mobile_app/data/repositories/zone_repository_impl.dart';
import 'package:tulip_tea_mobile_app/domain/repositories/auth_repository.dart';
import 'package:tulip_tea_mobile_app/domain/repositories/credit_limit_request_repository.dart';
import 'package:tulip_tea_mobile_app/domain/repositories/daily_collection_repository.dart';
import 'package:tulip_tea_mobile_app/domain/repositories/order_repository.dart';
import 'package:tulip_tea_mobile_app/domain/repositories/product_repository.dart';
import 'package:tulip_tea_mobile_app/domain/repositories/route_repository.dart';
import 'package:tulip_tea_mobile_app/domain/repositories/shop_repository.dart';
import 'package:tulip_tea_mobile_app/domain/repositories/shop_visit_repository.dart';
import 'package:tulip_tea_mobile_app/domain/repositories/visit_task_repository.dart';
import 'package:tulip_tea_mobile_app/domain/repositories/zone_repository.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/auth_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/credit_limit_request_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/daily_collection_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/order_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/product_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/route_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/shop_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/shop_visit_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/visit_task_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/zone_use_case.dart';

void setupDependencyInjection() {
  // Local
  Get.put<AuthTokenHolder>(AuthTokenHolder(), permanent: true);
  Get.put<SecureStorageSource>(SecureStorageSource(), permanent: true);

  // Connectivity (for no connection banner and guarding critical actions)
  Get.put<ConnectivityService>(ConnectivityService(), permanent: true);

  // Dio with auth interceptor
  DioClient.instanceWith(
    getToken: () => Get.find<AuthTokenHolder>().token,
    onUnauthorized: () {
      Get.find<AuthTokenHolder>().clear();
      Get.find<SecureStorageSource>().clearAuth();
    },
  );

  // APIs
  Get.put<AuthApi>(AuthApi(), permanent: true);
  Get.put<RoutesApi>(RoutesApi(), permanent: true);
  Get.put<ZonesApi>(ZonesApi(), permanent: true);
  Get.put<ShopsApi>(ShopsApi(), permanent: true);
  Get.put<ShopVisitsApi>(ShopVisitsApi(), permanent: true);
  Get.put<VisitTasksApi>(VisitTasksApi(), permanent: true);
  Get.put<OrdersApi>(OrdersApi(), permanent: true);
  Get.put<DailyCollectionsApi>(DailyCollectionsApi(), permanent: true);
  Get.put<CreditLimitRequestsApi>(CreditLimitRequestsApi(), permanent: true);
  Get.put<ProductsApi>(ProductsApi(), permanent: true);

  // Repositories
  Get.put<AuthRepository>(
    AuthRepositoryImpl(
      Get.find<AuthApi>(),
      Get.find<SecureStorageSource>(),
      Get.find<AuthTokenHolder>(),
    ),
    permanent: true,
  );
  Get.put<RouteRepository>(
    RouteRepositoryImpl(Get.find<RoutesApi>()),
    permanent: true,
  );
  Get.put<ZoneRepository>(
    ZoneRepositoryImpl(Get.find<ZonesApi>()),
    permanent: true,
  );
  Get.put<ShopRepository>(
    ShopRepositoryImpl(Get.find<ShopsApi>()),
    permanent: true,
  );
  Get.put<ShopVisitRepository>(
    ShopVisitRepositoryImpl(Get.find<ShopVisitsApi>()),
    permanent: true,
  );
  Get.put<VisitTaskRepository>(
    VisitTaskRepositoryImpl(Get.find<VisitTasksApi>()),
    permanent: true,
  );
  Get.put<OrderRepository>(
    OrderRepositoryImpl(Get.find<OrdersApi>()),
    permanent: true,
  );
  Get.put<DailyCollectionRepository>(
    DailyCollectionRepositoryImpl(Get.find<DailyCollectionsApi>()),
    permanent: true,
  );
  Get.put<CreditLimitRequestRepository>(
    CreditLimitRequestRepositoryImpl(Get.find<CreditLimitRequestsApi>()),
    permanent: true,
  );
  Get.put<ProductRepository>(
    ProductRepositoryImpl(Get.find<ProductsApi>()),
    permanent: true,
  );

  // Use cases
  Get.put<AuthUseCase>(
    AuthUseCase(Get.find<AuthRepository>()),
    permanent: true,
  );
  Get.put<RouteUseCase>(
    RouteUseCase(Get.find<RouteRepository>()),
    permanent: true,
  );
  Get.put<ZoneUseCase>(
    ZoneUseCase(Get.find<ZoneRepository>()),
    permanent: true,
  );
  Get.put<ShopUseCase>(
    ShopUseCase(Get.find<ShopRepository>()),
    permanent: true,
  );
  Get.put<ShopVisitUseCase>(
    ShopVisitUseCase(Get.find<ShopVisitRepository>()),
    permanent: true,
  );
  Get.put<VisitTaskUseCase>(
    VisitTaskUseCase(Get.find<VisitTaskRepository>()),
    permanent: true,
  );
  Get.put<OrderUseCase>(
    OrderUseCase(Get.find<OrderRepository>()),
    permanent: true,
  );
  Get.put<DailyCollectionUseCase>(
    DailyCollectionUseCase(Get.find<DailyCollectionRepository>()),
    permanent: true,
  );
  Get.put<CreditLimitRequestUseCase>(
    CreditLimitRequestUseCase(Get.find<CreditLimitRequestRepository>()),
    permanent: true,
  );
  Get.put<ProductUseCase>(
    ProductUseCase(Get.find<ProductRepository>()),
    permanent: true,
  );
}
