import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_custom_app_bar.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/delivery_man/deliveries/return/return_form_content.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/delivery_man/deliveries/delivery_man_return_controller.dart';

/// Return flow: quantities, reason, confirm return.
class DeliveryManReturnScreen extends StatelessWidget {
  const DeliveryManReturnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<DeliveryManReturnController>();
    final order = c.order;
    final delivery = c.delivery;
    if (order == null || delivery == null) {
      return Scaffold(
        appBar: const AppCustomAppBar(title: AppTexts.returnToWarehouse),
        body: const Center(child: Text(AppTexts.notAvailable)),
      );
    }

    return Scaffold(
      appBar: const AppCustomAppBar(title: AppTexts.returnToWarehouse),
      body: GetBuilder<DeliveryManReturnController>(
        builder: (_) => ReturnFormContent(controller: c),
      ),
    );
  }
}
