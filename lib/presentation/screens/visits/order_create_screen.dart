import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/buttons/app_button.dart';
import 'package:tulip_tea_mobile_app/core/widgets/buttons/app_text_button.dart';
import 'package:tulip_tea_mobile_app/core/widgets/form/app_dropdown_field/app_dropdown_field.dart';
import 'package:tulip_tea_mobile_app/core/widgets/form/app_text_field/app_text_field.dart';
import 'package:tulip_tea_mobile_app/domain/entities/product.dart';
import 'package:tulip_tea_mobile_app/domain/entities/shop.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/visits/order_create_controller.dart';

class OrderCreateScreen extends StatefulWidget {
  const OrderCreateScreen({super.key});

  @override
  State<OrderCreateScreen> createState() => _OrderCreateScreenState();
}

class _OrderCreateScreenState extends State<OrderCreateScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final c = Get.find<OrderCreateController>();
    if (c.orderLines.isEmpty) c.addLine();
    return SingleChildScrollView(
      padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
      child: Form(
        key: _formKey,
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
              return AppDropdownField<Shop>(
                label: AppTexts.selectShop,
                hint: AppTexts.selectShop,
                required: true,
                value: selectedShop,
                items: c.shops,
                getLabel: (s) => s.name,
                onChanged: (s) => c.setSelectedShopId(s?.id),
                // validator: (v) => v == null ? 'Select shop' : null,
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
            AppTextField(
              label: AppTexts.finalTotalAmount,
              hint: AppTexts.finalTotalAmount,
              prefixIcon: Iconsax.wallet_3,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              onChanged: c.setFinalTotalAmount,
            ),
            AppSpacing.vertical(context, 0.02),
            Text(AppTexts.product, style: AppTextStyles.labelText(context)),
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
                          child: AppDropdownField<Product?>(
                            hint: AppTexts.selectProduct,
                            value: line.product,
                            items: [null, ...c.products],
                            getLabel: (p) {
                              if (p == null) return '-';
                              final code = p.code?.trim() ?? '';
                              return code.isEmpty
                                  ? p.name
                                  : '${p.code} • ${p.name}';
                            },
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
                          icon: Icon(Iconsax.trash, color: AppColors.error),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
            AppTextButton(
              label: AppTexts.addOrderLine,
              onPressed: c.addLine,
              icon: Iconsax.add,
              iconPosition: IconPosition.left,
            ),
            AppSpacing.vertical(context, 0.02),
            Obx(
              () => AppButton(
                label: AppTexts.submit,
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    c.submit();
                  }
                },
                isLoading: c.isSubmitting.value,
                icon: Iconsax.tick_circle,
                iconPosition: IconPosition.right,
              ),
            ),
            AppSpacing.vertical(context, 0.03),
          ],
        ),
      ),
    );
  }
}
