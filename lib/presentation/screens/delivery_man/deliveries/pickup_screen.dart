import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_custom_app_bar.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/delivery_man/deliveries/pickup/pickup_form_content.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/delivery_man/deliveries/delivery_man_pickup_controller.dart';

/// Pickup flow: select warehouse (if no delivery), then confirm pickup quantities.
class DeliveryManPickupScreen extends StatelessWidget {
  const DeliveryManPickupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<DeliveryManPickupController>();
    final order = c.order;
    if (order == null) {
      return Scaffold(
        appBar: const AppCustomAppBar(title: AppTexts.pickupFromWarehouse),
        body: const Center(child: Text(AppTexts.notAvailable)),
      );
    }

    return Scaffold(
      appBar: const AppCustomAppBar(title: AppTexts.pickupFromWarehouse),
      body: PickupFormContent(controller: c),
    );
  }
}
