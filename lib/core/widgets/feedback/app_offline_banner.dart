import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_order_booker/core/network/connectivity_service.dart';
import 'package:tulip_tea_order_booker/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_order_booker/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_order_booker/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_order_booker/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_order_booker/core/utils/app_texts/app_texts.dart';

/// Wraps [child] and shows a top banner when the device is offline.
class AppOfflineBanner extends StatelessWidget {
  const AppOfflineBanner({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final connectivity = Get.find<ConnectivityService>();
    return Stack(
      children: [
        child,
        Obx(() {
          if (connectivity.isOnline.value) return const SizedBox.shrink();
          return Material(
            elevation: 2,
            shadowColor: Colors.transparent,
            child: Container(
              width: double.infinity,
              padding: AppSpacing.symmetric(context, h: 0.04, v: 0.01),
              color: AppColors.primary,
              child: SafeArea(
                bottom: false,
                child: Row(
                  children: [
                    Icon(
                      Iconsax.wifi,
                      color: AppColors.white,
                      size: AppResponsive.scaleSize(context, 22),
                    ),
                    AppSpacing.horizontal(context, 0.02),
                    Expanded(
                      child: Text(
                        AppTexts.youAreOffline,
                        style: AppTextStyles.labelText(context).copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
