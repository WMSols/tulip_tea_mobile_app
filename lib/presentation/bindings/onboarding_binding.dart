import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/di/injection.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/auth_use_case.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/onboarding/onboarding_controller.dart';

class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<AuthUseCase>()) {
      setupDependencyInjection();
    }
    Get.lazyPut<OnboardingController>(
      () => OnboardingController(Get.find<AuthUseCase>()),
    );
  }
}
