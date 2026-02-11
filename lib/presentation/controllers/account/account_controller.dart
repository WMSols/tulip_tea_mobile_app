import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/domain/entities/auth_user.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/auth_use_case.dart';
import 'package:tulip_tea_mobile_app/presentation/routes/app_routes.dart';

class AccountController extends GetxController {
  AccountController(this._authUseCase);

  final AuthUseCase _authUseCase;

  final user = Rxn<AuthUser>();
  final isLoggingOut = false.obs;

  @override
  void onReady() {
    loadUser();
    super.onReady();
  }

  Future<void> loadUser() async {
    user.value = await _authUseCase.getCurrentUser();
  }

  Future<void> logout() async {
    isLoggingOut.value = true;
    try {
      await _authUseCase.logout();
      Get.offAllNamed(AppRoutes.login);
    } finally {
      isLoggingOut.value = false;
    }
  }
}
