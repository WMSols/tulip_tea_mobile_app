import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_custom_app_bar.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/delivery_man/deliveries/deliveries_list_content.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/delivery_man/deliveries/delivery_man_deliveries_controller.dart';

/// Completed deliveries list with status filter.
class DeliveryManDeliveriesScreen extends StatelessWidget {
  const DeliveryManDeliveriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<DeliveryManDeliveriesController>();
    return Scaffold(
      appBar: const AppCustomAppBar(title: AppTexts.deliveries),
      body: SafeArea(child: DeliveriesListContent(controller: c)),
    );
  }
}
