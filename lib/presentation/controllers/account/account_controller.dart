import 'package:get/get.dart';

import 'package:tulip_tea_order_booker/domain/entities/auth_user.dart';
import 'package:tulip_tea_order_booker/domain/use_cases/auth_use_case.dart';
import 'package:tulip_tea_order_booker/presentation/routes/app_routes.dart';

class AccountController extends GetxController {
  AccountController(this._authUseCase);

  final AuthUseCase _authUseCase;

  final user = Rxn<AuthUser>();

  @override
  void onReady() {
    loadUser();
    super.onReady();
  }

  Future<void> loadUser() async {
    user.value = await _authUseCase.getCurrentUser();
  }

  Future<void> logout() async {
    await _authUseCase.logout();
    Get.offAllNamed(AppRoutes.login);
  }
}
