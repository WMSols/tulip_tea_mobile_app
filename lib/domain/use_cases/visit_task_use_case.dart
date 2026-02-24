import 'package:tulip_tea_mobile_app/domain/entities/visit_task.dart';
import 'package:tulip_tea_mobile_app/domain/repositories/visit_task_repository.dart';

class VisitTaskUseCase {
  VisitTaskUseCase(this._repo);
  final VisitTaskRepository _repo;

  Future<List<VisitTask>> getTasksForToday(int orderBookerId) =>
      _repo.getTasksForToday(orderBookerId);
}
