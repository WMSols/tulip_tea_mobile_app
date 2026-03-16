import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/domain/use_cases/auth_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/delivery_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/warehouse_use_case.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/delivery_man/deliveries/delivery_man_pickup_controller.dart';

class DeliveryManPickupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeliveryManPickupController>(
      () => DeliveryManPickupController(
        Get.find<DeliveryUseCase>(),
        Get.find<WarehouseUseCase>(),
        Get.find<AuthUseCase>(),
      ),
    );
  }
}
