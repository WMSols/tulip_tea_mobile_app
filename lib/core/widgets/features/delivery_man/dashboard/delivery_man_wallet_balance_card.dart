import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/core/widgets/features/order_booker/dashboard/wallet_balance_card.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/delivery_man/dashboard/delivery_man_dashboard_controller.dart';

/// Delivery man dashboard wallet card: reads from [DeliveryManDashboardController].
class DeliveryManWalletBalanceCard extends StatelessWidget {
  const DeliveryManWalletBalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<DeliveryManDashboardController>();
    return Obx(
      () => WalletBalanceCard(
        balance: c.walletBalance.value,
        isLoading: c.isLoadingWallet.value,
        onRefresh: c.refreshBalance,
      ),
    );
  }
}
