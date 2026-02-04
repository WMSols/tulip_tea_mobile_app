import 'package:get/get.dart';

import 'package:tulip_tea_order_booker/domain/use_cases/auth_use_case.dart';
import 'package:tulip_tea_order_booker/domain/use_cases/route_use_case.dart';
import 'package:tulip_tea_order_booker/presentation/controllers/dashboard/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(
      () => DashboardController(
        Get.find<AuthUseCase>(),
        Get.find<RouteUseCase>(),
      ),
    );
  }
}
