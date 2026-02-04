import 'package:get/get.dart';

import 'package:tulip_tea_order_booker/domain/use_cases/auth_use_case.dart';
import 'package:tulip_tea_order_booker/domain/use_cases/route_use_case.dart';
import 'package:tulip_tea_order_booker/domain/use_cases/shop_use_case.dart';
import 'package:tulip_tea_order_booker/domain/use_cases/zone_use_case.dart';
import 'package:tulip_tea_order_booker/presentation/controllers/shops/my_shops_controller.dart';
import 'package:tulip_tea_order_booker/presentation/controllers/shops/shop_register_controller.dart';
import 'package:tulip_tea_order_booker/presentation/controllers/shops/shops_controller.dart';

class ShopsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShopsController>(() => ShopsController());
    Get.lazyPut<ShopRegisterController>(
      () => ShopRegisterController(
        Get.find<AuthUseCase>(),
        Get.find<ZoneUseCase>(),
        Get.find<RouteUseCase>(),
        Get.find<ShopUseCase>(),
      ),
    );
    Get.lazyPut<MyShopsController>(
      () => MyShopsController(Get.find<AuthUseCase>(), Get.find<ShopUseCase>()),
    );
  }
}
