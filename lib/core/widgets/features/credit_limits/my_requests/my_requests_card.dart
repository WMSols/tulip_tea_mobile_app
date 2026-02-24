import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_formatter/app_formatter.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_fonts/app_fonts.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/buttons/app_icon_button.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_status_chip.dart';
import 'package:tulip_tea_mobile_app/core/widgets/feedback/app_toast.dart';
import 'package:tulip_tea_mobile_app/domain/entities/credit_limit_request.dart';
import 'package:tulip_tea_mobile_app/presentation/routes/app_routes.dart';

/// Card for a single credit limit request in My Requests list: shop name, requested amount, status chip, trailing arrow.
/// On tap navigates to [MyRequestDetailsScreen].
/// For disapproved requests, shows a "Request again" [AppIconButton]; if [is_active] is false, tap shows error toast and no navigation.
/// When [is_active] is false, shows "This request is deleted by distributor" under current limit.
class MyRequestsCard extends StatelessWidget {
  const MyRequestsCard({super.key, required this.request});

  final CreditLimitRequest request;

  static bool _isDisapproved(CreditLimitRequest r) {
    final status = r.status?.toLowerCase().trim() ?? '';
    return status == 'disapproved' || status.contains('reject');
  }

  static bool _isInactive(CreditLimitRequest r) => r.isActive == false;

  @override
  Widget build(BuildContext context) {
    final shopLabel =
        request.shopName ?? '${AppTexts.shopName} #${request.shopId}';
    final requestedStr = AppFormatter.formatCurrency(
      request.requestedCreditLimit,
    );
    final status = request.status ?? '';
    final isDisapproved = _isDisapproved(request);
    final isInactive = _isInactive(request);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () =>
            Get.toNamed(AppRoutes.myRequestDetails, arguments: request),
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
                                fontFamily: AppFonts.primaryFont,
                              ),
                            ),
                          ),
                          if (status.isNotEmpty) AppStatusChip(status: status),
                          if (isDisapproved)
                            Padding(
                              padding: AppSpacing.symmetric(
                                context,
                                h: 0.02,
                                v: 0,
                              ).copyWith(right: 0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: AppIconButton(
                                  icon: Iconsax.edit_2,
                                  backgroundColor: AppColors.error,
                                  color: AppColors.white,
                                  onPressed: () {
                                    if (isInactive) {
                                      AppToast.showError(
                                        AppTexts.error,
                                        AppTexts.cannotResubmitDeletedRequest,
                                      );
                                      return;
                                    }
                                    Get.toNamed(
                                      AppRoutes.requestAgain,
                                      arguments: request,
                                    );
                                  },
                                  paddingFactor: 0.4,
                                ),
                              ),
                            ),
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
                          '${AppTexts.currentLimit}: ${AppFormatter.formatCurrency(request.oldCreditLimit!)}',
                          style: AppTextStyles.hintText(context).copyWith(
                            fontSize:
                                AppResponsive.screenWidth(context) * 0.032,
                          ),
                        ),
                      if (isInactive)
                        Text(
                          AppTexts.requestDeletedByDistributor,
                          style: AppTextStyles.hintText(context).copyWith(
                            fontSize:
                                AppResponsive.screenWidth(context) * 0.03,
                            color: AppColors.error,
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
