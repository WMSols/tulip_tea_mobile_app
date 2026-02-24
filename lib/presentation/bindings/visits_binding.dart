import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/domain/use_cases/auth_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/product_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/route_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/shop_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/shop_visit_use_case.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/visits/visit_history_controller.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/visits/visit_register_controller.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/visits/visits_controller.dart';

class VisitsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VisitsController>(() => VisitsController());
    Get.lazyPut<VisitRegisterController>(
      () => VisitRegisterController(
        Get.find<AuthUseCase>(),
        Get.find<ShopUseCase>(),
        Get.find<ProductUseCase>(),
        Get.find<ShopVisitUseCase>(),
        Get.find<RouteUseCase>(),
      ),
    );
    Get.lazyPut<VisitHistoryController>(
      () => VisitHistoryController(
        Get.find<AuthUseCase>(),
        Get.find<ShopVisitUseCase>(),
      ),
    );
  }
}
