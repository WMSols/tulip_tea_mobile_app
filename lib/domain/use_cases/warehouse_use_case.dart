import 'package:tulip_tea_mobile_app/data/models/warehouse/warehouse_model.dart';
import 'package:tulip_tea_mobile_app/domain/repositories/warehouse_repository.dart';

class WarehouseUseCase {
  WarehouseUseCase(this._repo);
  final WarehouseRepository _repo;

  Future<List<WarehouseModel>> getWarehousesByDeliveryMan(int deliveryManId) =>
      _repo.getWarehousesByDeliveryMan(deliveryManId);
}
