import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_images/app_images.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_info_card.dart';
import 'package:tulip_tea_mobile_app/core/widgets/feedback/app_empty_widget.dart';
import 'package:tulip_tea_mobile_app/core/widgets/feedback/app_shimmer.dart';
import 'package:tulip_tea_mobile_app/domain/entities/credit_limit_request.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/credit_limits/my_requests_controller.dart';

class MyRequestsScreen extends StatelessWidget {
  const MyRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<MyRequestsController>();
    return Obx(() {
      if (c.isLoading.value) {
        return Padding(
          padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
          child: const AppShimmerList(),
        );
      }
      if (c.requests.isEmpty) {
        return AppEmptyWidget(
          message: AppTexts.noCreditRequestsYet,
          imagePath: AppImages.noCreditRequestsYet,
        );
      }
      return ListView.separated(
        padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
        itemCount: c.requests.length,
        separatorBuilder: (_, __) => AppSpacing.vertical(context, 0.015),
        itemBuilder: (_, i) {
          final request = c.requests[i];
          return _RequestCard(request: request);
        },
      );
    });
  }
}

class _RequestCard extends StatelessWidget {
  const _RequestCard({required this.request});

  final CreditLimitRequest request;

  @override
  Widget build(BuildContext context) {
    final oldStr = request.oldCreditLimit != null
        ? '${AppTexts.rupeeSymbol} ${request.oldCreditLimit!.toStringAsFixed(0)}'
        : '–';
    final requestedStr =
        '${AppTexts.rupeeSymbol} ${request.requestedCreditLimit.toStringAsFixed(0)}';
    final statusStr = request.status ?? '–';
    final statusColor = _statusColor(context, statusStr);

    return Hero(
      tag: 'credit_request_${request.id}',
      child: Material(
        color: Colors.transparent,
        child: AppInfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Iconsax.wallet_3,
                    size: AppResponsive.iconSize(context, factor: 1.2),
                    color: AppColors.primary,
                  ),
                  AppSpacing.horizontal(context, 0.02),
                  Expanded(
                    child: Text(
                      request.shopName ??
                          '${AppTexts.shopName} #${request.shopId}',
                      style: AppTextStyles.bodyText(context).copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.horizontalValue(context, 0.02),
                      vertical: AppSpacing.verticalValue(context, 0.006),
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(
                        AppResponsive.radius(context),
                      ),
                    ),
                    child: Text(
                      statusStr,
                      style: AppTextStyles.labelText(context).copyWith(
                        color: statusColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              AppSpacing.vertical(context, 0.012),
              AppInfoRow(
                label: AppTexts.currentLimit,
                value: oldStr,
                showDivider: true,
              ),
              AppInfoRow(
                label: AppTexts.requestedLimit,
                value: requestedStr,
                showDivider: true,
              ),
              AppInfoRow(
                label: AppTexts.status,
                value: statusStr,
                showDivider: true,
              ),
              if (request.requestedByRole != null &&
                  request.requestedByRole!.isNotEmpty)
                AppInfoRow(
                  label: AppTexts.requestedBy,
                  value: request.requestedByRole!,
                  showDivider: true,
                ),
              if (request.approvedByDistributorName != null &&
                  request.approvedByDistributorName!.isNotEmpty)
                AppInfoRow(
                  label: AppTexts.approvedBy,
                  value: request.approvedByDistributorName!,
                  showDivider: true,
                ),
              if (request.remarks != null && request.remarks!.trim().isNotEmpty)
                AppInfoRow(
                  label: AppTexts.remarks,
                  value: request.remarks!,
                  showDivider: true,
                ),
              AppInfoRow(
                label: '${AppTexts.requestId} | ${AppTexts.created}',
                value: '${request.id} | ${request.createdAt ?? "–"}',
                showDivider: false,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Color _statusColor(BuildContext context, String status) {
    final s = status.toLowerCase();
    if (s == 'approved') return AppColors.success;
    if (s == 'rejected') return AppColors.error;
    return AppColors.warning;
  }
}
