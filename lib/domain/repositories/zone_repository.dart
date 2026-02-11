import 'package:tulip_tea_mobile_app/domain/entities/zone.dart';

abstract class ZoneRepository {
  Future<List<Zone>> getZones();
}
