import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_custom_app_bar.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/delivery_man/warehouses/warehouse_detail_content.dart';
import 'package:tulip_tea_mobile_app/data/models/warehouse/warehouse_model.dart';

/// Displays full warehouse details: name, address, contact, and inventory.
class DeliveryManWarehouseDetailScreen extends StatelessWidget {
  const DeliveryManWarehouseDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final warehouse = Get.arguments as WarehouseModel?;
    if (warehouse == null) {
      return Scaffold(
        appBar: const AppCustomAppBar(title: AppTexts.warehouseDetails),
        body: const Center(child: Text(AppTexts.notAvailable)),
      );
    }

    final title = warehouse.name ?? AppTexts.warehouseDetails;
    return Scaffold(
      appBar: AppCustomAppBar(title: title),
      body: WarehouseDetailContent(warehouse: warehouse),
    );
  }
}
