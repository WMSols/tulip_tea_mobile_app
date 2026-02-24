import 'package:dio/dio.dart';

import 'package:tulip_tea_mobile_app/core/constants/api_constants.dart';
import 'package:tulip_tea_mobile_app/core/network/dio_client.dart';
import 'package:tulip_tea_mobile_app/data/models/visit_task/visit_task_model.dart';

class VisitTasksApi {
  VisitTasksApi() : _dio = DioClient.instance;

  final Dio _dio;

  /// GET /visit-tasks/order-booker/{order_booker_id}/today
  /// Returns today's visit tasks (shops scheduled for today).
  /// Handles both raw array response [item, ...] and wrapped formats:
  /// {"data": [...]}, {"results": [...]}, {"visit_tasks": [...]}
  Future<List<VisitTaskModel>> getTasksForToday(int orderBookerId) async {
    final res = await _dio.get<dynamic>(
      ApiConstants.visitTasksToday(orderBookerId),
    );
    final raw = res.data;
    final list = _extractList(raw);
    return list
        .map((e) => VisitTaskModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// Extracts list from raw response. Handles wrapped API response formats.
  static List<dynamic> _extractList(dynamic raw) {
    if (raw == null) return [];
    if (raw is List<dynamic>) return raw;
    if (raw is Map<String, dynamic>) {
      for (final key in ['visit_tasks', 'data', 'results']) {
        final value = raw[key];
        if (value is List<dynamic>) return value;
      }
    }
    return [];
  }
}
