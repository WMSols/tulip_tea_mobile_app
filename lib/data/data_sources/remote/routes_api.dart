import 'package:dio/dio.dart';

import 'package:tulip_tea_mobile_app/core/constants/api_constants.dart';
import 'package:tulip_tea_mobile_app/core/network/dio_client.dart';
import 'package:tulip_tea_mobile_app/data/models/route/route_model.dart';

class RoutesApi {
  RoutesApi() : _dio = DioClient.instance;

  final Dio _dio;

  Future<List<RouteModel>> getRoutesByOrderBooker(int orderBookerId) async {
    final res = await _dio.get<List<dynamic>>(
      '${ApiConstants.routesByOrderBooker}/$orderBookerId',
    );
    final list = res.data ?? [];
    return list
        .map((e) => RouteModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<RouteModel>> getRoutesByZone(int zoneId) async {
    final res = await _dio.get<List<dynamic>>(
      '${ApiConstants.routesByZone}/$zoneId',
    );
    final list = res.data ?? [];
    return list
        .map((e) => RouteModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
