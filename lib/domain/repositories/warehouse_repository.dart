import 'package:tulip_tea_mobile_app/data/models/warehouse/warehouse_model.dart';

abstract class WarehouseRepository {
  /// Get all warehouses assigned to a delivery man
  Future<List<WarehouseModel>> getWarehousesByDeliveryMan(int deliveryManId);
}
