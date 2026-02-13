import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/buttons/app_button.dart';
import 'package:tulip_tea_mobile_app/core/widgets/feedback/app_dropdown_field_loading_placeholder.dart';
import 'package:tulip_tea_mobile_app/core/widgets/form/app_dropdown_field/app_dropdown_field.dart';
import 'package:tulip_tea_mobile_app/core/widgets/form/app_text_field/app_text_field.dart';
import 'package:tulip_tea_mobile_app/domain/entities/shop.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/credit_limits/credit_limit_request_controller.dart';

/// Reusable credit limit request form: shop dropdown, requested amount, remarks, submit.
class CreditLimitRequestForm extends StatelessWidget {
  const CreditLimitRequestForm({
    super.key,
    required this.controller,
    required this.formKey,
  });

  final CreditLimitRequestController controller;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    final c = controller;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppSpacing.vertical(context, 0.01),
        Text(
          AppTexts.requestCreditLimitChangeDescription,
          style: AppTextStyles.hintText(context),
        ),
        AppSpacing.vertical(context, 0.02),
        Obx(() {
          if (c.isLoadingShops.value) {
            return AppDropdownFieldLoadingPlaceholder(
              label: AppTexts.selectShopForRequest,
              hint: AppTexts.selectShopForRequest,
              required: true,
              prefixIcon: Iconsax.shop,
            );
          }
          if (c.shops.isEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppDropdownFieldLoadingPlaceholder(
                  label: AppTexts.selectShopForRequest,
                  hint: AppTexts.noShopsYet,
                  required: true,
                  prefixIcon: Iconsax.shop,
                ),
              ],
            );
          }
          Shop? selectedShop;
          if (c.selectedShopId.value != null) {
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
                items: c.shops.toList(),
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
            onPressed: c.submit,
            isLoading: c.isSubmitting.value,
            icon: Iconsax.tick_circle,
            iconPosition: IconPosition.right,
          ),
        ),
        AppSpacing.vertical(context, 0.03),
      ],
    );
  }
}
