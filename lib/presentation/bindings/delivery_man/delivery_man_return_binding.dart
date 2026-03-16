import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/domain/use_cases/delivery_use_case.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/delivery_man/deliveries/delivery_man_return_controller.dart';

class DeliveryManReturnBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeliveryManReturnController>(
      () => DeliveryManReturnController(Get.find<DeliveryUseCase>()),
    );
  }
}
