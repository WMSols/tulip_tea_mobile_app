import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/domain/use_cases/auth_use_case.dart';
import 'package:tulip_tea_mobile_app/presentation/routes/app_routes.dart';

class OnboardingController extends GetxController {
  OnboardingController(this._authUseCase);

  final AuthUseCase _authUseCase;

  final pageController = PageController(initialPage: 0);
  final currentPage = 0.obs;

  Future<void> nextPage() async {
    if (currentPage.value < 2) {
      await pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      // onPageChanged updates currentPage when animation completes
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
