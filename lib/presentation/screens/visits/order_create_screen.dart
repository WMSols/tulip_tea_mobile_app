import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_order_booker/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_order_booker/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_order_booker/core/widgets/buttons/app_button.dart';
import 'package:tulip_tea_order_booker/core/widgets/form/app_dropdown.dart';
import 'package:tulip_tea_order_booker/core/widgets/form/app_text_field.dart';
import 'package:tulip_tea_order_booker/domain/entities/product.dart';
import 'package:tulip_tea_order_booker/domain/entities/shop.dart';
import 'package:tulip_tea_order_booker/presentation/controllers/visits/order_create_controller.dart';

class OrderCreateScreen extends StatelessWidget {
  const OrderCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<OrderCreateController>();
    if (c.orderLines.isEmpty) c.addLine();
    return SingleChildScrollView(
      padding: AppSpacing.symmetric(context, h: 0.05, v: 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppSpacing.vertical(context, 0.01),
          Obx(() {
            Shop? selectedShop;
            if (c.selectedShopId.value != null && c.shops.isNotEmpty) {
              try {
                selectedShop = c.shops.firstWhere(
                  (s) => s.id == c.selectedShopId.value,
                );
              } catch (_) {}
            }
            return AppDropdown<Shop>(
              label: AppTexts.selectShop,
              hint: AppTexts.selectShop,
              value: selectedShop,
              items: c.shops,
              getLabel: (s) => s.name,
              onChanged: (s) => c.setSelectedShopId(s?.id),
              validator: (v) => v == null ? 'Select shop' : null,
            );
          }),
          AppSpacing.vertical(context, 0.02),
          AppTextField(
            label: AppTexts.scheduledDeliveryDate,
            hint: AppTexts.scheduledDeliveryDate,
            prefixIcon: Iconsax.calendar_1,
            onChanged: c.setScheduledDate,
          ),
          AppSpacing.vertical(context, 0.02),
          Text(AppTexts.product, style: Theme.of(context).textTheme.titleSmall),
          AppSpacing.vertical(context, 0.01),
          Obx(
            () => Column(
              children: List.generate(c.orderLines.length, (i) {
                final line = c.orderLines[i];
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: AppSpacing.verticalValue(context, 0.015),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: AppDropdown<Product?>(
                          hint: AppTexts.selectProduct,
                          value: line.product,
                          items: [null, ...c.products],
                          getLabel: (p) => p?.name ?? '-',
                          onChanged: (p) => c.setLineProduct(i, p),
                        ),
                      ),
                      AppSpacing.horizontal(context, 0.02),
                      Expanded(
                        child: AppTextField(
                          hint: AppTexts.quantity,
                          keyboardType: TextInputType.number,
                          onChanged: (v) =>
                              c.setLineQuantity(i, int.tryParse(v) ?? 0),
                        ),
                      ),
                      AppSpacing.horizontal(context, 0.02),
                      Expanded(
                        child: AppTextField(
                          hint: AppTexts.unitPrice,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          onChanged: (v) =>
                              c.setLineUnitPrice(i, double.tryParse(v) ?? 0),
                        ),
                      ),
                      IconButton(
                        onPressed: () => c.removeLine(i),
                        icon: const Icon(Iconsax.trash, color: Colors.red),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
          TextButton.icon(
            onPressed: c.addLine,
            icon: const Icon(Iconsax.add),
            label: Text(AppTexts.addOrderLine),
          ),
          AppSpacing.vertical(context, 0.02),
          Obx(
            () => AppButton(
              label: AppTexts.submit,
              onPressed: c.submit,
              isLoading: c.isSubmitting.value,
              icon: Iconsax.tick_circle,
              iconPosition: IconPosition.right,
            ),
          ),
          AppSpacing.vertical(context, 0.03),
        ],
      ),
    );
  }
}
