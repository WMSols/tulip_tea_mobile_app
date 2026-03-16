import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/core/widgets/features/order_booker/dashboard/transaction_history_section.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/delivery_man/dashboard/delivery_man_dashboard_controller.dart';

/// Delivery man dashboard: transaction history section (reads from [DeliveryManDashboardController]).
class DeliveryManTransactionHistorySection extends StatelessWidget {
  const DeliveryManTransactionHistorySection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<DeliveryManDashboardController>();
    return Obx(
      () => TransactionHistorySection(
        transactions: c.transactions.toList(),
        isLoading: c.isLoadingTransactions.value && c.transactions.isEmpty,
        onViewFull: c.transactions.isEmpty
            ? null
            : () => showTransactionHistoryBottomSheet(
                context,
                c.transactions.toList(),
              ),
      ),
    );
  }
}
