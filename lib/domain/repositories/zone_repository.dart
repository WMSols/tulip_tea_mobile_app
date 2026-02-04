import 'package:tulip_tea_order_booker/domain/entities/zone.dart';

abstract class ZoneRepository {
  Future<List<Zone>> getZones();
}
