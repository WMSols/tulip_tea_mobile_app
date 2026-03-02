import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_mobile_app/core/constants/app_constants.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_images/app_images.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/buttons/app_button.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_bubble_background.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_footer.dart';
import 'package:tulip_tea_mobile_app/data/data_sources/local/secure_storage_source.dart';
import 'package:tulip_tea_mobile_app/presentation/routes/app_routes.dart';

class SelectRoleScreen extends StatelessWidget {
  const SelectRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = Get.find<SecureStorageSource>();

    return Scaffold(
      body: AppBubbleBackground(
        child: SafeArea(
          child: Padding(
            padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppSpacing.vertical(context, 0.08),
                // Title
                Text(
                  AppTexts.appName,
                  style: AppTextStyles.headline(context).copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                AppSpacing.vertical(context, 0.02),
                // Illustration
                Expanded(
                  flex: 2,
                  child: Image.asset(AppImages.selectRole, fit: BoxFit.contain),
                ),
                AppSpacing.vertical(context, 0.02),
                // Continue as Order Booker Button
                AppButton(
                  label:
                      "${AppTexts.continueAs} ${AppTexts.orderBookerRoleName}",
                  onPressed: () async {
                    await storage.saveUserRole(AppConstants.roleOrderBooker);
                    Get.toNamed(AppRoutes.login);
                  },
                  icon: Iconsax.shopping_cart,
                ),
                AppSpacing.vertical(context, 0.02),
                // Continue as Delivery Man Button
                AppButton(
                  label:
                      "${AppTexts.continueAs} ${AppTexts.deliveryManRoleName}",
                  onPressed: () async {
                    await storage.saveUserRole(AppConstants.roleDeliveryMan);
                    Get.toNamed(AppRoutes.login);
                  },
                  icon: Iconsax.truck,
                ),
                AppSpacing.vertical(context, 0.04),
                const AppFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
