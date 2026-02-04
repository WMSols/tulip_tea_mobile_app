import 'package:tulip_tea_order_booker/domain/entities/warehouse_inventory_item.dart';

abstract class WarehouseRepository {
  Future<List<WarehouseInventoryItem>> getWarehouseInventory(int warehouseId);
}
