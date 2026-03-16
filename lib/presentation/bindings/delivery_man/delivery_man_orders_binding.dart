import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/domain/use_cases/auth_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/order_use_case.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/delivery_man/orders/delivery_man_orders_controller.dart';

class DeliveryManOrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeliveryManOrdersController>(
      () => DeliveryManOrdersController(
        Get.find<AuthUseCase>(),
        Get.find<OrderUseCase>(),
      ),
    );
  }
}
