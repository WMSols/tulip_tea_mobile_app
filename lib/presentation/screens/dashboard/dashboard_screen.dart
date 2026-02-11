import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_order_booker/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_order_booker/core/utils/app_images/app_images.dart';
import 'package:tulip_tea_order_booker/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_order_booker/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_order_booker/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_order_booker/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_order_booker/core/widgets/common/app_custom_app_bar.dart';

import 'package:tulip_tea_order_booker/core/widgets/feedback/app_empty_widget.dart';
import 'package:tulip_tea_order_booker/core/widgets/feedback/app_shimmer.dart';
import 'package:tulip_tea_order_booker/presentation/controllers/dashboard/dashboard_controller.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(DashboardController(Get.find(), Get.find()));
    return Scaffold(
      appBar: const AppCustomAppBar(title: AppTexts.dashboard),
      body: Obx(() {
        if (c.isLoading.value) {
          return Padding(
            padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
            child: const AppShimmerList(itemCount: 10),
          );
        }
        if (c.routes.isEmpty) {
          return const AppEmptyWidget(
            message: AppTexts.noAssignedRoutesYet,
            imagePath: AppImages.noAssignedRoutesYet,
          );
        }
        return ListView.separated(
          padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
          itemCount: c.routes.length,
          separatorBuilder: (_, __) => AppSpacing.vertical(context, 0.015),
          itemBuilder: (_, i) {
            final r = c.routes[i];
            return Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  AppResponsive.radius(context),
                ),
                side: BorderSide(color: AppColors.lightGrey),
              ),
              child: Padding(
                padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
                child: Row(
                  children: [
                    Icon(
                      Iconsax.route_square,
                      size: AppResponsive.iconSize(context, factor: 1.2),
                      color: AppColors.primary,
                    ),
                    AppSpacing.horizontal(context, 0.03),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            r.name,
                            style: AppTextStyles.bodyText(
                              context,
                            ).copyWith(fontWeight: FontWeight.w600),
                          ),
                          if (r.zoneId != null) ...[
                            AppSpacing.vertical(context, 0.004),
                            Text(
                              '${AppTexts.zoneIdLabel}: ${r.zoneId}',
                              style: AppTextStyles.hintText(context),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
