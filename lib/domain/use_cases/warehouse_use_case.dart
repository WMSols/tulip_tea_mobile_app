import 'package:tulip_tea_mobile_app/domain/entities/warehouse_inventory_item.dart';
import 'package:tulip_tea_mobile_app/domain/repositories/warehouse_repository.dart';

class WarehouseUseCase {
  WarehouseUseCase(this._repo);
  final WarehouseRepository _repo;

  Future<List<WarehouseInventoryItem>> getWarehouseInventory(int warehouseId) =>
      _repo.getWarehouseInventory(warehouseId);
}
