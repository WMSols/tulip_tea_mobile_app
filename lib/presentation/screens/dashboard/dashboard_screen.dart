import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_custom_app_bar.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/dashboard/assigned_routes_section.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/dashboard/schedule_calendar_view.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/dashboard/transaction_history_section.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/dashboard/wallet_balance_card.dart';
import 'package:tulip_tea_mobile_app/core/widgets/feedback/app_shimmer.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/dashboard/dashboard_controller.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<DashboardController>();
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
              const DashboardWalletBalanceCard(),
              AppSpacing.vertical(context, 0.01),
              AssignedRoutesSection(routes: c.routes.toList()),
              AppSpacing.vertical(context, 0.01),
              const DashboardScheduleCalendarView(),
              AppSpacing.vertical(context, 0.01),
              const DashboardTransactionHistorySection(),
              AppSpacing.vertical(context, 0.03),
            ],
          ),
        );
      }),
    );
  }
}
