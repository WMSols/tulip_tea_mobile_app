import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_section_card.dart';
import 'package:tulip_tea_mobile_app/core/widgets/form/app_dropdown_field/app_dropdown_field.dart';
import 'package:tulip_tea_mobile_app/data/models/warehouse/warehouse_model.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/delivery_man/deliveries/delivery_man_pickup_controller.dart';

/// Warehouse selection: dropdown only. Single submit (Confirm Pickup) at end of form.
class PickupWarehouseSection extends StatelessWidget {
  const PickupWarehouseSection({super.key, required this.controller});

  final DeliveryManPickupController controller;

  @override
  Widget build(BuildContext context) {
    return AppSectionCard(
      icon: Iconsax.building,
      title: AppTexts.selectWarehouse,
      child: Obx(
        () => AppDropdownField<WarehouseModel>(
          label: AppTexts.warehouseName,
          required: true,
          prefixIcon: Iconsax.building,
          value: controller.warehouses
              .where((w) => w.id == controller.selectedWarehouseId.value)
              .firstOrNull,
          items: controller.warehouses,
          getLabel: (w) =>
              w.name ?? '${AppTexts.warehouseFallbackLabel} #${w.id}',
          onChanged: (w) => controller.selectedWarehouseId.value = w?.id,
        ),
      ),
    );
  }
}
