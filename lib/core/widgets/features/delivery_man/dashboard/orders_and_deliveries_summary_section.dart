import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_images/app_images.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_helper/app_helper.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_status_chip.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/order_booker/dashboard/dashboard_section_card.dart';
import 'package:tulip_tea_mobile_app/domain/entities/order_for_delivery_man.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/delivery_man/dashboard/delivery_man_dashboard_controller.dart';

/// Delivery man dashboard: combined summary for Orders (Pending) + Deliveries (Active).
///
/// - Pending: only "Not Started" orders.
/// - Active: orders whose delivery status is in_transit or partially_delivered.
/// - Completed: delivered count only (no details list).
class OrdersAndDeliveriesSummarySection extends StatefulWidget {
  const OrdersAndDeliveriesSummarySection({super.key});

  @override
  State<OrdersAndDeliveriesSummarySection> createState() =>
      _OrdersAndDeliveriesSummarySectionState();
}

class _OrdersAndDeliveriesSummarySectionState
    extends State<OrdersAndDeliveriesSummarySection> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final c = Get.find<DeliveryManDashboardController>();
    return Obx(() {
      final pendingOrders = c.pendingOrdersNotStarted
          .map((o) => _OrderRowItem(order: o, status: 'not_started'))
          .toList();
      final activeOrders = c.activeOrdersInTransitOrPartiallyDelivered
          .map(
            (o) => _OrderRowItem(
              order: o,
              status: 'in_transit', // fallback; resolved below if possible
            ),
          )
          .toList();

      // Prefer exact delivery status from the embedded delivery model, so partially_delivered is shown correctly.
      final byId = <int, String>{};
      for (final item in c.ordersWithDelivery) {
        final o = item.order;
        final d = item.delivery;
        if (d == null || d is Map) continue;
        final statusRaw = (d as dynamic).status as String?;
        final normalized = _normStatus(statusRaw);
        if (normalized.isNotEmpty) byId[o.id] = normalized;
      }
      final activeResolved = activeOrders
          .map(
            (e) => _OrderRowItem(
              order: e.order,
              status: byId[e.order.id] ?? e.status,
            ),
          )
          .toList();

      final completedCount = c.deliveredDeliveriesOnly.length;

      final pending = pendingOrders.length;
      final active = activeResolved.length;
      final isEmpty = pending == 0 && active == 0 && completedCount == 0;

      return DashboardSectionCard(
        icon: Iconsax.status_up,
        title: AppTexts.ordersAndDeliveriesSummary,
        illustrationPath: AppImages.routes,
        expandedBottom: (!isEmpty)
            ? Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (_expanded)
                    SizedBox(height: AppSpacing.verticalValue(context, 0.008)),
                  DashboardSectionCardExpandedBottom(
                    label: _expanded
                        ? AppTexts.tapToCollapse
                        : AppTexts.tapToExpand,
                    icon: _expanded ? Iconsax.arrow_up_2 : Iconsax.arrow_down_1,
                    onTap: () => setState(() => _expanded = !_expanded),
                  ),
                ],
              )
            : null,
        child: isEmpty
            ? Text(
                AppTexts.noAssignedOrdersYet,
                style: AppTextStyles.hintText(context),
              )
            : AnimatedSize(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                alignment: Alignment.topCenter,
                child: !_expanded
                    ? _CountsView(
                        pending: pending,
                        active: active,
                        completed: completedCount,
                      )
                    : _ExpandedDetailsView(
                        pendingOrders: pendingOrders,
                        activeOrders: activeResolved,
                      ),
              ),
      );
    });
  }
}

class _OrderRowItem {
  const _OrderRowItem({required this.order, required this.status});
  final OrderForDeliveryMan order;
  final String status;
}

String _normStatus(String? s) => AppHelper.normalizeStatus(s);

class _CountsView extends StatelessWidget {
  const _CountsView({
    required this.pending,
    required this.active,
    required this.completed,
  });

  final int pending;
  final int active;
  final int completed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _countRow(context, count: pending, label: AppTexts.orderStatusPending),
        _countRow(context, count: active, label: AppTexts.activeDeliveries),
        _countRow(
          context,
          count: completed,
          label: AppTexts.completedDeliveries,
        ),
      ],
    );
  }

  Widget _countRow(
    BuildContext context, {
    required int count,
    required String label,
  }) {
    return RichText(
      text: TextSpan(
        style: AppTextStyles.heading(context).copyWith(color: AppColors.black),
        children: [
          TextSpan(
            text: '$count',
            style: AppTextStyles.headline(
              context,
            ).copyWith(color: AppColors.black, fontWeight: FontWeight.w800),
          ),
          TextSpan(text: ' $label'),
        ],
      ),
    );
  }
}

class _ExpandedDetailsView extends StatelessWidget {
  const _ExpandedDetailsView({
    required this.pendingOrders,
    required this.activeOrders,
  });

  final List<_OrderRowItem> pendingOrders;
  final List<_OrderRowItem> activeOrders;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _sectionTitle(context, AppTexts.orderStatusPending),
        if (pendingOrders.isEmpty)
          Text(AppTexts.notAvailable, style: AppTextStyles.hintText(context))
        else
          ..._listWithDividers(context, pendingOrders),
        AppSpacing.vertical(context, 0.012),
        _sectionTitle(context, AppTexts.activeDeliveries),
        if (activeOrders.isEmpty)
          Text(AppTexts.notAvailable, style: AppTextStyles.hintText(context))
        else
          ..._listWithDividers(context, activeOrders),
      ],
    );
  }

  List<Widget> _listWithDividers(
    BuildContext context,
    List<_OrderRowItem> list,
  ) {
    final widgets = <Widget>[];
    for (var i = 0; i < list.length; i++) {
      widgets.add(_orderRow(context, list[i]));
      if (i != list.length - 1) {
        widgets.add(
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: AppSpacing.verticalValue(context, 0.008),
            ),
            child: Divider(
              color: AppColors.primary.withValues(alpha: 0.25),
              height: 1,
            ),
          ),
        );
      }
    }
    return widgets;
  }

  Widget _sectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: AppTextStyles.bodyText(
        context,
      ).copyWith(fontWeight: FontWeight.w700, color: AppColors.primary),
    );
  }

  Widget _orderRow(BuildContext context, _OrderRowItem item) {
    final order = item.order;
    final status = item.status;
    final id = order.id;
    final shopName = order.shopName ?? '–';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${AppTexts.orderId} #$id',
          style: AppTextStyles.hintText(
            context,
          ).copyWith(color: AppColors.black, fontWeight: FontWeight.w500),
        ),
        Text(shopName, style: AppTextStyles.hintText(context)),
        AppStatusChip(
          status: status,
          text: AppHelper.dmDeliveryStatusLabel(status),
          backgroundColor: AppHelper.dmDeliveryStatusChipColor(status),
          icon: AppHelper.dmDeliveryStatusChipIcon(status),
        ),
      ],
    );
  }
}
