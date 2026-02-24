import 'package:tulip_tea_mobile_app/domain/entities/visit_task.dart';

abstract class VisitTaskRepository {
  Future<List<VisitTask>> getTasksForToday(int orderBookerId);
}
