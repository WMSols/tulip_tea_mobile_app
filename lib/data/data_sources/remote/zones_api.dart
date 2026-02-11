import 'package:dio/dio.dart';

import 'package:tulip_tea_mobile_app/core/constants/api_constants.dart';
import 'package:tulip_tea_mobile_app/core/network/dio_client.dart';
import 'package:tulip_tea_mobile_app/data/models/zone/zone_model.dart';

class ZonesApi {
  ZonesApi() : _dio = DioClient.instance;

  final Dio _dio;

  Future<List<ZoneModel>> getZones() async {
    final res = await _dio.get<List<dynamic>>(ApiConstants.zones);
    final list = res.data ?? [];
    return list
        .map((e) => ZoneModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
