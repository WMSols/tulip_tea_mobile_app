import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_order_booker/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_order_booker/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_order_booker/core/utils/app_texts/app_texts.dart';
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
          child: const AppShimmerList(itemCount: 5),
        );
      }
      if (c.visits.isEmpty) {
        return AppEmptyWidget(
          message: AppTexts.noVisitsYet,
          icon: Iconsax.calendar_1,
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
    return Hero(
      tag: 'visit_${visit.id}',
      child: Material(
        color: Colors.transparent,
        child: Card(
          child: ListTile(
            leading: const Icon(Iconsax.location),
            title: Text(
              visit.shopName ?? '${AppTexts.visitTypes} #${visit.id}',
              style: AppTextStyles.bodyText(context),
            ),
            subtitle: Text(
              '${visit.visitType ?? '-'} • ${visit.visitTime ?? visit.createdAt ?? '-'}',
              style: AppTextStyles.hintText(context),
            ),
          ),
        ),
      ),
    );
  }
}
