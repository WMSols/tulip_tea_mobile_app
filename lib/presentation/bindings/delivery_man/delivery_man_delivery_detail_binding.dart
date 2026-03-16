import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/presentation/controllers/delivery_man/deliveries/delivery_man_delivery_detail_controller.dart';

class DeliveryManDeliveryDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeliveryManDeliveryDetailController>(
      () => DeliveryManDeliveryDetailController(),
    );
  }
}
