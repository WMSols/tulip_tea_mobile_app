import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_order_booker/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_order_booker/core/utils/app_images/app_images.dart';
import 'package:tulip_tea_order_booker/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_order_booker/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_order_booker/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_order_booker/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_order_booker/core/widgets/common/app_info_card.dart';
import 'package:tulip_tea_order_booker/core/widgets/feedback/app_empty_widget.dart';
import 'package:tulip_tea_order_booker/core/widgets/feedback/app_shimmer.dart';
import 'package:tulip_tea_order_booker/domain/entities/shop_visit.dart';
import 'package:tulip_tea_order_booker/presentation/controllers/visits/visit_history_controller.dart';

class VisitHistoryScreen extends StatelessWidget {
  const VisitHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<VisitHistoryController>();
    return Obx(() {
      if (c.isLoading.value) {
        return Padding(
          padding: AppSpacing.symmetric(context, h: 0.05, v: 0.02),
          child: const AppShimmerList(),
        );
      }
      if (c.visits.isEmpty) {
        return AppEmptyWidget(
          message: AppTexts.noVisitsYet,
          imagePath: AppImages.noVisitsYet,
        );
      }
      return ListView.separated(
        padding: AppSpacing.symmetric(context, h: 0.05, v: 0.02),
        itemCount: c.visits.length,
        separatorBuilder: (_, __) => AppSpacing.vertical(context, 0.015),
        itemBuilder: (_, i) {
          final visit = c.visits[i];
          return _VisitCard(visit: visit);
        },
      );
    });
  }
}

class _VisitCard extends StatelessWidget {
  const _VisitCard({required this.visit});

  final ShopVisit visit;

  @override
  Widget build(BuildContext context) {
    final shopName =
        visit.shopName ?? '${AppTexts.visitTypes} #${visit.id}';
    final typeStr = visit.visitType ?? '–';
    final locationStr = (visit.gpsLat != null && visit.gpsLng != null)
        ? '${visit.gpsLat!.toStringAsFixed(4)}, ${visit.gpsLng!.toStringAsFixed(4)}'
        : '–';
    final timeStr = visit.visitTime ?? visit.createdAt ?? AppTexts.notRecorded;
    final reasonStr = (visit.reason != null && visit.reason!.trim().isNotEmpty)
        ? visit.reason!
        : '–';

    return Hero(
      tag: 'visit_${visit.id}',
      child: Material(
        color: Colors.transparent,
        child: AppInfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Iconsax.location,
                    size: AppResponsive.iconSize(context, factor: 1.2),
                    color: AppColors.primary,
                  ),
                  AppSpacing.horizontal(context, 0.02),
                  Expanded(
                    child: Text(
                      shopName,
                      style: AppTextStyles.bodyText(context).copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
              AppSpacing.vertical(context, 0.012),
              AppInfoRow(
                label: AppTexts.visitTypes,
                value: typeStr,
                showDivider: true,
              ),
              AppInfoRow(
                label: AppTexts.location,
                value: locationStr,
                showDivider: true,
              ),
              AppInfoRow(
                label: AppTexts.visitTimeLabel,
                value: timeStr,
                showDivider: true,
              ),
              AppInfoRow(
                label: AppTexts.reason,
                value: reasonStr,
                showDivider: true,
              ),
              AppInfoRow(
                label: '${AppTexts.visitId} | ${AppTexts.created}',
                value: '${visit.id} | ${visit.createdAt ?? "–"}',
                showDivider: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
