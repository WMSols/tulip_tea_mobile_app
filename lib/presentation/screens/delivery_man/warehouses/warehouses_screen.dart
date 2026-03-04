import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_images/app_images.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/delivery_man/warehouses/delivery_man_warehouse_card.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_custom_app_bar.dart';
import 'package:tulip_tea_mobile_app/core/widgets/feedback/app_empty_widget.dart';
import 'package:tulip_tea_mobile_app/core/widgets/feedback/app_shimmer.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/delivery_man/warehouses/delivery_man_warehouses_controller.dart';

class DeliveryManWarehousesScreen extends StatelessWidget {
  const DeliveryManWarehousesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<DeliveryManWarehousesController>();
    return Scaffold(
      appBar: const AppCustomAppBar(title: AppTexts.warehouses),
      body: SafeArea(
        child: RefreshIndicator(
          backgroundColor: AppColors.primary,
          color: AppColors.white,
          onRefresh: () => c.loadWarehouses(),
          child: Obx(() {
            if (c.isLoading.value && c.warehouses.isEmpty) {
              return Padding(
                padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
                child: const AppShimmerList(),
              );
            }
            if (c.warehouses.isEmpty) {
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: AppResponsive.screenHeight(context) * 0.7,
                  child: Center(
                    child: AppEmptyWidget(
                      message: AppTexts.noWarehousesAssigned,
                      imagePath: AppImages.noWarehousesYet,
                    ),
                  ),
                ),
              );
            }
            return ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
              itemCount: c.warehouses.length,
              separatorBuilder: (_, __) => AppSpacing.vertical(context, 0.01),
              itemBuilder: (_, i) {
                final warehouse = c.warehouses[i];
                return DeliveryManWarehouseCard(warehouse: warehouse);
              },
            );
          }),
        ),
      ),
    );
  }
}
