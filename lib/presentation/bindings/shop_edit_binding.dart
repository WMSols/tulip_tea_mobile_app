import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/domain/entities/shop.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/auth_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/route_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/shop_use_case.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/shops/shop_edit_controller.dart';

class ShopEditBinding extends Bindings {
  @override
  void dependencies() {
    final shop = Get.arguments as Shop?;
    if (shop != null) {
      Get.lazyPut<ShopEditController>(
        () => ShopEditController(
          Get.find<AuthUseCase>(),
          Get.find<RouteUseCase>(),
          Get.find<ShopUseCase>(),
          shop,
        ),
      );
    }
  }
}
