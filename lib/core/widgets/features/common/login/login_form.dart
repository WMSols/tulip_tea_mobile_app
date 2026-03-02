import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/buttons/app_button.dart';
import 'package:tulip_tea_mobile_app/core/widgets/form/app_remember_me/app_remember_me.dart';
import 'package:tulip_tea_mobile_app/core/widgets/form/app_text_field/app_text_field.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/common/auth/login_controller.dart';
import 'package:tulip_tea_mobile_app/presentation/routes/app_routes.dart';

/// Reusable login form: heading, phone field, password field, and submit button.
class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.controller,
    required this.formKey,
    this.role,
  });

  final LoginController controller;
  final GlobalKey<FormState> formKey;
  final String? role;

  @override
  Widget build(BuildContext context) {
    // Set role on controller when role parameter changes
    if (role != null) {
      controller.setRole(role!);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          AppTexts.login,
          style: AppTextStyles.heading(context),
          textAlign: TextAlign.center,
        ),
        AppTextField(
          controller: controller.phoneController,
          label: AppTexts.phoneNumber,
          hint: AppTexts.enterPhone,
          required: true,
          prefixIcon: Iconsax.call,
          keyboardType: TextInputType.phone,
          // validator: (value) {
          //   if (value == null || value.isEmpty) {
          //     return 'Please enter your phone number';
          //   }
          //   if (value.length < 11) {
          //     return 'Please enter a valid phone number';
          //   }
          //   return null;
          // },
        ),
        AppSpacing.vertical(context, 0.02),
        Obx(
          () => AppTextField(
            controller: controller.passwordController,
            label: AppTexts.password,
            hint: AppTexts.enterPassword,
            required: true,
            prefixIcon: Iconsax.lock_1,
            obscureText: controller.obscurePassword.value,
            suffixIcon: IconButton(
              icon: Icon(
                controller.obscurePassword.value
                    ? Iconsax.eye
                    : Iconsax.eye_slash,
                color: AppColors.black,
              ),
              onPressed: controller.toggleObscurePassword,
            ),
            // validator: (value) {
            //   if (value == null || value.isEmpty) {
            //     return 'Please enter your password';
            //   }
            //   return null;
            // },
          ),
        ),
        AppSpacing.vertical(context, 0.02),
        Obx(
          () => AppRememberMe(
            value: controller.rememberMe.value,
            onChanged: controller.setRememberMe,
            label: AppTexts.rememberMe,
          ),
        ),
        AppSpacing.vertical(context, 0.04),
        Obx(
          () => AppButton(
            label: AppTexts.login,
            onPressed: () {
              if (formKey.currentState?.validate() ?? false) {
                controller.login();
              }
            },
            isLoading: controller.isLoading.value,
            loadingLabel: AppTexts.loggingIn,
            icon: Iconsax.login_1,
            iconPosition: IconPosition.right,
          ),
        ),
        AppSpacing.vertical(context, 0.02),
        // Change Role Button - navigate to Select Role screen for complete isolation
        AppButton(
          label: AppTexts.changeRole,
          onPressed: () {
            // Navigate to Select Role screen for complete isolation
            // This ensures each login screen has its own fresh controller
            Get.offAllNamed(AppRoutes.selectRole);
          },
          primary: false,
          icon: Iconsax.arrow_2,
        ),
      ],
    );
  }
}
