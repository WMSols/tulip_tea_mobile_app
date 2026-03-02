import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/domain/use_cases/auth_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/route_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/wallet_use_case.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/order_booker/dashboard/order_booker_dashboard_controller.dart';

class OrderBookerDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderBookerDashboardController>(
      () => OrderBookerDashboardController(
        Get.find<AuthUseCase>(),
        Get.find<RouteUseCase>(),
        Get.find<WalletUseCase>(),
      ),
    );
  }
}
