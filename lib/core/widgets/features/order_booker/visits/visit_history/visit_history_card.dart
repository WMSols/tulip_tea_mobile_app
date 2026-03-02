import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_formatter/app_formatter.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_helper/app_helper.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_fonts/app_fonts.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_status_chip.dart';
import 'package:tulip_tea_mobile_app/domain/entities/shop_visit.dart';
import 'package:tulip_tea_mobile_app/presentation/routes/app_routes.dart';

/// Card for a single visit in Visit History list: shop name, visit type, time, reason; trailing arrow.
/// On tap navigates to [VisitDetailsScreen]. Styled to match [MyRequestsCard] and [MyShopsCard].
class VisitHistoryCard extends StatelessWidget {
  const VisitHistoryCard({super.key, required this.visit});

  final ShopVisit visit;

  @override
  Widget build(BuildContext context) {
    final shopName = visit.shopName ?? '${AppTexts.visitTypes} #${visit.id}';
    final visitTypes = AppHelper.parseCommaSeparatedList(visit.visitType);
    final timeStr = AppFormatter.dateTimeFromString(
      visit.visitTime ?? visit.createdAt,
      fallback: AppTexts.notRecorded,
    );
    final reasonStr = visit.reason.isNotNullOrEmpty ? visit.reason! : '–';

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => Get.toNamed(AppRoutes.visitDetails, arguments: visit),
        borderRadius: BorderRadius.circular(AppResponsive.radius(context)),
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppResponsive.radius(context)),
            side: BorderSide(color: AppColors.primary.withValues(alpha: 0.3)),
          ),
          child: Padding(
            padding: AppSpacing.symmetric(context, h: 0.02, v: 0.01),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        shopName,
                        style: AppTextStyles.bodyText(context).copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                          fontFamily: AppFonts.primaryFont,
                        ),
                      ),
                      if (visitTypes.isNotEmpty) ...[
                        AppSpacing.vertical(context, 0.008),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: visitTypes.map((typeValue) {
                            final (color, icon) =
                                AppFormatter.visitTypeChipStyle(typeValue);
                            return Padding(
                              padding: EdgeInsets.only(
                                right: visitTypes.last == typeValue
                                    ? 0
                                    : AppSpacing.horizontalValue(
                                        context,
                                        0.015,
                                      ),
                              ),
                              child: AppStatusChip(
                                status: typeValue,
                                text: AppFormatter.visitTypeDisplay(typeValue),
                                backgroundColor: color,
                                icon: icon,
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                      AppSpacing.vertical(context, 0.008),
                      Text(
                        '${AppTexts.visitTimeLabel}: $timeStr',
                        style: AppTextStyles.hintText(context).copyWith(
                          fontSize: AppResponsive.screenWidth(context) * 0.032,
                        ),
                      ),
                      Text(
                        '${AppTexts.reason}: $reasonStr',
                        style: AppTextStyles.hintText(context).copyWith(
                          fontSize: AppResponsive.screenWidth(context) * 0.032,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Iconsax.arrow_right_3,
                  size: AppResponsive.iconSize(context, factor: 1.1),
                  color: AppColors.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
