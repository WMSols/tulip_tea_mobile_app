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
import 'package:tulip_tea_mobile_app/data/models/delivery/delivery_model.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/delivery_man/dashboard/delivery_man_dashboard_controller.dart';

/// Delivery man dashboard: deliveries summary (active + completed counts, expandable list).
class DeliveriesSummarySection extends StatelessWidget {
  const DeliveriesSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<DeliveryManDashboardController>();
    return Obx(() {
      final active = c.activeDeliveries;
      final completed = c.completedDeliveries;
      final hasData = active.isNotEmpty || completed.isNotEmpty;
      return _DeliveriesSummaryContent(
        activeDeliveries: active,
        completedDeliveries: completed,
        hasData: hasData,
      );
    });
  }
}

class _DeliveriesSummaryContent extends StatefulWidget {
  const _DeliveriesSummaryContent({
    required this.activeDeliveries,
    required this.completedDeliveries,
    required this.hasData,
  });

  final List<DeliveryModel> activeDeliveries;
  final List<DeliveryModel> completedDeliveries;
  final bool hasData;

  @override
  State<_DeliveriesSummaryContent> createState() =>
      _DeliveriesSummaryContentState();
}

class _DeliveriesSummaryContentState extends State<_DeliveriesSummaryContent> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return DashboardSectionCard(
      icon: Iconsax.truck,
      title: AppTexts.deliveriesSummary,
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
              AppTexts.noActiveDeliveries,
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: AppTextStyles.heading(
                              context,
                            ).copyWith(color: AppColors.black),
                            children: [
                              TextSpan(
                                text: '${widget.activeDeliveries.length}',
                                style: AppTextStyles.headline(context).copyWith(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const TextSpan(
                                text: ' ${AppTexts.activeDeliveries}',
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: AppTextStyles.heading(
                              context,
                            ).copyWith(color: AppColors.black),
                            children: [
                              TextSpan(
                                text: '${widget.completedDeliveries.length}',
                                style: AppTextStyles.headline(context).copyWith(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const TextSpan(
                                text: ' ${AppTexts.completedDeliveries}',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  if (_expanded) _buildList(context),
                ],
              ),
            ),
    );
  }

  Widget _buildList(BuildContext context) {
    final all = [...widget.activeDeliveries, ...widget.completedDeliveries];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: all
          .map(
            (d) => Padding(
              padding: EdgeInsets.only(
                bottom: all.last == d
                    ? 0
                    : AppSpacing.verticalValue(context, 0.01),
              ),
              child: Row(
                children: [
                  Icon(
                    Iconsax.truck_tick,
                    size: AppResponsive.iconSize(context, factor: 0.9),
                    color: AppColors.primary,
                  ),
                  AppSpacing.horizontal(context, 0.02),
                  Expanded(
                    child: Text(
                      '${AppTexts.orderId} #${d.orderId ?? d.id} • ${d.status ?? "–"}',
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
