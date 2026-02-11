import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_order_booker/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_order_booker/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_order_booker/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_order_booker/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_order_booker/core/widgets/buttons/app_button.dart';
import 'package:tulip_tea_order_booker/core/widgets/buttons/app_text_button.dart';
import 'package:tulip_tea_order_booker/core/widgets/form/app_dropdown_field/app_dropdown_field.dart';
import 'package:tulip_tea_order_booker/core/widgets/form/app_text_field/app_text_field.dart';
import 'package:tulip_tea_order_booker/domain/entities/product.dart';
import 'package:tulip_tea_order_booker/domain/entities/shop.dart';
import 'package:tulip_tea_order_booker/presentation/controllers/visits/visit_register_controller.dart';

class VisitRegisterScreen extends StatefulWidget {
  const VisitRegisterScreen({super.key});

  @override
  State<VisitRegisterScreen> createState() => _VisitRegisterScreenState();
}

class _VisitRegisterScreenState extends State<VisitRegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final c = Get.find<VisitRegisterController>();
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
                // validator: (v) => v == null
                //     ? AppValidators.validateRequired(null, AppTexts.selectShop)
                //     : null,
              );
            }),
            AppSpacing.vertical(context, 0.02),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppTexts.selectVisitTypes,
                  style: AppTextStyles.labelText(context),
                ),
                Text(
                  ' *',
                  style: AppTextStyles.labelText(
                    context,
                  ).copyWith(color: AppColors.error),
                ),
              ],
            ),
            AppSpacing.vertical(context, 0.01),
            Obx(() {
              final options = [
                (AppTexts.orderBooking, 'order_booking'),
                (AppTexts.dailyCollections, 'daily_collections'),
                (AppTexts.inspection, 'inspection'),
                (AppTexts.other, 'other'),
              ];
              return Wrap(
                spacing: AppSpacing.horizontalValue(context, 0.02),
                runSpacing: AppSpacing.verticalValue(context, 0.01),
                children: options.map((e) {
                  final selected = c.selectedVisitTypes.contains(e.$2);
                  return FilterChip(
                    label: Text(e.$1),
                    selected: selected,
                    onSelected: (_) => c.toggleVisitType(e.$2),
                  );
                }).toList(),
              );
            }),
            AppSpacing.vertical(context, 0.02),
            AppTextField(
              label: AppTexts.latitude,
              hint: AppTexts.gpsLocation,
              prefixIcon: Iconsax.location,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              onChanged: c.setGpsLat,
            ),
            AppSpacing.vertical(context, 0.02),
            AppTextField(
              label: AppTexts.longitude,
              hint: AppTexts.gpsLocation,
              prefixIcon: Iconsax.location,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              onChanged: c.setGpsLng,
            ),
            AppSpacing.vertical(context, 0.02),
            AppTextField(
              label: AppTexts.reason,
              hint: AppTexts.reason,
              prefixIcon: Iconsax.note,
              maxLines: 2,
              onChanged: c.setReason,
            ),
            AppSpacing.vertical(context, 0.02),
            Text(
              AppTexts.orderItemsDuringVisit,
              style: AppTextStyles.labelText(context),
            ),
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
                          onPressed: () => c.removeOrderLine(i),
                          icon: Icon(Iconsax.trash, color: AppColors.error),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
            AppTextButton(
              label: AppTexts.addOrderItem,
              onPressed: c.addOrderLine,
              icon: Iconsax.add,
              iconPosition: IconPosition.left,
            ),
            AppSpacing.vertical(context, 0.03),
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
