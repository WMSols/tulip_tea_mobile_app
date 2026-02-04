import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_order_booker/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_order_booker/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_order_booker/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_order_booker/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_order_booker/core/utils/app_validators/app_validators.dart';
import 'package:tulip_tea_order_booker/core/widgets/buttons/app_button.dart';
import 'package:tulip_tea_order_booker/core/widgets/form/app_text_field.dart';
import 'package:tulip_tea_order_booker/presentation/controllers/auth/login_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<LoginController>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.symmetric(context, h: 0.06, v: 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppSpacing.vertical(context, 0.08),
              Hero(
                tag: 'login_app_name',
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    AppTexts.appName,
                    style: AppTextStyles.headline(
                      context,
                    ).copyWith(color: AppColors.primary),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              AppSpacing.vertical(context, 0.02),
              Hero(
                tag: 'login_title',
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    AppTexts.login,
                    style: AppTextStyles.heading(context),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              AppSpacing.vertical(context, 0.05),
              AppTextField(
                label: AppTexts.phoneNumber,
                hint: AppTexts.enterPhone,
                prefixIcon: Iconsax.call,
                keyboardType: TextInputType.phone,
                onChanged: c.setPhone,
                validator: AppValidators.validatePhone,
              ),
              AppSpacing.vertical(context, 0.02),
              Obx(
                () => AppTextField(
                  label: AppTexts.password,
                  hint: AppTexts.enterPassword,
                  prefixIcon: Iconsax.lock_1,
                  obscureText: c.obscurePassword.value,
                  onChanged: c.setPassword,
                  validator: AppValidators.validatePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      c.obscurePassword.value ? Iconsax.eye : Iconsax.eye_slash,
                      color: AppColors.grey,
                    ),
                    onPressed: c.toggleObscurePassword,
                  ),
                ),
              ),
              AppSpacing.vertical(context, 0.04),
              Hero(
                tag: 'login_button',
                child: Obx(
                  () => AppButton(
                    label: AppTexts.login,
                    onPressed: c.login,
                    isLoading: c.isLoading.value,
                    icon: Iconsax.login_1,
                    iconPosition: IconPosition.right,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
