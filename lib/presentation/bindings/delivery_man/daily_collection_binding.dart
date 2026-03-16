import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/domain/use_cases/auth_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/daily_collection_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/shop_use_case.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/delivery_man/daily_collection_controller.dart';

class DailyCollectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DailyCollectionController>(
      () => DailyCollectionController(
        Get.find<ShopUseCase>(),
        Get.find<DailyCollectionUseCase>(),
        Get.find<AuthUseCase>(),
      ),
    );
  }
}
