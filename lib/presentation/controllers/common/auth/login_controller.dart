import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/core/constants/app_constants.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/feedback/app_toast.dart';
import 'package:tulip_tea_mobile_app/core/network/connectivity_service.dart';
import 'package:tulip_tea_mobile_app/data/data_sources/local/secure_storage_source.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/auth_use_case.dart';
import 'package:tulip_tea_mobile_app/presentation/routes/app_routes.dart';

class LoginController extends GetxController {
  LoginController(this._connectivity, this._authUseCase, this._storage);

  final ConnectivityService _connectivity;
  final AuthUseCase _authUseCase;
  final SecureStorageSource _storage;

  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final isLoading = false.obs;
  final obscurePassword = true.obs;
  final rememberMe = false.obs;
  String _selectedRole = AppConstants.roleOrderBooker;

  void setRole(String role) {
    _selectedRole = role;
  }

  String getUserRole() {
    return _selectedRole;
  }

  void toggleObscurePassword() => obscurePassword.toggle();
  void setRememberMe(bool value) => rememberMe.value = value;

  @override
  void onReady() {
    loadRememberedCredentials();
    super.onReady();
  }

  @override
  void onClose() {
    // Dispose controllers immediately when controller is deleted
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> loadRememberedCredentials() async {
    final shouldRemember = await _authUseCase.getRememberMe(_selectedRole);
    rememberMe.value = shouldRemember;
    if (shouldRemember) {
      final credentials = await _authUseCase.getRememberedCredentials(
        _selectedRole,
      );
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
    // Check connectivity first
    final hasConnection = await _connectivity.guardConnection();
    if (!hasConnection) {
      AppToast.showError(
        AppTexts.error,
        'No internet connection. Please check your network and try again.',
      );
      return;
    }

    final phone = phoneController.text.trim();
    final password = passwordController.text;

    // Validate inputs
    if (phone.isEmpty) {
      AppToast.showError(AppTexts.error, 'Please enter your phone number');
      return;
    }
    if (password.isEmpty) {
      AppToast.showError(AppTexts.error, 'Please enter your password');
      return;
    }

    isLoading.value = true;
    try {
      await _authUseCase.login(phone, password, _selectedRole);

      // Save user role
      await _storage.saveUserRole(_selectedRole);

      if (rememberMe.value) {
        await _authUseCase.saveRememberMe(true, _selectedRole);
        await _authUseCase.saveRememberedCredentials(
          phone,
          password,
          _selectedRole,
        );
      } else {
        await _authUseCase.saveRememberMe(false, _selectedRole);
        await _authUseCase.clearRememberedCredentials(_selectedRole);
      }

      // Navigate based on role
      if (_selectedRole == AppConstants.roleDeliveryMan) {
        // Check if DM onboarding is completed
        final dmOnboardingCompleted = await _storage
            .isDeliveryManOnboardingCompleted();
        if (!dmOnboardingCompleted) {
          // Use the same onboarding screen with role parameter
          Get.offAllNamed(
            AppRoutes.onboarding,
            arguments: {'role': AppConstants.roleDeliveryMan},
          );
        } else {
          Get.offAllNamed(AppRoutes.dmMain);
        }
      } else {
        // Check if OB onboarding is completed
        final obOnboardingCompleted = await _storage.isOnboardingCompleted();
        if (!obOnboardingCompleted) {
          Get.offAllNamed(AppRoutes.onboarding);
        } else {
          Get.offAllNamed(AppRoutes.obMain);
        }
      }
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
