import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tulip_tea_order_booker/domain/use_cases/auth_use_case.dart';
import 'package:tulip_tea_order_booker/presentation/routes/app_routes.dart';

class OnboardingController extends GetxController {
  OnboardingController(this._authUseCase);

  final AuthUseCase _authUseCase;

  final pageController = PageController(initialPage: 0);
  final currentPage = 0.obs;

  void nextPage() {
    if (currentPage.value < 2) {
      currentPage.value++;
    } else {
      _complete();
    }
  }

  void skip() => _complete();

  Future<void> _complete() async {
    await _authUseCase.saveOnboardingCompleted(true);
    Get.offAllNamed(AppRoutes.login);
  }
}
