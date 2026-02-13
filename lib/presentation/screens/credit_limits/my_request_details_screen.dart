import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_custom_app_bar.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/credit_limits/my_request_details/my_request_details_content.dart';
import 'package:tulip_tea_mobile_app/domain/entities/credit_limit_request.dart';

/// Displays full credit limit request details: account-style rows only.
class MyRequestDetailsScreen extends StatelessWidget {
  const MyRequestDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final request = Get.arguments as CreditLimitRequest?;
    if (request == null) {
      return Scaffold(
        appBar: const AppCustomAppBar(title: AppTexts.myRequests),
        body: const Center(child: Text(AppTexts.notAvailable)),
      );
    }

    final title = request.shopName ??
        '${AppTexts.requestId} #${request.id}';

    return Scaffold(
      appBar: AppCustomAppBar(title: title),
      body: MyRequestDetailsContent(request: request),
    );
  }
}
