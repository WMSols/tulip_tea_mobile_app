import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/domain/use_cases/auth_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/route_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/shop_use_case.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/shops/my_shops_controller.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/shops/shop_register_controller.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/shops/shops_controller.dart';

class ShopsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShopsController>(() => ShopsController());
    Get.lazyPut<ShopRegisterController>(
      () => ShopRegisterController(
        Get.find<AuthUseCase>(),
        Get.find<RouteUseCase>(),
        Get.find<ShopUseCase>(),
      ),
    );
    Get.lazyPut<MyShopsController>(
      () => MyShopsController(Get.find<AuthUseCase>(), Get.find<ShopUseCase>()),
    );
  }
}
