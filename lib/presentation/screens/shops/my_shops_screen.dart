import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_images/app_images.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/feedback/app_empty_widget.dart';
import 'package:tulip_tea_mobile_app/core/widgets/feedback/app_shimmer.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/shops/my_shops_controller.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/shops/my_shops/my_shops_card.dart';

class MyShopsScreen extends StatelessWidget {
  const MyShopsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<MyShopsController>();
    return RefreshIndicator(
      backgroundColor: AppColors.primary,
      color: AppColors.white,
      onRefresh: () => c.loadShops(),
      child: Obx(() {
        if (c.isLoading.value && c.shops.isEmpty) {
          return Padding(
            padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
            child: const AppShimmerList(),
          );
        }
        if (c.shops.isEmpty) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              height: AppResponsive.screenHeight(context) * 0.7,
              child: Center(
                child: AppEmptyWidget(
                  message: AppTexts.noShopsYet,
                  imagePath: AppImages.noShopsYet,
                ),
              ),
            ),
          );
        }
        return ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
          itemCount: c.shops.length,
          separatorBuilder: (_, __) => AppSpacing.vertical(context, 0.01),
          itemBuilder: (_, i) {
            final shop = c.shops[i];
            return MyShopsCard(shop: shop);
          },
        );
      }),
    );
  }
}
