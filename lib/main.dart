import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tulip_tea_order_booker/app.dart';
import 'package:tulip_tea_order_booker/core/config/env_config.dart';
import 'package:tulip_tea_order_booker/domain/use_cases/auth_use_case.dart';
import 'package:tulip_tea_order_booker/di/injection.dart';
import 'package:tulip_tea_order_booker/presentation/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EnvConfig.load();
  setupDependencyInjection();

  final auth = Get.find<AuthUseCase>();
  final onboardingDone = await auth.isOnboardingCompleted();
  final loggedIn = await auth.isLoggedIn();

  String initial;
  if (!onboardingDone) {
    initial = AppRoutes.onboarding;
  } else if (!loggedIn) {
    initial = AppRoutes.login;
  } else {
    initial = AppRoutes.main;
  }

  runApp(MyApp(initialRoute: initial));
}
