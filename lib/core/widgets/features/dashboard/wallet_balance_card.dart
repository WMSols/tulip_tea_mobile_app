import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_formatter/app_formatter.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_lotties/app_lotties.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_images/app_images.dart';
import 'package:tulip_tea_mobile_app/core/widgets/buttons/app_icon_button.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/dashboard/dashboard_section_card.dart';
import 'package:tulip_tea_mobile_app/domain/entities/wallet_balance.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/dashboard/dashboard_controller.dart';

/// Reusable wallet balance card: current balance with optional refresh.
/// Shows PKR amount; positive in success color, zero/negative in error color.
class WalletBalanceCard extends StatelessWidget {
  const WalletBalanceCard({
    super.key,
    this.balance,
    this.isLoading = false,
    this.onRefresh,
  });

  final WalletBalance? balance;
  final bool isLoading;
  final VoidCallback? onRefresh;

  @override
  Widget build(BuildContext context) {
    final amount = balance?.currentBalance ?? 0.0;
    final amountColor = amount >= 0 ? AppColors.success : AppColors.error;
    return DashboardSectionCard(
      icon: Iconsax.wallet_3,
      title: AppTexts.walletBalanceTitle,
      illustrationPath: AppImages.wallet,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                AppTexts.currentBalance,
                style: AppTextStyles.hintText(context),
              ),
              if (onRefresh != null)
                isLoading
                    ? SizedBox(
                        width: AppResponsive.scaleSize(context, 25),
                        height: AppResponsive.scaleSize(context, 25),
                        child: Lottie.asset(AppLotties.loadingPrimary),
                      )
                    : AppIconButton(
                        icon: Iconsax.refresh_left_square,
                        paddingFactor: 0.4,
                        color: AppColors.primary,
                        onPressed: isLoading ? null : onRefresh,
                      ),
            ],
          ),
          AppSpacing.vertical(context, 0.005),
          if (isLoading && balance == null)
            SizedBox(
              height: AppResponsive.shimmerTextLineHeight(context) * 2,
              child: Center(
                child: SizedBox(
                  width: AppResponsive.scaleSize(context, 18),
                  height: AppResponsive.scaleSize(context, 18),
                  child: Lottie.asset(AppLotties.loadingPrimary),
                ),
              ),
            )
          else
            Text(
              AppFormatter.formatCurrency(amount),
              style: AppTextStyles.headline(context).copyWith(
                color: amountColor,
                fontWeight: FontWeight.w800,
                height: 0.8,
              ),
            ),
        ],
      ),
    );
  }
}

/// Convenience widget that reads from [DashboardController].
class DashboardWalletBalanceCard extends StatelessWidget {
  const DashboardWalletBalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<DashboardController>();
    return Obx(
      () => WalletBalanceCard(
        balance: c.walletBalance.value,
        isLoading: c.isLoadingWallet.value,
        onRefresh: c.refreshBalance,
      ),
    );
  }
}
