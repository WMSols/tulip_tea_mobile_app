import 'package:get/get.dart';

import 'package:tulip_tea_order_booker/domain/entities/credit_limit_request.dart';
import 'package:tulip_tea_order_booker/domain/use_cases/auth_use_case.dart';
import 'package:tulip_tea_order_booker/domain/use_cases/credit_limit_request_use_case.dart';

class MyRequestsController extends GetxController {
  MyRequestsController(this._authUseCase, this._creditLimitRequestUseCase);

  final AuthUseCase _authUseCase;
  final CreditLimitRequestUseCase _creditLimitRequestUseCase;

  final requests = <CreditLimitRequest>[].obs;
  final isLoading = false.obs;

  @override
  void onReady() {
    loadRequests();
    super.onReady();
  }

  Future<void> loadRequests() async {
    final user = await _authUseCase.getCurrentUser();
    if (user == null) return;
    isLoading.value = true;
    try {
      final all = await _creditLimitRequestUseCase.getAllRequests();
      requests.assignAll(
        all.where((r) => r.requestedById == user.orderBookerId),
      );
    } catch (_) {
      requests.clear();
    } finally {
      isLoading.value = false;
    }
  }
}
