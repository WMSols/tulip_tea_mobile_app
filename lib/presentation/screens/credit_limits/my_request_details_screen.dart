import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/widgets/buttons/app_icon_button.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_custom_app_bar.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/credit_limits/my_request_details/my_request_details_content.dart';
import 'package:tulip_tea_mobile_app/core/widgets/feedback/app_toast.dart';
import 'package:tulip_tea_mobile_app/domain/entities/credit_limit_request.dart';
import 'package:tulip_tea_mobile_app/presentation/routes/app_routes.dart';

/// Displays full credit limit request details.
/// For disapproved requests, app bar shows a "Request again" action; if [is_active] is false, tap shows error toast and no navigation.
class MyRequestDetailsScreen extends StatelessWidget {
  const MyRequestDetailsScreen({super.key});

  static bool _isDisapproved(CreditLimitRequest request) {
    final status = request.status?.toLowerCase().trim() ?? '';
    return status == 'disapproved' || status.contains('reject');
  }

  static bool _isInactive(CreditLimitRequest request) =>
      request.isActive == false;

  @override
  Widget build(BuildContext context) {
    final request = Get.arguments as CreditLimitRequest?;
    if (request == null) {
      return Scaffold(
        appBar: const AppCustomAppBar(title: AppTexts.myRequests),
        body: const Center(child: Text(AppTexts.notAvailable)),
      );
    }

    final title = request.shopName ?? '${AppTexts.requestId} #${request.id}';

    return Scaffold(
      appBar: AppCustomAppBar(
        title: title,
        actions: _isDisapproved(request)
            ? [
                Padding(
                  padding: AppSpacing.symmetric(context, h: 0.04, v: 0),
                  child: AppIconButton(
                    icon: Iconsax.edit,
                    onPressed: () {
                      if (_isInactive(request)) {
                        AppToast.showError(
                          AppTexts.error,
                          AppTexts.cannotResubmitDeletedRequest,
                        );
                        return;
                      }
                      Get.toNamed(AppRoutes.requestAgain, arguments: request);
                    },
                    color: AppColors.white,
                  ),
                ),
              ]
            : null,
      ),
      body: MyRequestDetailsContent(request: request),
    );
  }
}
