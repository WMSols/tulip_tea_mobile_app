import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_status_chip.dart';
import 'package:tulip_tea_mobile_app/domain/entities/credit_limit_request.dart';
import 'package:tulip_tea_mobile_app/presentation/routes/app_routes.dart';

/// Card for a single credit limit request in My Requests list: shop name, requested amount, status chip, trailing arrow.
/// On tap navigates to [MyRequestDetailsScreen].
class MyRequestsCard extends StatelessWidget {
  const MyRequestsCard({super.key, required this.request});

  final CreditLimitRequest request;

  @override
  Widget build(BuildContext context) {
    final shopLabel = request.shopName ??
        '${AppTexts.shopName} #${request.shopId}';
    final requestedStr =
        '${AppTexts.rupeeSymbol} ${request.requestedCreditLimit.toStringAsFixed(0)}';
    final status = request.status ?? '';

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => Get.toNamed(AppRoutes.myRequestDetails, arguments: request),
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
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              shopLabel,
                              style: AppTextStyles.bodyText(context).copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                          if (status.isNotEmpty) AppStatusChip(status: status),
                        ],
                      ),
                      Text(
                        '${AppTexts.requestedLimit}: $requestedStr',
                        style: AppTextStyles.hintText(context).copyWith(
                          fontSize: AppResponsive.screenWidth(context) * 0.032,
                        ),
                      ),
                      if (request.oldCreditLimit != null)
                        Text(
                          '${AppTexts.currentLimit}: ${AppTexts.rupeeSymbol} ${request.oldCreditLimit!.toStringAsFixed(0)}',
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
                  color: AppColors.black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
