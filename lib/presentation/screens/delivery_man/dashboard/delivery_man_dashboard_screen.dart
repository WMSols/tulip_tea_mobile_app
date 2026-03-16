import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_custom_app_bar.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/delivery_man/dashboard/daily_collections_section.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/delivery_man/dashboard/deliveries_summary_section.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/delivery_man/dashboard/delivery_man_transaction_history_section.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/delivery_man/dashboard/delivery_man_wallet_balance_card.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/delivery_man/dashboard/orders_summary_section.dart';
import 'package:tulip_tea_mobile_app/core/widgets/feedback/app_shimmer.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/delivery_man/dashboard/delivery_man_dashboard_controller.dart';

/// Delivery man dashboard: wallet, deliveries summary, orders summary,
/// daily collections, and transaction history (same UI scheme as order booker).
class DeliveryManDashboardScreen extends StatelessWidget {
  const DeliveryManDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<DeliveryManDashboardController>();
    return Scaffold(
      appBar: const AppCustomAppBar(title: AppTexts.dashboard),
      body: Obx(() {
        if (c.isLoading.value) {
          return Padding(
            padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
            child: const AppShimmerList(itemCount: 10),
          );
        }
        return RefreshIndicator(
          backgroundColor: AppColors.primary,
          color: AppColors.white,
          onRefresh: c.loadAll,
          child: ListView(
            padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
            children: [
              const DeliveryManWalletBalanceCard(),
              AppSpacing.vertical(context, 0.01),
              const DeliveriesSummarySection(),
              AppSpacing.vertical(context, 0.01),
              const OrdersSummarySection(),
              AppSpacing.vertical(context, 0.01),
              const DailyCollectionsSection(),
              AppSpacing.vertical(context, 0.01),
              const DeliveryManTransactionHistorySection(),
              AppSpacing.vertical(context, 0.03),
            ],
          ),
        );
      }),
    );
  }
}
