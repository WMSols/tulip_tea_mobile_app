import 'package:dio/dio.dart';

import 'package:tulip_tea_mobile_app/core/constants/api_constants.dart';
import 'package:tulip_tea_mobile_app/core/network/dio_client.dart';
import 'package:tulip_tea_mobile_app/data/models/route/route_model.dart';
import 'package:tulip_tea_mobile_app/data/models/weekly_route_schedule/weekly_route_schedule_model.dart';

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

  /// GET /weekly-route-schedules/order-booker/{order_booker_id}
  /// Returns weekly route schedules (route + day_of_week) for the order booker.
  /// Handles both raw array [item, ...] and wrapped formats: {"data": [...]}, etc.
  Future<List<WeeklyRouteScheduleModel>> getWeeklySchedulesByOrderBooker(
    int orderBookerId,
  ) async {
    final res = await _dio.get<dynamic>(
      ApiConstants.weeklyRouteSchedulesByOrderBooker(orderBookerId),
    );
    final list = _extractList(res.data);
    return list
        .map(
          (e) => WeeklyRouteScheduleModel.fromJson(e as Map<String, dynamic>),
        )
        .toList();
  }

  static List<dynamic> _extractList(dynamic raw) {
    if (raw == null) return [];
    if (raw is List<dynamic>) return raw;
    if (raw is Map<String, dynamic>) {
      for (final key in [
        'weekly_route_schedules',
        'schedules',
        'data',
        'results',
      ]) {
        final value = raw[key];
        if (value is List<dynamic>) return value;
      }
    }
    return [];
  }
}
