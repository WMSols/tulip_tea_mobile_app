import 'package:get/get.dart';

import 'package:tulip_tea_order_booker/core/widgets/feedback/app_toast.dart';
import 'package:tulip_tea_order_booker/domain/use_cases/auth_use_case.dart';
import 'package:tulip_tea_order_booker/presentation/routes/app_routes.dart';

class LoginController extends GetxController {
  LoginController(this._authUseCase);

  final AuthUseCase _authUseCase;

  final phone = ''.obs;
  final password = ''.obs;
  final isLoading = false.obs;
  final obscurePassword = true.obs;

  void setPhone(String value) => phone.value = value;
  void setPassword(String value) => password.value = value;
  void toggleObscurePassword() => obscurePassword.toggle();

  Future<void> login() async {
    if (phone.value.trim().isEmpty || password.value.isEmpty) {
      AppToast.showError('Error', 'Please enter phone and password');
      return;
    }
    isLoading.value = true;
    try {
      await _authUseCase.login(phone.value.trim(), password.value);
      Get.offAllNamed(AppRoutes.main);
    } catch (e) {
      AppToast.showError('Error', e.toString().replaceFirst('Exception: ', ''));
    } finally {
      isLoading.value = false;
    }
  }
}
