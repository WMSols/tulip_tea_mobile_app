import 'package:tulip_tea_mobile_app/domain/entities/warehouse_inventory_item.dart';

abstract class WarehouseRepository {
  Future<List<WarehouseInventoryItem>> getWarehouseInventory(int warehouseId);
}
