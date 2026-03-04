import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/data/models/warehouse/warehouse_model.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/auth_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/warehouse_use_case.dart';

class DeliveryManWarehousesController extends GetxController {
  DeliveryManWarehousesController(this._authUseCase, this._warehouseUseCase);

  final AuthUseCase _authUseCase;
  final WarehouseUseCase _warehouseUseCase;

  final warehouses = <WarehouseModel>[].obs;
  final isLoading = true.obs;

  @override
  void onReady() {
    loadWarehouses();
    super.onReady();
  }

  Future<void> loadWarehouses() async {
    final user = await _authUseCase.getCurrentUser();
    if (user == null) return;
    isLoading.value = true;
    try {
      final list = await _warehouseUseCase.getWarehousesByDeliveryMan(user.id);
      warehouses.assignAll(list);
    } catch (_) {
      warehouses.clear();
    } finally {
      isLoading.value = false;
    }
  }
}
