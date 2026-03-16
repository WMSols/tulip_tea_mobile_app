import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/domain/use_cases/delivery_use_case.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/delivery_man/deliveries/delivery_man_deliver_controller.dart';

class DeliveryManDeliverBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeliveryManDeliverController>(
      () => DeliveryManDeliverController(Get.find<DeliveryUseCase>()),
    );
  }
}
