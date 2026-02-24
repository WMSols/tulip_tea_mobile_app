import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_lotties/app_lotties.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_message_banner.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_section_card.dart';
import 'package:tulip_tea_mobile_app/core/widgets/form/app_text_field/app_text_field.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/visits/visit_register/impact_preview.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/visits/visit_register_controller.dart';

/// Daily collections section: amount, remarks, impact preview.
class CollectionSection extends StatelessWidget {
  const CollectionSection({super.key, required this.controller});

  final VisitRegisterController controller;

  @override
  Widget build(BuildContext context) {
    final c = controller;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppSectionCard(
          icon: Iconsax.wallet_money,
          title: AppTexts.collectionDetails,
          titleColor: AppColors.success,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppMessageBanner(
                message: AppTexts.instantCreditLimitIncrease,
                type: AppMessageBannerType.success,
                icon: Iconsax.flash_1,
                showBorder: false,
              ),
              AppSpacing.vertical(context, 0.02),
              AppTextField(
                label: '${AppTexts.collectionAmount} (PKR)',
                hint: AppTexts.collectionAmount,
                required: true,
                prefixIcon: Iconsax.wallet_money,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                onChanged: c.setCollectionAmount,
              ),
              AppSpacing.vertical(context, 0.02),
              AppTextField(
                label: AppTexts.collectionRemarks,
                hint: AppTexts.notesAboutCollection,
                prefixIcon: Iconsax.note,
                maxLines: 2,
                onChanged: c.setCollectionRemarks,
              ),
              AppSpacing.vertical(context, 0.02),
              Obx(() {
                final isLoading = c.isLoadingCreditInfo.value;
                final info = c.shopCreditInfo.value;
                final amountStr = c.collectionAmount.value;
                if (isLoading) {
                  return Container(
                    padding: AppSpacing.symmetric(context, h: 0.02, v: 0.015),
                    decoration: BoxDecoration(
                      color: AppColors.success.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.success.withValues(alpha: 0.5),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: AppResponsive.scaleSize(context, 24),
                          height: AppResponsive.scaleSize(context, 24),
                          child: Lottie.asset(AppLotties.loadingPrimary),
                        ),
                        AppSpacing.horizontal(context, 0.02),
                        Text(
                          AppTexts.impactPreview,
                          style: AppTextStyles.bodyText(context).copyWith(
                            color: AppColors.success,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        AppSpacing.horizontal(context, 0.01),
                        Text(
                          '(${AppTexts.loading})',
                          style: AppTextStyles.hintText(context).copyWith(
                            color: AppColors.success.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return ImpactPreview(
                  info: info,
                  collectionAmountStr: amountStr,
                );
              }),
            ],
          ),
        ),
        AppSpacing.vertical(context, 0.02),
      ],
    );
  }
}
