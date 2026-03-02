import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/data/data_sources/local/secure_storage_source.dart';
import 'package:tulip_tea_mobile_app/di/injection.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/auth_use_case.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/common/onboarding/onboarding_controller.dart';

class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<AuthUseCase>()) {
      setupDependencyInjection();
    }
    if (!Get.isRegistered<SecureStorageSource>()) {
      Get.lazyPut<SecureStorageSource>(() => SecureStorageSource());
    }
    Get.lazyPut<OnboardingController>(
      () => OnboardingController(
        Get.find<AuthUseCase>(),
        Get.find<SecureStorageSource>(),
      ),
    );
  }
}
