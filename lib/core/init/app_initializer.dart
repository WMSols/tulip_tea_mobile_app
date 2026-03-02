import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/core/config/env_config.dart';
import 'package:tulip_tea_mobile_app/core/constants/app_constants.dart';
import 'package:tulip_tea_mobile_app/data/data_sources/local/secure_storage_source.dart';
import 'package:tulip_tea_mobile_app/di/injection.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/auth_use_case.dart';
import 'package:tulip_tea_mobile_app/presentation/routes/app_routes.dart';

/// Handles async app bootstrap: env, DI, and initial route resolution.
abstract class AppInitializer {
  /// Ensures Flutter binding, loads env, sets up DI, and returns the initial route.
  static Future<String> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EnvConfig.load();
    setupDependencyInjection();

    // Check if user is already logged in
    final authUseCase = Get.find<AuthUseCase>();
    final storage = Get.find<SecureStorageSource>();
    
    final isLoggedIn = await authUseCase.isLoggedIn();
    
    if (isLoggedIn) {
      // User is already logged in, check their role and onboarding status
      final userRole = await storage.getUserRole();
      
      if (userRole == AppConstants.roleDeliveryMan) {
        // Check if DM onboarding is completed
        final dmOnboardingCompleted = await storage.isDeliveryManOnboardingCompleted();
        if (!dmOnboardingCompleted) {
          return AppRoutes.onboarding;
        }
        return AppRoutes.dmMain;
      } else if (userRole == AppConstants.roleOrderBooker) {
        // Check if OB onboarding is completed
        final obOnboardingCompleted = await storage.isOnboardingCompleted();
        if (!obOnboardingCompleted) {
          return AppRoutes.onboarding;
        }
        return AppRoutes.obMain;
      }
    }
    
    // User is not logged in or role is unknown, show role selection
    return AppRoutes.selectRole;
  }
}
