import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_lotties/app_lotties.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/buttons/app_button.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_detail_row.dart';
import 'package:tulip_tea_mobile_app/domain/entities/auth_user.dart';

/// Scrollable account screen content: user details, app version, and logout button.
/// When [user] is null, shows a loading indicator.
class AccountContent extends StatelessWidget {
  const AccountContent({super.key, required this.user, required this.onLogout});

  final AuthUser? user;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: AppSpacing.symmetric(context, h: 0.05, v: 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (user != null) ...[
            AppDetailRow(
              icon: Iconsax.profile_circle,
              label: AppTexts.fullName,
              value: user!.name,
            ),
            AppSpacing.vertical(context, 0.015),
            AppDetailRow(
              icon: Iconsax.call,
              label: AppTexts.phoneNumber,
              value: user!.phone,
            ),
            if (user!.email != null && user!.email!.isNotEmpty) ...[
              AppSpacing.vertical(context, 0.015),
              AppDetailRow(
                icon: Iconsax.sms,
                label: AppTexts.emailAddress,
                value: user!.email!,
              ),
            ],
          ] else
            Center(
              child: SizedBox(
                width: AppResponsive.buttonLoaderSize(context, factor: 5),
                height: AppResponsive.buttonLoaderSize(context, factor: 5),
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
            onPressed: onLogout,
            primary: false,
            icon: Iconsax.logout,
          ),
        ],
      ),
    );
  }
}
