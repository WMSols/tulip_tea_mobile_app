import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_fonts/app_fonts.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_formatter/app_formatter.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_helper/app_helper.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_detail_row.dart';
import 'package:tulip_tea_mobile_app/domain/entities/shop_visit.dart';

/// Scrollable content for visit details: shop, visit type(s), time, reason, created.
class VisitDetailsContent extends StatelessWidget {
  const VisitDetailsContent({super.key, required this.visit});

  final ShopVisit visit;

  @override
  Widget build(BuildContext context) {
    final shopName =
        visit.shopName ?? '${AppTexts.shopName} #${visit.shopId ?? visit.id}';
    final visitTypes = AppHelper.parseCommaSeparatedList(visit.visitType);
    final visitTimeStr = AppFormatter.dateTimeFromString(
      visit.visitTime ?? visit.createdAt,
    );
    final reasonStr = visit.reason.isNotNullOrEmpty ? visit.reason! : '–';
    final createdStr = AppFormatter.dateTimeFromString(visit.createdAt);

    final baseStyle = AppTextStyles.bodyText(context);
    final typeValueWidget = visitTypes.isEmpty
        ? Text(AppFormatter.visitTypeDisplay(visit.visitType), style: baseStyle)
        : Text.rich(
            TextSpan(
              children: [
                for (int i = 0; i < visitTypes.length; i++) ...[
                  if (i > 0) TextSpan(text: ', ', style: baseStyle),
                  TextSpan(
                    text: AppFormatter.visitTypeDisplay(visitTypes[i]),
                    style: baseStyle.copyWith(
                      color: AppFormatter.visitTypeChipStyle(visitTypes[i]).$1,
                      fontWeight: FontWeight.w800,
                      fontFamily: AppFonts.primaryFont,
                    ),
                  ),
                ],
              ],
            ),
          );

    return SingleChildScrollView(
      padding: AppSpacing.symmetric(context, h: 0.05, v: 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppDetailRow(
            icon: Iconsax.shop,
            label: AppTexts.shopName,
            value: shopName,
          ),
          AppSpacing.vertical(context, 0.01),
          AppDetailRow(
            icon: Iconsax.calendar_tick,
            label: AppTexts.visitTypes,
            value: AppFormatter.visitTypeDisplay(visit.visitType),
            valueChild: typeValueWidget,
          ),
          AppSpacing.vertical(context, 0.01),
          AppDetailRow(
            icon: Iconsax.clock,
            label: AppTexts.visitTimeLabel,
            value: visitTimeStr,
          ),
          AppSpacing.vertical(context, 0.01),
          AppDetailRow(
            icon: Iconsax.note_2,
            label: AppTexts.reason,
            value: reasonStr,
          ),
          AppSpacing.vertical(context, 0.01),
          AppDetailRow(
            icon: Iconsax.calendar_1,
            label: AppTexts.created,
            value: createdStr,
          ),
          AppSpacing.vertical(context, 0.04),
        ],
      ),
    );
  }
}
