import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_images/app_images.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_custom_app_bar.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/delivery_man/orders/delivery_man_order_card.dart';
import 'package:tulip_tea_mobile_app/core/widgets/feedback/app_empty_widget.dart';
import 'package:tulip_tea_mobile_app/core/widgets/feedback/app_shimmer.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/delivery_man/orders/delivery_man_orders_controller.dart';

class DeliveryManOrdersScreen extends StatelessWidget {
  const DeliveryManOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<DeliveryManOrdersController>();
    return Scaffold(
      appBar: const AppCustomAppBar(title: AppTexts.orders),
      body: SafeArea(
        child: RefreshIndicator(
          backgroundColor: AppColors.primary,
          color: AppColors.white,
          onRefresh: () => c.loadOrders(),
          child: Obx(() {
            if (c.isLoading.value && c.activeOrders.isEmpty) {
              return Padding(
                padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
                child: const AppShimmerList(),
              );
            }
            if (c.activeOrders.isEmpty) {
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: AppResponsive.screenHeight(context) * 0.7,
                  child: Center(
                    child: AppEmptyWidget(
                      message: AppTexts.noAssignedOrdersYet,
                      imagePath: AppImages.noOrdersYet,
                    ),
                  ),
                ),
              );
            }
            return ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
              itemCount: c.activeOrders.length,
              separatorBuilder: (_, __) => AppSpacing.vertical(context, 0.01),
              itemBuilder: (_, i) {
                final item = c.activeOrders[i];
                return DeliveryManOrderCard(item: item);
              },
            );
          }),
        ),
      ),
    );
  }
}
