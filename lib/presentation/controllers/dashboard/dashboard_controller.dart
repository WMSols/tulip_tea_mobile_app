import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/domain/entities/route_entity.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/auth_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/route_use_case.dart';

class DashboardController extends GetxController {
  DashboardController(this._authUseCase, this._routeUseCase);

  final AuthUseCase _authUseCase;
  final RouteUseCase _routeUseCase;

  final routes = <RouteEntity>[].obs;
  final isLoading = true.obs;

  @override
  void onReady() {
    loadRoutes();
    super.onReady();
  }

  Future<void> loadRoutes() async {
    final user = await _authUseCase.getCurrentUser();
    if (user == null) return;
    isLoading.value = true;
    try {
      final list = await _routeUseCase.getRoutesByOrderBooker(
        user.orderBookerId,
      );
      routes.assignAll(list);
    } catch (_) {
      routes.clear();
    } finally {
      isLoading.value = false;
    }
  }
}
