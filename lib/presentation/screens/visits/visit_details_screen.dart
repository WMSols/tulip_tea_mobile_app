import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_custom_app_bar.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/visits/visit_details/visit_details_content.dart';
import 'package:tulip_tea_mobile_app/domain/entities/shop_visit.dart';

/// Displays full visit details: shop, visit type, time, location, reason, created.
class VisitDetailsScreen extends StatelessWidget {
  const VisitDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final visit = Get.arguments as ShopVisit?;
    if (visit == null) {
      return Scaffold(
        appBar: const AppCustomAppBar(title: AppTexts.visitHistory),
        body: const Center(child: Text(AppTexts.notAvailable)),
      );
    }

    final title = visit.shopName ?? '${AppTexts.visitId} #${visit.id}';

    return Scaffold(
      appBar: AppCustomAppBar(title: title),
      body: VisitDetailsContent(visit: visit),
    );
  }
}
