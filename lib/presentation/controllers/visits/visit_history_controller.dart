import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/domain/entities/shop_visit.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/auth_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/shop_visit_use_case.dart';

class VisitHistoryController extends GetxController {
  VisitHistoryController(this._authUseCase, this._shopVisitUseCase);

  final AuthUseCase _authUseCase;
  final ShopVisitUseCase _shopVisitUseCase;

  final visits = <ShopVisit>[].obs;
  final isLoading = false.obs;

  @override
  void onReady() {
    loadVisits();
    super.onReady();
  }

  Future<void> loadVisits() async {
    final user = await _authUseCase.getCurrentUser();
    if (user == null) return;
    isLoading.value = true;
    try {
      final list = await _shopVisitUseCase.getVisitsByOrderBooker(
        user.orderBookerId,
      );
      visits.assignAll(list);
    } catch (_) {
      visits.clear();
    } finally {
      isLoading.value = false;
    }
  }
}
