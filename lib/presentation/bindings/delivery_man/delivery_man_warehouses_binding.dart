import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/domain/use_cases/auth_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/warehouse_use_case.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/delivery_man/warehouses/delivery_man_warehouses_controller.dart';

class DeliveryManWarehousesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeliveryManWarehousesController>(
      () => DeliveryManWarehousesController(
        Get.find<AuthUseCase>(),
        Get.find<WarehouseUseCase>(),
      ),
    );
  }
}
