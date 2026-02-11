import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:tulip_tea_order_booker/core/config/env_config.dart';
import 'package:tulip_tea_order_booker/domain/use_cases/auth_use_case.dart';
import 'package:tulip_tea_order_booker/di/injection.dart';
import 'package:tulip_tea_order_booker/presentation/routes/app_routes.dart';

/// Handles async app bootstrap: env, DI, and initial route resolution.
abstract class AppInitializer {
  /// Ensures Flutter binding, loads env, sets up DI, and returns the initial route.
  static Future<String> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EnvConfig.load();
    setupDependencyInjection();

    final auth = Get.find<AuthUseCase>();
    final onboardingDone = await auth.isOnboardingCompleted();
    final loggedIn = await auth.isLoggedIn();

    if (!onboardingDone) return AppRoutes.onboarding;
    if (!loggedIn) return AppRoutes.login;
    // Hydrate in-memory token so API interceptors can attach it to requests
    await auth.getCurrentUser();
    return AppRoutes.main;
  }
}
