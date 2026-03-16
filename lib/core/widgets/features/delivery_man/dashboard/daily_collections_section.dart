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
import 'package:tulip_tea_mobile_app/core/widgets/features/order_booker/dashboard/dashboard_section_card.dart';
import 'package:tulip_tea_mobile_app/domain/entities/daily_collection.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/delivery_man/dashboard/delivery_man_dashboard_controller.dart';

/// Delivery man dashboard: daily collections summary (count, expandable list).
class DailyCollectionsSection extends StatelessWidget {
  const DailyCollectionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<DeliveryManDashboardController>();
    return Obx(() {
      final list = c.dailyCollections.toList();
      final hasData = list.isNotEmpty;
      return _DailyCollectionsContent(collections: list, hasData: hasData);
    });
  }
}

class _DailyCollectionsContent extends StatefulWidget {
  const _DailyCollectionsContent({
    required this.collections,
    required this.hasData,
  });

  final List<DailyCollection> collections;
  final bool hasData;

  @override
  State<_DailyCollectionsContent> createState() =>
      _DailyCollectionsContentState();
}

class _DailyCollectionsContentState extends State<_DailyCollectionsContent> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return DashboardSectionCard(
      icon: Iconsax.wallet_3,
      title: AppTexts.dailyCollections,
      illustrationPath: AppImages.wallet,
      expandedBottom: widget.hasData
          ? DashboardSectionCardExpandedBottom(
              label: _expanded ? AppTexts.tapToCollapse : AppTexts.tapToExpand,
              icon: _expanded ? Iconsax.arrow_up_2 : Iconsax.arrow_down_1,
              onTap: () => setState(() => _expanded = !_expanded),
            )
          : null,
      child: !widget.hasData
          ? Text(
              AppTexts.noCollectionsYet,
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
                            text: '${widget.collections.length}',
                            style: AppTextStyles.headline(context).copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const TextSpan(text: ' collection(s)'),
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
    final collections = widget.collections;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: collections
          .map(
            (c) => Padding(
              padding: EdgeInsets.only(
                bottom: collections.last == c
                    ? 0
                    : AppSpacing.verticalValue(context, 0.01),
              ),
              child: Row(
                children: [
                  Icon(
                    Iconsax.money_recive,
                    size: AppResponsive.iconSize(context, factor: 0.9),
                    color: AppColors.primary,
                  ),
                  AppSpacing.horizontal(context, 0.02),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          c.shopName ?? '–',
                          style: AppTextStyles.hintText(context),
                        ),
                        Text(
                          AppFormatter.formatCurrency(c.amount),
                          style: AppTextStyles.bodyText(
                            context,
                          ).copyWith(fontWeight: FontWeight.w600),
                        ),
                        if (c.collectionDate != null)
                          Text(
                            c.collectionDate!,
                            style: AppTextStyles.hintText(context).copyWith(
                              fontSize:
                                  AppResponsive.screenWidth(context) * 0.028,
                            ),
                          ),
                      ],
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
