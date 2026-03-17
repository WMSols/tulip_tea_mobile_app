import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_custom_app_bar.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/delivery_man/deliveries/deliver/deliver_form_content.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/delivery_man/deliveries/delivery_man_deliver_controller.dart';

/// Deliver flow: quantities, remarks, confirm delivery.
class DeliveryManDeliverScreen extends StatelessWidget {
  const DeliveryManDeliverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<DeliveryManDeliverController>();
    c.applyArguments();
    final order = c.order;
    final delivery = c.delivery;
    if (order == null || delivery == null) {
      return Scaffold(
        appBar: const AppCustomAppBar(title: AppTexts.deliverToShop),
        body: const Center(child: Text(AppTexts.notAvailable)),
      );
    }

    return Scaffold(
      appBar: const AppCustomAppBar(title: AppTexts.deliverToShop),
      body: GetBuilder<DeliveryManDeliverController>(
        builder: (_) => DeliverFormContent(controller: c),
      ),
    );
  }
}
