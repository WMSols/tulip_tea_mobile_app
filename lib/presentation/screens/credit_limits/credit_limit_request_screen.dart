import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_order_booker/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_order_booker/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_order_booker/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_order_booker/core/widgets/buttons/app_button.dart';
import 'package:tulip_tea_order_booker/core/widgets/form/app_dropdown_field/app_dropdown_field.dart';
import 'package:tulip_tea_order_booker/core/widgets/form/app_text_field/app_text_field.dart';
import 'package:tulip_tea_order_booker/domain/entities/shop.dart';
import 'package:tulip_tea_order_booker/presentation/controllers/credit_limits/credit_limit_request_controller.dart';

class CreditLimitRequestScreen extends StatefulWidget {
  const CreditLimitRequestScreen({super.key});

  @override
  State<CreditLimitRequestScreen> createState() =>
      _CreditLimitRequestScreenState();
}

class _CreditLimitRequestScreenState extends State<CreditLimitRequestScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final c = Get.find<CreditLimitRequestController>();
    return SingleChildScrollView(
      padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppSpacing.vertical(context, 0.01),
            Text(
              AppTexts.requestCreditLimitChangeDescription,
              style: AppTextStyles.hintText(context),
            ),
            AppSpacing.vertical(context, 0.02),
            Obx(() {
              Shop? selectedShop;
              if (c.selectedShopId.value != null && c.shops.isNotEmpty) {
                try {
                  selectedShop = c.shops.firstWhere(
                    (s) => s.id == c.selectedShopId.value,
                  );
                } catch (_) {}
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppDropdownField<Shop>(
                    label: AppTexts.selectShopForRequest,
                    hint: AppTexts.selectShopForRequest,
                    required: true,
                    value: selectedShop,
                    items: c.shops,
                    getLabel: (s) => s.name,
                    onChanged: (s) => c.setSelectedShopId(s?.id),
                  ),
                  if (selectedShop != null) ...[
                    AppSpacing.vertical(context, 0.01),
                    Text(
                      '${AppTexts.currentCreditLimit}: ${AppTexts.rupeeSymbol} ${selectedShop.creditLimit?.toStringAsFixed(0) ?? "0"}',
                      style: AppTextStyles.hintText(context),
                    ),
                  ],
                ],
              );
            }),
            AppSpacing.vertical(context, 0.02),
            AppTextField(
              label: AppTexts.requestedCreditLimit,
              hint: AppTexts.requestedCreditLimit,
              required: true,
              prefixIcon: Iconsax.wallet_3,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              onChanged: c.setRequestedCreditLimit,
            ),
            AppSpacing.vertical(context, 0.02),
            AppTextField(
              label: AppTexts.remarks,
              hint: AppTexts.remarks,
              prefixIcon: Iconsax.note,
              maxLines: 2,
              onChanged: c.setRemarks,
            ),
            AppSpacing.vertical(context, 0.03),
            Obx(
              () => AppButton(
                label: AppTexts.submit,
                onPressed: () {
                  if (c.selectedShopId.value == null) {
                    Get.snackbar(
                      AppTexts.error,
                      AppTexts.selectShopForRequest,
                      snackPosition: SnackPosition.BOTTOM,
                    );
                    return;
                  }
                  final amount = double.tryParse(
                    c.requestedCreditLimit.value.trim(),
                  );
                  if (amount == null || amount < 0) {
                    Get.snackbar(
                      AppTexts.error,
                      AppTexts.enterValidRequestedCreditLimit,
                      snackPosition: SnackPosition.BOTTOM,
                    );
                    return;
                  }
                  c.submit();
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
