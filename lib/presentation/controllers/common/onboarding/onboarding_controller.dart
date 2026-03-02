import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/core/constants/app_constants.dart';
import 'package:tulip_tea_mobile_app/data/data_sources/local/secure_storage_source.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/auth_use_case.dart';
import 'package:tulip_tea_mobile_app/presentation/routes/app_routes.dart';

class OnboardingController extends GetxController {
  OnboardingController(this._authUseCase, this._storage);

  final AuthUseCase _authUseCase;
  final SecureStorageSource _storage;

  final pageController = PageController(initialPage: 0);
  final currentPage = 0.obs;

  // Role parameter - can be set when navigating to onboarding
  String _role = AppConstants.roleOrderBooker;

  void setRole(String role) {
    _role = role;
  }

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
    // Save onboarding completion based on role
    if (_role == AppConstants.roleDeliveryMan) {
      await _storage.saveDeliveryManOnboardingCompleted(true);
      Get.offAllNamed(AppRoutes.dmMain);
    } else {
      await _authUseCase.saveOnboardingCompleted(true);
      Get.offAllNamed(AppRoutes.obMain);
    }
  }
}
