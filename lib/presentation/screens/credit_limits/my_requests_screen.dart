import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_order_booker/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_order_booker/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_order_booker/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_order_booker/core/widgets/feedback/app_empty_widget.dart';
import 'package:tulip_tea_order_booker/core/widgets/feedback/app_shimmer.dart';
import 'package:tulip_tea_order_booker/domain/entities/credit_limit_request.dart';
import 'package:tulip_tea_order_booker/presentation/controllers/credit_limits/my_requests_controller.dart';

class MyRequestsScreen extends StatelessWidget {
  const MyRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<MyRequestsController>();
    return Obx(() {
      if (c.isLoading.value) {
        return Padding(
          padding: AppSpacing.symmetric(context, h: 0.05, v: 0.02),
          child: const AppShimmerList(itemCount: 5),
        );
      }
      if (c.requests.isEmpty) {
        return AppEmptyWidget(
          message: AppTexts.noCreditRequestsYet,
          icon: Iconsax.wallet_3,
        );
      }
      return ListView.separated(
        padding: AppSpacing.symmetric(context, h: 0.05, v: 0.02),
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
    return Hero(
      tag: 'credit_request_${request.id}',
      child: Material(
        color: Colors.transparent,
        child: Card(
          child: ListTile(
            leading: const Icon(Iconsax.wallet_3),
            title: Text(
              request.shopName ?? 'Shop #${request.shopId}',
              style: AppTextStyles.bodyText(context),
            ),
            subtitle: Text(
              '${AppTexts.requestedCreditLimit}: ${request.requestedCreditLimit} • ${request.status ?? '-'}',
              style: AppTextStyles.hintText(context),
            ),
          ),
        ),
      ),
    );
  }
}
