import 'package:tulip_tea_mobile_app/domain/entities/zone.dart';
import 'package:tulip_tea_mobile_app/domain/repositories/zone_repository.dart';

class ZoneUseCase {
  ZoneUseCase(this._repo);
  final ZoneRepository _repo;

  Future<List<Zone>> getZones() => _repo.getZones();
}
