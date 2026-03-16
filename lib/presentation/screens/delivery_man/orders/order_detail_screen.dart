import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_custom_app_bar.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/delivery_man/orders/order_detail/order_detail_content.dart';
import 'package:tulip_tea_mobile_app/data/models/delivery/delivery_model.dart';
import 'package:tulip_tea_mobile_app/domain/entities/order_for_delivery_man.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/delivery_man/orders/delivery_man_order_detail_controller.dart';

/// Delivery man order detail: shows order info, delivery timeline, and actions (pickup, deliver, return, verify).
class DeliveryManOrderDetailScreen extends StatelessWidget {
  const DeliveryManOrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<DeliveryManOrderDetailController>();

    // Ensure controller state is refreshed from latest navigation arguments
    final args = Get.arguments;
    if (args is Map) {
      c.order = args['order'] as OrderForDeliveryMan?;
      c.delivery = args['delivery'] as DeliveryModel?;
    }

    final order = c.order;
    if (order == null) {
      return Scaffold(
        appBar: const AppCustomAppBar(title: AppTexts.orderDetails),
        body: const Center(child: Text(AppTexts.notAvailable)),
      );
    }

    final shopName = order.shopName ?? '${AppTexts.shopName} #${order.id}';

    return Scaffold(
      appBar: AppCustomAppBar(title: shopName),
      body: GetBuilder<DeliveryManOrderDetailController>(
        id: null,
        builder: (_) => OrderDetailContent(order: order, controller: c),
      ),
    );
  }
}
