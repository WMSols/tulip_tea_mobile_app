import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_order_booker/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_order_booker/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_order_booker/core/utils/app_validators/app_validators.dart';
import 'package:tulip_tea_order_booker/core/widgets/buttons/app_button.dart';
import 'package:tulip_tea_order_booker/core/widgets/form/app_dropdown.dart';
import 'package:tulip_tea_order_booker/core/widgets/form/app_text_field.dart';
import 'package:tulip_tea_order_booker/domain/entities/shop.dart';
import 'package:tulip_tea_order_booker/presentation/controllers/visits/daily_collection_controller.dart';

class DailyCollectionScreen extends StatelessWidget {
  const DailyCollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<DailyCollectionController>();
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
              validator: (v) => v == null
                  ? AppValidators.validateRequired(null, AppTexts.selectShop)
                  : null,
            );
          }),
          AppSpacing.vertical(context, 0.02),
          AppTextField(
            label: AppTexts.collectionAmount,
            hint: AppTexts.collectionAmount,
            prefixIcon: Iconsax.wallet_money,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: c.setAmount,
            validator: (v) => AppValidators.validatePositiveNumber(
              v,
              AppTexts.collectionAmount,
            ),
          ),
          AppSpacing.vertical(context, 0.02),
          AppTextField(
            label: AppTexts.collectionRemarks,
            hint: AppTexts.collectionRemarks,
            prefixIcon: Iconsax.note,
            maxLines: 2,
            onChanged: c.setRemarks,
          ),
          AppSpacing.vertical(context, 0.03),
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
