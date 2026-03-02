import 'package:tulip_tea_mobile_app/data/data_sources/remote/warehouses_api.dart';
import 'package:tulip_tea_mobile_app/data/models/warehouse/warehouse_model.dart';
import 'package:tulip_tea_mobile_app/domain/repositories/warehouse_repository.dart';

class WarehouseRepositoryImpl implements WarehouseRepository {
  WarehouseRepositoryImpl(this._api);

  final WarehousesApi _api;

  @override
  Future<List<WarehouseModel>> getWarehousesByDeliveryMan(
    int deliveryManId,
  ) async {
    return _api.getWarehousesByDeliveryMan(deliveryManId);
  }
}
