import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_images/app_images.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/feedback/app_empty_widget.dart';
import 'package:tulip_tea_mobile_app/core/widgets/feedback/app_shimmer.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/credit_limits/my_requests/my_requests_card.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/credit_limits/my_requests_controller.dart';

class MyRequestsScreen extends StatelessWidget {
  const MyRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<MyRequestsController>();
    return RefreshIndicator(
      backgroundColor: AppColors.primary,
      color: AppColors.white,
      onRefresh: () => c.loadRequests(),
      child: Obx(() {
        if (c.isLoading.value && c.requests.isEmpty) {
          return Padding(
            padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
            child: const AppShimmerList(),
          );
        }
        if (c.requests.isEmpty) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              height: AppResponsive.screenHeight(context) * 0.7,
              child: Center(
                child: AppEmptyWidget(
                  message: AppTexts.noCreditRequestsYet,
                  imagePath: AppImages.noCreditRequestsYet,
                ),
              ),
            ),
          );
        }
        return ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
          itemCount: c.requests.length,
          separatorBuilder: (_, __) => AppSpacing.vertical(context, 0.01),
          itemBuilder: (_, i) {
            final request = c.requests[i];
            return MyRequestsCard(request: request);
          },
        );
      }),
    );
  }
}
