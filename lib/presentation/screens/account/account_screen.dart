import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

import 'package:tulip_tea_order_booker/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_order_booker/core/utils/app_lotties/app_lotties.dart';
import 'package:tulip_tea_order_booker/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_order_booker/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_order_booker/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_order_booker/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_order_booker/core/widgets/buttons/app_button.dart';
import 'package:tulip_tea_order_booker/presentation/controllers/account/account_controller.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(AccountController(Get.find()));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppTexts.account,
          style: AppTextStyles.heading(
            context,
          ).copyWith(color: AppColors.white),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      body: Obx(() {
        final u = c.user.value;
        return SingleChildScrollView(
          padding: AppSpacing.symmetric(context, h: 0.05, v: 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (u != null) ...[
                _ProfileRow(
                  icon: Iconsax.call,
                  label: AppTexts.phoneNumber,
                  value: u.phone,
                ),
              ] else
                Center(
                  child: SizedBox(
                    width: AppResponsive.buttonLoaderSize(context, factor: 2),
                    height: AppResponsive.buttonLoaderSize(context, factor: 2),
                    child: Lottie.asset(AppLotties.loadingPrimary),
                  ),
                ),
              AppSpacing.vertical(context, 0.04),
              Text(
                AppTexts.appVersion,
                style: AppTextStyles.labelText(
                  context,
                ).copyWith(color: AppColors.grey),
                textAlign: TextAlign.center,
              ),
              AppSpacing.vertical(context, 0.02),
              AppButton(
                label: AppTexts.logout,
                onPressed: c.logout,
                primary: false,
                icon: Iconsax.logout,
                isLoading: c.isLoggingOut.value,
                loadingLabel: AppTexts.loggingOut,
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _ProfileRow extends StatelessWidget {
  const _ProfileRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: AppResponsive.iconSize(context),
          color: AppColors.primary,
        ),
        AppSpacing.horizontal(context, 0.04),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTextStyles.hintText(context)),
              Text(value, style: AppTextStyles.bodyText(context)),
            ],
          ),
        ),
      ],
    );
  }
}
