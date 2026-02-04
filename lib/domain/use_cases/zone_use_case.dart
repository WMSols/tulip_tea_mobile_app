import 'package:tulip_tea_order_booker/domain/entities/zone.dart';
import 'package:tulip_tea_order_booker/domain/repositories/zone_repository.dart';

class ZoneUseCase {
  ZoneUseCase(this._repo);
  final ZoneRepository _repo;

  Future<List<Zone>> getZones() => _repo.getZones();
}
