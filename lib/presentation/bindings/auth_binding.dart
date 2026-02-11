import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/core/network/connectivity_service.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/auth_use_case.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/auth/login_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(
        Get.find<ConnectivityService>(),
        Get.find<AuthUseCase>(),
      ),
    );
  }
}
