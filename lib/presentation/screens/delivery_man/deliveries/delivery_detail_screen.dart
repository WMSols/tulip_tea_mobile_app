import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_custom_app_bar.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/delivery_man/deliveries/delivery_detail/delivery_detail_content.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/delivery_man/deliveries/delivery_man_delivery_detail_controller.dart';

/// Delivery detail screen: full order + delivery from list (no API call on open).
class DeliveryManDeliveryDetailScreen extends StatelessWidget {
  const DeliveryManDeliveryDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<DeliveryManDeliveryDetailController>();
    final item = c.item;
    if (item == null) {
      return Scaffold(
        appBar: const AppCustomAppBar(title: AppTexts.deliveries),
        body: const Center(child: Text(AppTexts.notAvailable)),
      );
    }

    final order = c.orderOrItemOrder!;
    final delivery = c.deliveryOrItemDelivery!;
    final shopName =
        order.shopName ?? '${AppTexts.shopName} #${order.shopId ?? order.id}';
    final title = shopName;

    return Scaffold(
      appBar: AppCustomAppBar(title: title),
      body: DeliveryDetailContent(order: order, delivery: delivery),
    );
  }
}
