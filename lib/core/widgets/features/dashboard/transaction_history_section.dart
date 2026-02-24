import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_formatter/app_formatter.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_images/app_images.dart';
import 'package:tulip_tea_mobile_app/core/widgets/buttons/app_icon_button.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/dashboard/dashboard_section_card.dart';
import 'package:tulip_tea_mobile_app/domain/entities/wallet_transaction.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/dashboard/dashboard_controller.dart';

bool _isCredit(String type) {
  final t = type.toLowerCase();
  return t == 'credit' || t == 'transfer_in';
}

/// Single transaction row: type, then amount under it; description, balance, date below.
/// Amount is shown under the type label.
class TransactionHistoryItem extends StatelessWidget {
  const TransactionHistoryItem({super.key, required this.transaction});

  final WalletTransaction transaction;

  @override
  Widget build(BuildContext context) {
    final isCredit = _isCredit(transaction.transactionType);
    final color = isCredit ? AppColors.success : AppColors.error;
    final typeLabel = transaction.transactionType
        .replaceAll('_', ' ')
        .toUpperCase();
    final dateStr = AppFormatter.dateTimeFromString(
      transaction.createdAt,
      fallback: '–',
    );
    final amountStr =
        '${isCredit ? '+' : '-'}${AppFormatter.formatCurrency(transaction.amount)}';

    return Padding(
      padding: EdgeInsets.only(
        bottom: AppSpacing.verticalValue(context, 0.012),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            isCredit ? Iconsax.arrow_down : Iconsax.arrow_up_2,
            color: color,
          ),
          AppSpacing.horizontal(context, 0.01),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  typeLabel,
                  style: AppTextStyles.bodyText(
                    context,
                  ).copyWith(fontWeight: FontWeight.w800, color: color),
                ),
                Text(
                  amountStr,
                  style: AppTextStyles.bodyText(context).copyWith(
                    fontWeight: FontWeight.w800,
                    color: color,
                    fontSize: AppResponsive.screenWidth(context) * 0.034,
                  ),
                ),
                if (transaction.description?.isNotEmpty == true) ...[
                  AppSpacing.vertical(context, 0.003),
                  Text(
                    transaction.description!,
                    style: AppTextStyles.hintText(context).copyWith(
                      fontSize: AppResponsive.screenWidth(context) * 0.03,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                AppSpacing.vertical(context, 0.005),
                Text(
                  '${AppTexts.balanceBefore}: ${AppFormatter.formatCurrency(transaction.balanceBefore)}',
                  style: AppTextStyles.hintText(context).copyWith(
                    fontSize: AppResponsive.screenWidth(context) * 0.028,
                  ),
                ),
                Text(
                  '${AppTexts.balanceAfter}: ${AppFormatter.formatCurrency(transaction.balanceAfter)}',
                  style: AppTextStyles.hintText(context).copyWith(
                    fontSize: AppResponsive.screenWidth(context) * 0.028,
                  ),
                ),
                AppSpacing.vertical(context, 0.005),
                Text(
                  dateStr,
                  style: AppTextStyles.hintText(context).copyWith(
                    fontSize: AppResponsive.screenWidth(context) * 0.026,
                    color: AppColors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Bottom sheet content: scrollable list of all transactions.
void showTransactionHistoryBottomSheet(
  BuildContext context,
  List<WalletTransaction> transactions,
) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: AppColors.white,
    builder: (ctx) => DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.3,
      maxChildSize: 0.95,
      expand: false,
      builder: (_, scrollController) => Padding(
        padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  AppTexts.transactionHistory,
                  style: AppTextStyles.heading(
                    ctx,
                  ).copyWith(color: AppColors.primary),
                ),
                const Spacer(),
                AppIconButton(
                  icon: Iconsax.close_circle,
                  color: AppColors.black,
                  onPressed: () => Navigator.of(ctx).pop(),
                ),
              ],
            ),
            AppSpacing.vertical(context, 0.01),
            const Divider(height: 1, color: AppColors.primary),
            Flexible(
              child: ListView.builder(
                controller: scrollController,
                padding: AppSpacing.symmetric(ctx, h: 0, v: 0.02),
                itemCount: transactions.length,
                itemBuilder: (_, i) =>
                    TransactionHistoryItem(transaction: transactions[i]),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

/// Reusable transaction history: shows only latest transaction + "View Full" button.
class TransactionHistorySection extends StatelessWidget {
  const TransactionHistorySection({
    super.key,
    required this.transactions,
    this.isLoading = false,
    this.onViewFull,
  });

  final List<WalletTransaction> transactions;
  final bool isLoading;
  final VoidCallback? onViewFull;

  @override
  Widget build(BuildContext context) {
    final latest = transactions.isNotEmpty ? transactions.first : null;
    final hasData = !isLoading && transactions.isNotEmpty;
    return DashboardSectionCard(
      icon: Iconsax.receipt_item,
      title: AppTexts.transactionHistory,
      illustrationPath: AppImages.transactions,
      expandedBottom: hasData
          ? DashboardSectionCardExpandedBottom(
              label: AppTexts.viewFull,
              icon: Iconsax.arrow_up_2,
              onTap: onViewFull,
            )
          : null,
      child: isLoading && transactions.isEmpty
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          : transactions.isEmpty
          ? Text(
              AppTexts.noTransactionsYet,
              style: AppTextStyles.hintText(context),
            )
          : latest != null
          ? TransactionHistoryItem(transaction: latest)
          : const SizedBox.shrink(),
    );
  }
}

/// Convenience widget that reads from [DashboardController] and opens bottom sheet on View Full.
class DashboardTransactionHistorySection extends StatelessWidget {
  const DashboardTransactionHistorySection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<DashboardController>();
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
