import 'package:tulip_tea_mobile_app/domain/entities/weekly_route_schedule.dart';

/// Response item for GET /weekly-route-schedules/order-booker/{order_booker_id}
/// See: https://tulip-tea.onrender.com/docs#/Order%20Booker%20APIs/list_schedules_by_order_booker_weekly_route_schedules_order_booker__order_booker_id__get
class WeeklyRouteScheduleModel {
  WeeklyRouteScheduleModel({
    required this.id,
    this.assigneeType,
    this.assigneeId,
    this.assigneeName,
    required this.routeId,
    this.routeName,
    required this.dayOfWeek,
    this.isActive = true,
    this.createdByDistributor,
    this.createdAt,
  });

  factory WeeklyRouteScheduleModel.fromJson(Map<String, dynamic> json) {
    return WeeklyRouteScheduleModel(
      id: json['id'] as int,
      assigneeType: json['assignee_type'] as String?,
      assigneeId: json['assignee_id'] as int?,
      assigneeName: json['assignee_name'] as String?,
      routeId: json['route_id'] as int,
      routeName: json['route_name'] as String?,
      dayOfWeek: json['day_of_week'] as int,
      isActive: json['is_active'] as bool? ?? true,
      createdByDistributor: json['created_by_distributor'] as int?,
      createdAt: json['created_at'] as String?,
    );
  }

  final int id;
  final String? assigneeType;
  final int? assigneeId;
  final String? assigneeName;
  final int routeId;
  final String? routeName;
  final int dayOfWeek;
  final bool isActive;
  final int? createdByDistributor;
  final String? createdAt;

  WeeklyRouteSchedule toEntity() => WeeklyRouteSchedule(
    id: id,
    routeId: routeId,
    routeName: routeName,
    dayOfWeek: dayOfWeek,
    isActive: isActive,
  );
}
