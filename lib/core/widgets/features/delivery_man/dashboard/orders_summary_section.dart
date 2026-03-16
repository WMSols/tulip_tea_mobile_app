import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_images/app_images.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/order_booker/dashboard/dashboard_section_card.dart';
import 'package:tulip_tea_mobile_app/domain/entities/order_for_delivery_man.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/delivery_man/dashboard/delivery_man_dashboard_controller.dart';

/// Delivery man dashboard: orders summary (pending count, expandable list).
class OrdersSummarySection extends StatelessWidget {
  const OrdersSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<DeliveryManDashboardController>();
    return Obx(() {
      final pending = c.pendingOrders;
      final hasData = pending.isNotEmpty;
      return _OrdersSummaryContent(pendingOrders: pending, hasData: hasData);
    });
  }
}

class _OrdersSummaryContent extends StatefulWidget {
  const _OrdersSummaryContent({
    required this.pendingOrders,
    required this.hasData,
  });

  final List<OrderForDeliveryMan> pendingOrders;
  final bool hasData;

  @override
  State<_OrdersSummaryContent> createState() => _OrdersSummaryContentState();
}

class _OrdersSummaryContentState extends State<_OrdersSummaryContent> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return DashboardSectionCard(
      icon: Iconsax.document_text,
      title: AppTexts.ordersSummary,
      illustrationPath: AppImages.routes,
      expandedBottom: widget.hasData
          ? DashboardSectionCardExpandedBottom(
              label: _expanded ? AppTexts.tapToCollapse : AppTexts.tapToExpand,
              icon: _expanded ? Iconsax.arrow_up_2 : Iconsax.arrow_down_1,
              onTap: () => setState(() => _expanded = !_expanded),
            )
          : null,
      child: !widget.hasData
          ? Text(
              AppTexts.noAssignedOrdersYet,
              style: AppTextStyles.hintText(context),
            )
          : AnimatedSize(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (!_expanded)
                    RichText(
                      text: TextSpan(
                        style: AppTextStyles.heading(
                          context,
                        ).copyWith(color: AppColors.black),
                        children: [
                          TextSpan(
                            text: '${widget.pendingOrders.length}',
                            style: AppTextStyles.headline(context).copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const TextSpan(
                            text: ' ${AppTexts.orderStatusPending}',
                          ),
                        ],
                      ),
                    ),
                  if (_expanded) _buildList(context),
                ],
              ),
            ),
    );
  }

  Widget _buildList(BuildContext context) {
    final orders = widget.pendingOrders;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: orders
          .map(
            (o) => Padding(
              padding: EdgeInsets.only(
                bottom: orders.last == o
                    ? 0
                    : AppSpacing.verticalValue(context, 0.01),
              ),
              child: Row(
                children: [
                  Icon(
                    Iconsax.receipt_item,
                    size: AppResponsive.iconSize(context, factor: 0.9),
                    color: AppColors.primary,
                  ),
                  AppSpacing.horizontal(context, 0.02),
                  Expanded(
                    child: Text(
                      '${AppTexts.orderId} #${o.id} • ${o.shopName ?? "–"}',
                      style: AppTextStyles.hintText(context),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
