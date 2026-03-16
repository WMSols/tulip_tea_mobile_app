import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/domain/use_cases/auth_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/order_use_case.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/delivery_man/deliveries/delivery_man_deliveries_controller.dart';

class DeliveryManDeliveriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeliveryManDeliveriesController>(
      () => DeliveryManDeliveriesController(
        Get.find<AuthUseCase>(),
        Get.find<OrderUseCase>(),
      ),
    );
  }
}
