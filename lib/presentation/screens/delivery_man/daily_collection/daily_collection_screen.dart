import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_custom_app_bar.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/delivery_man/daily_collection/daily_collection_content.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/delivery_man/daily_collection_controller.dart';

/// Daily Collection screen: Shop Credit Information, Collection Amount, Remarks, Submit.
class DailyCollectionScreen extends StatelessWidget {
  const DailyCollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<DailyCollectionController>();
    final order = c.order;
    if (order == null) {
      return Scaffold(
        appBar: const AppCustomAppBar(title: AppTexts.dailyCollectionLabel),
        body: const Center(child: Text(AppTexts.notAvailable)),
      );
    }
    return Scaffold(
      appBar: AppCustomAppBar(title: AppTexts.dailyCollectionLabel),
      body: DailyCollectionContent(controller: c),
    );
  }
}
