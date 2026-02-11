import 'package:tulip_tea_mobile_app/domain/entities/zone.dart';
import 'package:tulip_tea_mobile_app/domain/repositories/zone_repository.dart';
import 'package:tulip_tea_mobile_app/data/data_sources/remote/zones_api.dart';

class ZoneRepositoryImpl implements ZoneRepository {
  ZoneRepositoryImpl(this._api);

  final ZonesApi _api;

  @override
  Future<List<Zone>> getZones() async {
    final list = await _api.getZones();
    return list.map((e) => e.toEntity()).toList();
  }
}
