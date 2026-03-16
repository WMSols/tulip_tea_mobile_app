import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/domain/use_cases/delivery_use_case.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/delivery_man/orders/delivery_man_order_detail_controller.dart';

class DeliveryManOrderDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeliveryManOrderDetailController>(
      () => DeliveryManOrderDetailController(Get.find<DeliveryUseCase>()),
    );
  }
}
