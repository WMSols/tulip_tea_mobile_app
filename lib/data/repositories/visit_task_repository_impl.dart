import 'package:tulip_tea_mobile_app/core/network/api_exceptions.dart';
import 'package:tulip_tea_mobile_app/domain/entities/visit_task.dart';
import 'package:tulip_tea_mobile_app/domain/repositories/visit_task_repository.dart';
import 'package:tulip_tea_mobile_app/data/data_sources/remote/visit_tasks_api.dart';
import 'package:tulip_tea_mobile_app/data/models/visit_task/visit_task_model.dart';

class VisitTaskRepositoryImpl implements VisitTaskRepository {
  VisitTaskRepositoryImpl(this._api);

  final VisitTasksApi _api;

  @override
  Future<List<VisitTask>> getTasksForToday(int orderBookerId) async {
    try {
      final list = await _api.getTasksForToday(orderBookerId);
      return list.map(_toEntity).toList();
    } catch (e, st) {
      final failure = ApiExceptions.handle<List<VisitTask>>(e, st);
      throw Exception(failure.message);
    }
  }

  VisitTask _toEntity(VisitTaskModel m) => VisitTask(
    id: m.id,
    shopId: m.shopId,
    shopName: m.shopName,
    routeName: m.routeName,
  );
}
