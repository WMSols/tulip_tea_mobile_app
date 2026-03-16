import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_images/app_images.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/delivery_man/deliveries/delivery_man_delivery_card.dart';
import 'package:tulip_tea_mobile_app/core/widgets/feedback/app_empty_widget.dart';
import 'package:tulip_tea_mobile_app/core/widgets/feedback/app_shimmer.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
// import 'package:tulip_tea_mobile_app/core/widgets/form/app_dropdown_field/app_dropdown_field.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/delivery_man/deliveries/delivery_man_deliveries_controller.dart';

/// Deliveries tab: status filter dropdown + single flat list (filter controls what is shown).
class DeliveriesListContent extends StatelessWidget {
  const DeliveriesListContent({super.key, required this.controller});

  final DeliveryManDeliveriesController controller;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: AppColors.primary,
      color: AppColors.white,
      onRefresh: () => controller.loadDeliveries(),
      child: Obx(() {
        final isLoading = controller.isLoading.value;
        final items = controller.items;
        final list = controller.filteredItems;
        final isEmpty = items.isEmpty;
        final listEmpty = list.isEmpty;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Filters temporarily hidden as per requirements.
            // Padding(
            //   padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
            //   child: AppDropdownField<String?>(
            //     label: AppTexts.status,
            //     hint: AppTexts.filterAll,
            //     value: controller.statusFilter.value,
            //     items: const [null, 'Confirmed', 'Delivered', 'Cancelled'],
            //     getLabel: (v) => _filterLabel(v),
            //     onChanged: (v) => controller.setStatusFilter(v),
            //   ),
            // ),
            Expanded(
              child: isLoading && isEmpty
                  ? const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: AppShimmerList(),
                    )
                  : listEmpty
                  ? Center(
                      child: AppEmptyWidget(
                        message: isEmpty
                            ? AppTexts.noActiveDeliveries
                            : AppTexts.noDeliveriesMatchFilter,
                        imagePath: AppImages.noDeliveriesYet,
                      ),
                    )
                  : ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
                      itemCount: list.length,
                      separatorBuilder: (_, __) =>
                          AppSpacing.vertical(context, 0.01),
                      itemBuilder: (_, i) =>
                          DeliveryManDeliveryCard(item: list[i]),
                    ),
            ),
          ],
        );
      }),
    );
  }

  // static String _filterLabel(String? value) {
  //   if (value == null || value.isEmpty) return AppTexts.filterAll;
  //   return value;
  // }
}
