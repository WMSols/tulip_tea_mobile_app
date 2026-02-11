import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/feedback/app_toast.dart';
import 'package:tulip_tea_mobile_app/core/network/connectivity_service.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/auth_use_case.dart';
import 'package:tulip_tea_mobile_app/presentation/routes/app_routes.dart';

class LoginController extends GetxController {
  LoginController(this._connectivity, this._authUseCase);

  final ConnectivityService _connectivity;
  final AuthUseCase _authUseCase;

  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final isLoading = false.obs;
  final obscurePassword = true.obs;
  final rememberMe = false.obs;

  void toggleObscurePassword() => obscurePassword.toggle();
  void setRememberMe(bool value) => rememberMe.value = value;

  @override
  void onReady() {
    loadRememberedCredentials();
    super.onReady();
  }

  @override
  void onClose() {
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> loadRememberedCredentials() async {
    final shouldRemember = await _authUseCase.getRememberMe();
    rememberMe.value = shouldRemember;
    if (shouldRemember) {
      final credentials = await _authUseCase.getRememberedCredentials();
      if (credentials.phone != null && credentials.phone!.isNotEmpty) {
        phoneController.text = credentials.phone!;
      }
      final savedPassword = credentials.password ?? '';
      if (savedPassword.isNotEmpty) {
        passwordController.text = savedPassword;
      }
    }
  }

  Future<void> login() async {
    if (!await _connectivity.guardConnection()) return;
    final phone = phoneController.text.trim();
    final password = passwordController.text;
    isLoading.value = true;
    try {
      await _authUseCase.login(phone, password);
      if (rememberMe.value) {
        await _authUseCase.saveRememberMe(true);
        await _authUseCase.saveRememberedCredentials(phone, password);
      } else {
        await _authUseCase.saveRememberMe(false);
        await _authUseCase.clearRememberedCredentials();
      }
      Get.offAllNamed(AppRoutes.main);
    } catch (e) {
      AppToast.showError(
        AppTexts.error,
        e.toString().replaceFirst('Exception: ', ''),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
